#ifndef YASA_TEST
#define YASA_TEST

#include <iostream>
#include <vector>

#include "parser.hpp"

#include "externs.hpp"

namespace test
{
  bool run(std::string name, std::string& data, std::vector<uint8_t>& expected, std::string base_path);
  bool run_tests();
  bool arch_65816();
  bool smwc_duck();
  bool smwc_disable_goal_right_walk();
  bool super_mario_world();
  bool math();
}

#endif
