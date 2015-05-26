#ifndef STATE_H
#define STATE_H

#include <string>
#include <vector>
#include <map>
#include <iostream>

#include "instruction.hpp"
#include "externs.hpp"

enum RomLayout
{
  LOROM,
  HIROM,
  EXLOROM,
  EXHIROM
};

struct Assembler
{
  int snespos;
  int realpos;
  int max_addr;
  int org;
  int rom_type;

  std::vector<std::string> label_ids;
  std::map<std::string, int> labels;
  std::map<std::string, std::string> defines;

  std::map<int, std::vector<yasa::Instruction>> ast;

  void setmode(RomLayout layout);
  std::string *add_sublabel_name(const char *text);
  std::string get_sublabel_name(const char *text);
};

#endif
