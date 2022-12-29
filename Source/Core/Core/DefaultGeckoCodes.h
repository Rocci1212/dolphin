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
  void RunCodeInject(bool bIsRanked);

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
  const DefaultGeckoCode replayStart = {
      0x8011982C, 0, {0x39C00001, 0x3DE08060, 0x91CFFFFD, 0x3DC00000, 0x3DE00000, 0x80840080,
                      0x60000000}};

                      
  const DefaultGeckoCode replayStart2 = {
      0x801EE6D0, 0, {0x39C00001, 0x3DE08060, 0x91CFFFFD, 0x3DC00000, 0x3DE00000, 0x806DDB78,
                      0x60000000}};

  const DefaultGeckoCode replayEnd = {0x801ED380,
                                      0,
                                      {0x39C00000, 0x3DE08060, 0x91CFFFFD, 0x3DC00000, 0x3DE00000,
                                       0x9421FE10, 0x60000000}};

  void WriteAsm(DefaultGeckoCode CodeBlock);
  u32 aWriteAddr;  // address where the first code gets written to

  std::vector<DefaultGeckoCode> sRequiredCodes = {
      replayStart,    replayStart2,         replayEnd};
};
