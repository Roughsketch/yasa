#include "test.hpp"

#include <iomanip>

namespace test
{
  bool run(std::string name, std::string& data, std::vector<uint8_t>& expected, std::string base_path = "")
  {
    int result = 0;
    bool success = true;

    scan_string(data);
    set_base_path(base_path);

    try
    {
      result = yyparse(); 
    }
    catch (yasa::InvalidInstructionException e)
    {
      std::cout << "[FAIL] " << name << ": Exception " << e.what() << std::endl;
      return false;
    }

    if (result != 0)
    {
      std::cout << "[FAIL] " << name << ": yyparse returned " << result << std::endl;
      return false;
    }

    for (auto &instr : *output)
    {
      if (instr.has_label())
      {
        instr.parse_label(labels[instr.label()]);
      }
    }

    std::vector<uint8_t> parseout;

    for (auto instr : *output)
    {
      for (auto byte : instr.data())
      {
        parseout.push_back(byte);
      }
    }

    if (parseout.size() != expected.size())
    {
      std::cout << "[FAIL] " << name << ": Size mismatch: (" << parseout.size() << ", " << expected.size() << ")" << std::endl;
      success = false;
    }
    else if (parseout != expected)
    {
      std::cout << "[FAIL] " << name << ": Differences found between assembled file and expected result." << std::endl;
      success = false; 
    }
    else
    {
      std::cout << "[PASS] " << name << std::endl;
    }

    return success;
  }

  bool run_tests()
  {
    bool success = true;

    success &= arch_65816();
    success &= smwc_duck();
    success &= smwc_disable_goal_right_walk();
    success &= super_mario_world();

    return success;
  }

  bool arch_65816()
  {
    std::string data = 
      #include "../tests/arch-65816.inc"
    ;

    std::vector<uint8_t> correct = {
       #include "../tests/arch-65816.dat"
    };

    return run("arch_65816", data, correct);
  }

  bool smwc_duck()
  {
    std::string data = 
      #include "../tests/smwc/duck.inc"
    ;

    std::vector<uint8_t> correct = {
      #include "../tests/smwc/duck.dat"
    };

    return run("smw_duck", data, correct);
  }

  bool smwc_disable_goal_right_walk()
  {
    std::string data = 
      #include "../tests/smwc/org.inc"
    ;

    std::vector<uint8_t> correct = {
      #include "../tests/smwc/org.dat"
    };

    return run("smwc_disable_goal_right_walk", data, correct);
  }

  bool super_mario_world()
  {
    std::string data = 
      #include "../tests/smwc/org.inc"
    ;

    std::vector<uint8_t> correct = {
      #include "../tests/smwc/org.dat"
    };

    return run("smwc_disable_goal_right_walk", data, correct, TEST_DIRECTORY "/smw");
  }
}