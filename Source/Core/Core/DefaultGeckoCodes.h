#pragma once


// This Class and its ideas are property of LittleCoaks and PeacockSlayer
// Their implementation of it comes from Project Rio, whom's website and source code can be found
// below at: https://www.projectrio.online/ https://github.com/ProjectRio/ProjectRio

#include <array>
#include <map>
#include <set>
#include <string>
#include <tuple>
#include <vector>
#include "Core/HW/Memmap.h"

class DefaultGeckoCodes
{
public:
  void RunCodeInject(bool bCompatibilityMode, bool bNetplayMode);

private:
  void InjectNetplayEventCode();
  void AddRankedCodes();

  struct DefaultGeckoCode
  {
    u32 addr;
    u32 conditionalVal;  // set to 0 if no onditional needed; condition is for when we don't want to
                         // write at an addr every frame
    std::vector<u32> codeLines;
  };
  /*
  // gameplay settings
  const DefaultGeckoCode netplayCommunitySettings = {
      0x800963bc,
      0,
      {0x3860002c, 0x3dc08153, 0x39ce4c6c, 0x39e00001, 0x99eefffc, 0x39e00004, 0x91ee0000,
       0x39e0012c, 0x91ee0004, 0x39e00001, 0x99ee0008, 0x39e00000, 0x99ee0009, 0x99ee000a}};
       */

  const DefaultGeckoCode markAndIgnoreDesyncs = {
      0x803332D8, 0, {0x7C030040, 0x3C608060, 0x4182000C, 0x3B200001, 0x48000008, 0x3B200000, 
                      0x93230010, 0x3B200001, 0x807A011C, 0x7C031800, 0x60000000}};

  const DefaultGeckoCode unlockIngameCheats = {
      0x8010F63C, 0, {0x3C600000, 0x6063FFFF, 0x907F0068}};

  const DefaultGeckoCode unlockCaptainsAndStadia = {
      0x8010F71C, 0, {0x3C000000, 0x6000FFFF, 0xB00386AC}};

  const DefaultGeckoCode matchStatusToggle = {
      0x802849A4, 0, {0x3F808060, 0x2C060009, 0x40A20010, 0x38800004, 0x989C0000, 0x4800003C, 
                      0x2C060012, 0x40A20010, 0x38800000, 0x989C0000, 0x48000028, 0x2C060004, 
                      0x40A20020, 0x8B9C0000, 0x7C06E000, 0x40A20014, 0x3F808060, 0x38800001, 
                      0x989C0000, 0x4082FFCC, 0x7C7D3214, 0x60000000}};

  const DefaultGeckoCode matchStatusToggleOnQuit = {
      0x802B57C4, 0, {0x39C00000, 0x3DE08060, 0x99CF0000, 0x3DC00000, 0x3DE00000, 0x90A30000, 
                      0x60000000}};

  const DefaultGeckoCode fastStadia = {
    0x800081F0, 0, {0x3C00909B, 0x60006530, 0x7C00F800, 0x40820030, 0x3C003F26, 0x60006666, 
                      0x901F003C, 0x3C000000, 0x901F002C, 0x3C003E4C, 0x6000CCCD, 0x901F001C, 
                      0x3C003F19, 0x6000999A, 0x901F000C, 0x83E1000C, 0x60000000}};

  const DefaultGeckoCode defaultOptions = {
    0x802337C8, 0, {0xBF61000C, 0x3F800000, 0x3F6080C5, 0x637BF2D8, 0x939B0000, 0x939B0004, 
                      0x939B0024, 0x939B002C, 0x3B800001, 0x939B000C, 0x939B0018, 0x939B0028, 
                      0x60000000}};

  static const u32 aCompRules_1 = 0x80c5f2f0;  
  static const u32 aCompRules_2 = 0x80c5f2e4;  
  static const u32 aCompRules_3 = 0x80c5f300;  
  static const u32 aCompRules_4 = 0x80c5f2fc;  
  static const u32 aCompRules_5 = 0x80c5f304;  
  static const u32 aCompRules_6 = 0x80c5f2dc;  
  static const u32 aCompRules_7 = 0x80c5f2d8;   


  void WriteAsm(DefaultGeckoCode CodeBlock);
  u32 aWriteAddr;  // address where the first code gets written to

  std::vector<DefaultGeckoCode> sRequiredCodes = {
      markAndIgnoreDesyncs, unlockIngameCheats,
      unlockCaptainsAndStadia  //, defaultOptions - requires furthertesting
  };

  std::vector<DefaultGeckoCode> sTournamentCodes = {
    fastStadia
  };

  // match status is crashing on wiimmfi, don't know why
  std::vector<DefaultGeckoCode> sNetplayCodes = {
    matchStatusToggleOnQuit
  };
};
