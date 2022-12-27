#include "Metadata.h"
#include <Common/FileUtil.h>
#include <Core/HW/Memmap.h>
#include <Core/HW/AddressSpace.h>
#include <../minizip/mz_compat.h>
#include <codecvt>
#include "zip.h"
#include "Common/CommonPaths.h"
#include "Common/FileUtil.h"
#include <Core/StateAuxillary.h>

static tm* matchDateTime;
static int homeTeamPossesionFrameCount;
static int awayTeamPossesionFrameCount;
static std::string playerName = "";
std::vector<const NetPlay::Player*> playerArray;
static NetPlay::PadMappingArray netplayGCMap;

static u16 controllerPort1;
static u16 controllerPort2;
static u16 controllerPort3;
static u16 controllerPort4;
static std::vector<int> controllerVector(4);

static u32 homeCaptainID;
static u32 awayCaptainID;
static u32 homeSidekick1;
static u32 awaySidekick1;
static u32 homeSidekick2;
static u32 awaySidekick2;
static u32 homeSidekick3;
static u32 awaySidekick3;

static u32 stadiumID;
static u32 overtimeNotReached;
static u32 timeElapsed;

static u16 homeScore;
static u16 awayScore;

static std::array<u8, 16> md5Hash;

std::string Metadata::getJSONString()
{
  char date_string[100];
  char file_name[100];
  strftime(date_string, 50, "%B %d %Y %OH:%OM:%OS", matchDateTime);
  strftime(file_name, 50, "%B_%d_%Y_%OH_%OM_%OS", matchDateTime);
  std::string convertedDate(file_name);
  std::string file_name_string = "Game_" + convertedDate + ".cit";

  std::stringstream json_stream;
  json_stream << "{" << std::endl;
  json_stream << "  \"File Name\": \"" << file_name_string << "\"," << std::endl;
  json_stream << "  \"Date\": \"" << date_string << "\"," << std::endl;
  std::string md5String = "";
  for (int i = 0; i < md5Hash.size(); i++)
  {
    md5String += std::format("{:x}", md5Hash[i]);
  }
  json_stream << "  \"Game Hash\": \"" << md5String << "\"," << std::endl;
  json_stream << "  \"Controller Port Info\": {" << std::endl;
  for (int i = 0; i < 4; i++)
  {
    if (i != 3)
    {
      json_stream << "    \"Controller Port " + std::to_string(i) + "\": "
                  << std::to_string(controllerVector.at(i)) << "," << std::endl;
    }
    else
    {
      // no comma cuz end
      json_stream << "    \"Controller Port " + std::to_string(i) + "\": "
                  << std::to_string(controllerVector.at(i)) << std::endl;
    }
  }
  json_stream << "   }," << std::endl;
  json_stream << "  \"Home Captain ID\": \"" << homeCaptainID << "\"," << std::endl;
  json_stream << "  \"Home Top Wing\": \"" << homeSidekick1 << "\"," << std::endl;
  json_stream << "  \"Home Bottom Wing\": \"" << homeSidekick2 << "\"," << std::endl;
  json_stream << "  \"Home Sweeper\": \"" << homeSidekick3 << "\"," << std::endl;
  json_stream << "  \"Away Captain ID\": \"" << awayCaptainID << "\"," << std::endl;
  json_stream << "  \"Away Top Wing\": \"" << awaySidekick1 << "\"," << std::endl;
  json_stream << "  \"Away Bottom Wing\": \"" << awaySidekick2 << "\"," << std::endl;
  json_stream << "  \"Away Sweeper\": \"" << awaySidekick3 << "\"," << std::endl;
  json_stream << "  \"Score\": \"" << homeScore << "-" << awayScore << "\"," << std::endl;
  json_stream << "  \"Stadium ID\": \"" << stadiumID << "\"," << std::endl;

  json_stream << "  \"Home Match Stats\": {" << std::endl;
  json_stream << "    \"Goals\": \"" << homeScore << "\"," << std::endl;
  json_stream << "   }," << std::endl;

  json_stream << "  \"Away Match Stats\": {" << std::endl;
  json_stream << "    \"Goals\": \"" << awayScore << "\"," << std::endl;
  json_stream << "   }," << std::endl;

  json_stream << "  \"Netplay Match\": \"" << NetPlay::IsNetPlayRunning() << "\"," << std::endl;

  json_stream << "  \"Overtime Not Reached\": \"" << overtimeNotReached << "\"," << std::endl;

  json_stream << "  \"Left Team Frames Possessed Ball\": \"" << homeTeamPossesionFrameCount << "\","
              << std::endl;
  json_stream << "  \"Right Team Frames Possessed Ball\": \"" << awayTeamPossesionFrameCount << "\""
              << std::endl;

  json_stream << "}" << std::endl;

  return json_stream.str();
}

void Metadata::writeJSON(std::string jsonString, bool callBatch)
{
  // std::string file_path = "C:\\Users\\Brian\\Desktop\\throw dtm here";
  // file_path += "\\output.json";
  // std::string file_path;
  /*
  PWSTR path;
  SHGetKnownFolderPath(FOLDERID_Documents, KF_FLAG_DEFAULT, NULL, &path);
  std::wstring strpath(path);
  CoTaskMemFree(path);
  std::string documents_file_path(strpath.begin(), strpath.end());
  std::string replays_path = "\"";
  replays_path += documents_file_path;
  replays_path += "\\Citrus Replays";
  // "C://Users//Brian//Documents//Citrus Replays
  std::string json_output_path = documents_file_path + "\\Citrus Replays";
  json_output_path += "\\output.json";
  replays_path += "\"";
  // "C://Users//Brian//Documents//Citrus Replays"
  */
  std::string improvedReplayPath = File::GetUserPath(D_SPOOKYREPLAYS_IDX) + "output.json";
  File::WriteStringToFile(improvedReplayPath, jsonString);

  if (callBatch)
  {
    char date_string[100];
    strftime(date_string, 50, "%B_%d_%Y_%OH_%OM_%OS", matchDateTime);
    std::string someDate(date_string);
    std::string gameTime = "Game_" + someDate;
    /*
    std::string gameVar = " Game_";
    gameVar += someDate;
    // Game_May_05_2022_11_51_34
    gameVar += " ";
    gameVar += replays_path;
    // Game_May_05_2022_11_51_34 C://Users//Brian//Documents//Citrus Replays
    // we need to pass the path the replays are held in in order to CD into them in the batch file
    std::filesystem::path cwd = std::filesystem::current_path() / "createcit.bat";
    std::string pathToBatch = cwd.string();
    std::string batchPath = "\"\"" + pathToBatch + "\"";
    //std::string batchPath("./createcit.bat");
    batchPath += gameVar + "\"";
    */
    /*
    STARTUPINFO si;
    PROCESS_INFORMATION pi;
    memset(&si, 0, sizeof(si));
    si.cb = sizeof(si);
    //si.wShowWindow = SW_HIDE;
    // CREATE_NO_WINDOW
    if (!CreateProcessA(pathToBatch.c_str(), &batchPath[0], NULL, NULL, TRUE, CREATE_NO_WINDOW,
    NULL, NULL, (LPSTARTUPINFOA)&si, &pi))
    {
      // would handle error in here
    }
    // the task has ended so close the handle
    CloseHandle(pi.hThread);
    CloseHandle(pi.hProcess);
    */
    // WinExec(batchPath.c_str(), SW_HIDE);
    //  https://stackoverflow.com/questions/11370908/how-do-i-use-minizip-on-zlib
    std::vector<std::wstring> paths;
    std::string exampleFile1 = File::GetUserPath(D_SPOOKYREPLAYS_IDX) + "output.dtm.sav";
    for (char& c : exampleFile1)
    {
      if (c == '/')
        c = '\\';
    }
    std::string exampleFile2 = File::GetUserPath(D_SPOOKYREPLAYS_IDX) + "output.dtm";
    for (char& c : exampleFile2)
    {
      if (c == '/')
        c = '\\';
    }
    std::string exampleFile3 = File::GetUserPath(D_SPOOKYREPLAYS_IDX) + "output.json";
    for (char& c : exampleFile3)
    {
      if (c == '/')
        c = '\\';
    }
    paths.push_back(std::wstring_convert<std::codecvt_utf8<wchar_t>>().from_bytes(exampleFile1));
    paths.push_back(std::wstring_convert<std::codecvt_utf8<wchar_t>>().from_bytes(exampleFile2));
    paths.push_back(std::wstring_convert<std::codecvt_utf8<wchar_t>>().from_bytes(exampleFile3));
    std::string zipName = File::GetUserPath(D_SPOOKYREPLAYS_IDX) + gameTime + ".cit ";

    zipFile zf = zipOpen(zipName.c_str(), APPEND_STATUS_CREATE);
    if (zf == NULL)
      return;
    bool _return = true;
    for (size_t i = 0; i < paths.size(); i++)
    {
      std::fstream file(paths[i].c_str(), std::ios::binary | std::ios::in);
      if (file.is_open())
      {
        file.seekg(0, std::ios::end);
        long size = file.tellg();
        file.seekg(0, std::ios::beg);

        std::vector<char> buffer(size);
        if (size == 0 || file.read(&buffer[0], size))
        {
          zip_fileinfo zfi = {0};
          std::wstring fileName = paths[i].substr(paths[i].rfind('\\') + 1);

          if (ZIP_OK == zipOpenNewFileInZip(zf,
                                            std::string(fileName.begin(), fileName.end()).c_str(),
                                            &zfi, NULL, 0, NULL, 0, NULL, Z_DEFLATED, -1))
          {
            if (zipWriteInFileInZip(zf, size == 0 ? "" : &buffer[0], size))
              _return = false;

            if (zipCloseFileInZip(zf))
              _return = false;

            file.close();
            continue;
          }
        }
        file.close();
      }
      _return = false;
    }

    // common function to delete residual files
    StateAuxillary::endPlayback();
    if (zipClose(zf, NULL))
      return;

    if (!_return)
      return;
    return;
  }
}

void Metadata::setMatchMetadata(tm* matchDateTimeParam)
{
  // have consistent time across the output file and the in-json time
  matchDateTime = matchDateTimeParam;

  // set controllers
}

void Metadata::setPlayerName(std::string playerNameParam)
{
  playerName = playerNameParam;
}

void Metadata::setPlayerArray(std::vector<const NetPlay::Player*> playerArrayParam)
{
  playerArray = playerArrayParam;
  // statViewerPlayers = playerArrayParam;
}

void Metadata::setNetPlayControllers(NetPlay::PadMappingArray m_pad_map)
{
  netplayGCMap = m_pad_map;
  // statViewerControllers = m_pad_map;
}

void Metadata::setMD5(std::array<u8, 16> md5Param)
{
  md5Hash = md5Param;
}

std::vector<const NetPlay::Player*> Metadata::getPlayerArray()
{
  return playerArray;
}

NetPlay::PadMappingArray Metadata::getControllers()
{
  return netplayGCMap;
}
