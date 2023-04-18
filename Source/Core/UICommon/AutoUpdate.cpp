// Copyright 2018 Dolphin Emulator Project
// SPDX-License-Identifier: GPL-2.0-or-later

#include "UICommon/AutoUpdate.h"

#include <string>

#include <fmt/format.h>
#include <picojson.h>

#include "Common/CommonFuncs.h"
#include "Common/CommonPaths.h"
#include "Common/FileUtil.h"
#include "Common/HttpRequest.h"
#include "Common/Logging/Log.h"
#include "Common/MsgHandler.h"
#include "Common/StringUtil.h"
#include "Common/Version.h"

#ifdef _WIN32
#include <Windows.h>
#endif

#ifdef __APPLE__
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#endif

#if defined(_WIN32) || defined(__APPLE__)
#define OS_SUPPORTS_UPDATER
#endif

// Refer to docs/autoupdate_overview.md for a detailed overview of the autoupdate process

namespace
{
bool s_update_triggered = false;

#ifdef __APPLE__
const char UPDATER_CONTENT_PATH[] = "/Contents/MacOS/Dolphin Updater";
#endif

#ifdef OS_SUPPORTS_UPDATER

const char UPDATER_LOG_FILE[] = "Updater.log";

std::string UpdaterPath(bool relocated = false)
{
  std::string path(File::GetExeDirectory() + DIR_SEP);
#ifdef __APPLE__
  if (relocated)
    path += ".Dolphin Updater.2.app";
  else
    path += "Dolphin Updater.app";
  return path;
#else
  return path + "Updater.exe";
#endif
}

std::string MakeUpdaterCommandLine(const std::map<std::string, std::string>& flags)
{
#ifdef __APPLE__
  std::string cmdline = "\"" + UpdaterPath(true) + UPDATER_CONTENT_PATH + "\"";
#else
  std::string cmdline = UpdaterPath();
#endif

  cmdline += " ";

  for (const auto& pair : flags)
  {
    std::string value = "--" + pair.first + "=" + pair.second;
    value = ReplaceAll(value, "\"", "\\\"");  // Escape double quotes.
    value = "\"" + value + "\" ";
    cmdline += value;
  }
  return cmdline;
}

#ifdef __APPLE__
void CleanupFromPreviousUpdate()
{
  // Remove the relocated updater file.
  File::DeleteDirRecursively(UpdaterPath(true));
}
#endif

#endif

// This ignores i18n because most of the text in there (change descriptions) is only going to be
// written in english anyway.
std::string GenerateChangelog(const picojson::array& versions)
{
  std::string changelog;
  for (const auto& ver : versions)
  {
    if (!ver.is<picojson::object>())
      continue;
    picojson::object ver_obj = ver.get<picojson::object>();

    if (ver_obj["changelog_html"].is<picojson::null>())
    {
      if (!changelog.empty())
        changelog += "<div style=\"margin-top: 0.4em;\"></div>";  // Vertical spacing.

      // Try to link to the PR if we have this info. Otherwise just show shortrev.
      if (ver_obj["pr_url"].is<std::string>())
      {
        changelog += "<a href=\"" + ver_obj["pr_url"].get<std::string>() + "\">" +
                     ver_obj["shortrev"].get<std::string>() + "</a>";
      }
      else
      {
        changelog += ver_obj["shortrev"].get<std::string>();
      }
      const std::string escaped_description =
          GetEscapedHtml(ver_obj["short_descr"].get<std::string>());
      changelog += " by <a href = \"" + ver_obj["author_url"].get<std::string>() + "\">" +
                   ver_obj["author"].get<std::string>() + "</a> &mdash; " + escaped_description;
    }
    else
    {
      if (!changelog.empty())
        changelog += "<hr>";
      changelog += "<b>Dolphin " + ver_obj["shortrev"].get<std::string>() + "</b>";
      changelog += "<p>" + ver_obj["changelog_html"].get<std::string>() + "</p>";
    }
  }
  return changelog;
}
}  // namespace

bool AutoUpdateChecker::SystemSupportsAutoUpdates()
{
#if defined(AUTOUPDATE) && defined(OS_SUPPORTS_UPDATER)
  return true;
#else
  return false;
#endif
}
/*
static std::string GetPlatformID()
{
#if defined(_WIN32)
#if defined(_M_ARM_64)
  return "win-arm64";
#else
  return "win";
#endif
#elif defined(__APPLE__)
#if defined(MACOS_UNIVERSAL_BUILD)
  return "macos-universal";
#else
  return "macos";
#endif
#else
  return "unknown";
#endif
}
*/
void AutoUpdateChecker::CheckForUpdate(std::string_view update_track,
                                       std::string_view hash_override, const CheckType check_type)
{
#ifdef __APPLE__
  CleanupFromPreviousUpdate();
#endif

  // This url returns a json containing info about the latest release
  std::string url = "https://api.github.com/repos/Rocci1212/spooky-dolphin/releases/latest";
  Common::HttpRequest::Headers headers = {
      {"user-agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like "
                     "Gecko) Chrome/97.0.4692.71 Safari/537.36"}};

  Common::HttpRequest req{std::chrono::seconds{10}};
  auto resp = req.Get(url, headers);
  if (!resp)
  {
    ERROR_LOG_FMT(COMMON, "Auto-update request failed");
  }
  
  const std::string contents(reinterpret_cast<char*>(resp->data()), resp->size());
  INFO_LOG_FMT(COMMON, "Auto-update JSON response: {}", contents);

  picojson::value json;
  const std::string err = picojson::parse(json, contents);
  if (!err.empty())
  {
    CriticalAlertFmtT("Invalid JSON received from auto-update service : {0}", err);
    return;
  }
  picojson::object obj = json.get<picojson::object>();

  std::string local_version_num[3] = {"", "", ""};
  std::string github_version_num[3] = {"", "", ""};

  std::istringstream f(Common::GetSpookyRevStr());
  std::string s;

  int i = 0;
  while (std::getline(f, s, '.'))
  {
    local_version_num[i] = s;
    i++;
  }

  i = 0;
  std::istringstream g(obj["tag_name"].get<std::string>());
  while (std::getline(g, s, '.'))
  {
    github_version_num[i] = s;
    i++;
  }

  // check if latest version == current
  if (local_version_num[0] > github_version_num[0])
  {
    INFO_LOG_FMT(COMMON, "Auto-update status: we are up to date.");
    return;
  }
  else if (local_version_num[0] == github_version_num[0])
  {
    if (local_version_num[1] > github_version_num[1])
    {
      INFO_LOG_FMT(COMMON, "Auto-update status: we are up to date.");
      return;
    }
    else if (local_version_num[1] == github_version_num[1])
    {
      if (local_version_num[2] >= github_version_num[2])
      {
        INFO_LOG_FMT(COMMON, "Auto-update status: we are up to date.");
        return;
      }
    }
  }

  OnUpdateAvailable(obj["tag_name"].get<std::string>());
}

void AutoUpdateChecker::TriggerUpdate(const AutoUpdateChecker::NewVersionInformation& info,
                                      const AutoUpdateChecker::RestartMode restart_mode)
{
  // Check to make sure we don't already have an update triggered
  if (s_update_triggered)
  {
    WARN_LOG_FMT(COMMON, "Auto-update: received a redundant trigger request, ignoring");
    return;
  }

  s_update_triggered = true;
#ifdef OS_SUPPORTS_UPDATER
  std::map<std::string, std::string> updater_flags;
  updater_flags["this-manifest-url"] = info.this_manifest_url;
  updater_flags["next-manifest-url"] = info.next_manifest_url;
  updater_flags["content-store-url"] = info.content_store_url;
#ifdef _WIN32
  updater_flags["parent-pid"] = std::to_string(GetCurrentProcessId());
#else
  updater_flags["parent-pid"] = std::to_string(getpid());
#endif
  updater_flags["install-base-path"] = File::GetExeDirectory();
  updater_flags["log-file"] = File::GetUserPath(D_LOGS_IDX) + UPDATER_LOG_FILE;

  if (restart_mode == RestartMode::RESTART_AFTER_UPDATE)
    updater_flags["binary-to-restart"] = File::GetExePath();

#ifdef __APPLE__
  // Copy the updater so it can update itself if needed.
  const std::string reloc_updater_path = UpdaterPath(true);
  if (!File::CopyDir(UpdaterPath(), reloc_updater_path))
  {
    CriticalAlertFmtT("Unable to create updater copy.");
    return;
  }
  if (chmod((reloc_updater_path + UPDATER_CONTENT_PATH).c_str(), 0700) != 0)
  {
    CriticalAlertFmtT("Unable to set permissions on updater copy.");
    return;
  }
#endif

  // Run the updater!
  std::string command_line = MakeUpdaterCommandLine(updater_flags);
  INFO_LOG_FMT(COMMON, "Updater command line: {}", command_line);

#ifdef _WIN32
  STARTUPINFO sinfo{.cb = sizeof(sinfo)};
  sinfo.dwFlags = STARTF_FORCEOFFFEEDBACK;  // No hourglass cursor after starting the process.
  PROCESS_INFORMATION pinfo;
  if (CreateProcessW(UTF8ToWString(UpdaterPath()).c_str(), UTF8ToWString(command_line).data(),
                     nullptr, nullptr, FALSE, 0, nullptr, nullptr, &sinfo, &pinfo))
  {
    CloseHandle(pinfo.hThread);
    CloseHandle(pinfo.hProcess);
  }
  else
  {
    const std::string error = GetLastErrorString();
    CriticalAlertFmtT("Could not start updater process: {0}", error);
  }
#else
  if (popen(command_line.c_str(), "r") == nullptr)
  {
    const std::string error = LastStrerrorString();
    CriticalAlertFmtT("Could not start updater process: {0}", error);
  }
#endif

#endif
}
