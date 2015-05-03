#include "test.hpp"

#include <iomanip>

namespace test
{
  bool run_tests()
  {
    bool success = true;

    success &= arch_65816();
    success &= super_mario_world();

    return success;
  }

  bool arch_65816()
  {
    bool success = true;

    std::string data = 
      #include "../tests/arch-65816.inc"
    ;

    scan_string(data);

    int result = yyparse();

    if (result != 0)
    {
      std::cout << "[FAIL] arch_65816: yyparse returned " << result << std::endl;
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

    std::vector<uint8_t> correct = {
       0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00, 0x04, 0x00, 0x05, 0x00, 0x06, 0x00, 0x07, 0x00, 0x08, 0x09, 0x00, 0x09, 0x00, 0x00, 0x0A, 0x0B, 0x0C, 0x00, 0x00, 0x0D, 0x00, 0x00, 0x0E, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
       0x10, 0x21, 0x11, 0x00, 0x12, 0x00, 0x13, 0x00, 0x14, 0x00, 0x15, 0x00, 0x16, 0x00, 0x17, 0x00, 0x18, 0x19, 0x00, 0x00, 0x1A, 0x1B, 0x1C, 0x00, 0x00, 0x1D, 0x00, 0x00, 0x1E, 0x00, 0x00, 0x1F, 0x00, 0x00, 0x00,
       0x20, 0x00, 0x00, 0x21, 0x00, 0x22, 0x00, 0x00, 0x00, 0x23, 0x00, 0x24, 0x00, 0x25, 0x00, 0x26, 0x00, 0x27, 0x00, 0x28, 0x29, 0x00, 0x29, 0x00, 0x00, 0x2A, 0x2B, 0x2C, 0x00, 0x00, 0x2D, 0x00, 0x00, 0x2E, 0x00, 0x00, 0x2F, 0x00, 0x00, 0x00,
       0x30, 0x21, 0x31, 0x00, 0x32, 0x00, 0x33, 0x00, 0x34, 0x00, 0x35, 0x00, 0x36, 0x00, 0x37, 0x00, 0x38, 0x39, 0x00, 0x00, 0x3A, 0x3B, 0x3C, 0x00, 0x00, 0x3D, 0x00, 0x00, 0x3E, 0x00, 0x00, 0x3F, 0x00, 0x00, 0x00,
       0x40, 0x41, 0x00, 0x42, 0x00, 0x42, 0x00, 0x43, 0x00, 0x44, 0x00, 0x00, 0x45, 0x00, 0x46, 0x00, 0x47, 0x00, 0x48, 0x49, 0x00, 0x49, 0x00, 0x00, 0x4A, 0x4B, 0x4C, 0x00, 0x00, 0x4D, 0x00, 0x00, 0x4E, 0x00, 0x00, 0x4F, 0x00, 0x00, 0x00,
       0x50, 0x23, 0x51, 0x00, 0x52, 0x00, 0x53, 0x00, 0x54, 0x00, 0x00, 0x55, 0x00, 0x56, 0x00, 0x57, 0x00, 0x58, 0x59, 0x00, 0x00, 0x5A, 0x5B, 0x5C, 0x00, 0x00, 0x00, 0x5D, 0x00, 0x00, 0x5E, 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00,
       0x60, 0x61, 0x00, 0x62, 0x00, 0x00, 0x63, 0x00, 0x64, 0x00, 0x65, 0x00, 0x66, 0x00, 0x67, 0x00, 0x68, 0x69, 0x00, 0x69, 0x00, 0x00, 0x6A, 0x6B, 0x6C, 0x00, 0x00, 0x6D, 0x00, 0x00, 0x6E, 0x00, 0x00, 0x6F, 0x00, 0x00, 0x00,
       0x70, 0x21, 0x71, 0x00, 0x72, 0x00, 0x73, 0x00, 0x74, 0x00, 0x75, 0x00, 0x76, 0x00, 0x77, 0x00, 0x78, 0x79, 0x00, 0x00, 0x7A, 0x7B, 0x7C, 0x00, 0x00, 0x7D, 0x00, 0x00, 0x7E, 0x00, 0x00, 0x7F, 0x00, 0x00, 0x00,
       0x80, 0x24, 0x81, 0x00, 0x82, 0x1F, 0x00, 0x83, 0x00, 0x84, 0x00, 0x85, 0x00, 0x86, 0x00, 0x87, 0x00, 0x88, 0x89, 0x00, 0x89, 0x00, 0x00, 0x8A, 0x8B, 0x8C, 0x00, 0x00, 0x8D, 0x00, 0x00, 0x8E, 0x00, 0x00, 0x8F, 0x00, 0x00, 0x00,
       0x90, 0x21, 0x91, 0x00, 0x92, 0x00, 0x93, 0x00, 0x94, 0x00, 0x95, 0x00, 0x96, 0x00, 0x97, 0x00, 0x98, 0x99, 0x00, 0x00, 0x9A, 0x9B, 0x9C, 0x00, 0x00, 0x9D, 0x00, 0x00, 0x9E, 0x00, 0x00, 0x9F, 0x00, 0x00, 0x00,
       0xA0, 0x00, 0xA0, 0x00, 0x00, 0xA1, 0x00, 0xA2, 0x00, 0xA2, 0x00, 0x00, 0xA3, 0x00, 0xA4, 0x00, 0xA5, 0x00, 0xA6, 0x00, 0xA7, 0x00, 0xA8, 0xA9, 0x00, 0xA9, 0x00, 0x00, 0xAA, 0xAB, 0xAC, 0x00, 0x00, 0xAD, 0x00, 0x00, 0xAE, 0x00, 0x00, 0xAF, 0x00, 0x00, 0x00,
       0xB0, 0x21, 0xB1, 0x00, 0xB2, 0x00, 0xB3, 0x00, 0xB4, 0x00, 0xB5, 0x00, 0xB6, 0x00, 0xB7, 0x00, 0xB8, 0xB9, 0x00, 0x00, 0xBA, 0xBB, 0xBC, 0x00, 0x00, 0xBD, 0x00, 0x00, 0xBE, 0x00, 0x00, 0xBF, 0x00, 0x00, 0x00,
       0xC0, 0x00, 0xC0, 0x00, 0x00, 0xC1, 0x00, 0xC2, 0x00, 0xC3, 0x00, 0xC4, 0x00, 0xC5, 0x00, 0xC6, 0x00, 0xC7, 0x00, 0xC8, 0xC9, 0x00, 0xC9, 0x00, 0x00, 0xCA, 0xCB, 0xCC, 0x00, 0x00, 0xCD, 0x00, 0x00, 0xCE, 0x00, 0x00, 0xCF, 0x00, 0x00, 0x00,
       0xD0, 0x21, 0xD1, 0x00, 0xD2, 0x00, 0xD3, 0x00, 0xD4, 0x00, 0xD5, 0x00, 0xD6, 0x00, 0xD7, 0x00, 0xD8, 0xD9, 0x00, 0x00, 0xDA, 0xDB, 0xDC, 0x00, 0x00, 0xDD, 0x00, 0x00, 0xDE, 0x00, 0x00, 0xDF, 0x00, 0x00, 0x00,
       0xE0, 0x00, 0xE0, 0x00, 0x00, 0xE1, 0x00, 0xE2, 0x00, 0xE3, 0x00, 0xE4, 0x00, 0xE5, 0x00, 0xE6, 0x00, 0xE7, 0x00, 0xE8, 0xE9, 0x00, 0xE9, 0x00, 0x00, 0xEA, 0xEB, 0xEC, 0x00, 0x00, 0xED, 0x00, 0x00, 0xEE, 0x00, 0x00, 0xEF, 0x00, 0x00, 0x00,
       0xF0, 0x22, 0xF1, 0x00, 0xF2, 0x00, 0xF3, 0x00, 0xF4, 0x00, 0x00, 0xF5, 0x00, 0xF6, 0x00, 0xF7, 0x00, 0xF8, 0xF9, 0x00, 0x00, 0xFA, 0xFB, 0xFC, 0x00, 0x00, 0xFD, 0x00, 0x00, 0xFE, 0x00, 0x00, 0xFF, 0x00, 0x00, 0x00 
    };

    if (parseout.size() != correct.size())
    {
      std::cout << "[FAIL] arch_65816: Size mismatch: (" << parseout.size() << ", " << correct.size() << ")" << std::endl;
      success = false;
    }
    else if (parseout != correct)
    {
      success = false; 
      std::cout << "[FAIL] arch_65816: Differences found between assembled file and correct result." << std::endl;
    }
    else
    {
      std::cout << "[PASS] arch_65816" << std::endl;
    }

    return success;
  }

  bool super_mario_world()
  {
    bool success = true;

    std::string data = 
      #include "../tests/smw/main.inc"
    ;

    set_base_path(TEST_DIRECTORY  "/smw");

    scan_string(data);

    int result = yyparse();

    if (result != 0)
    {
      std::cout << "[FAIL] super_mario_world: yyparse returned " << result << std::endl;
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

    std::vector<uint8_t> correct = {
      #include "../tests/smw/output.dat"
    };

    if (parseout.size() != correct.size())
    {
      std::cout << "[FAIL] super_mario_world: Size mismatch: (" << parseout.size() << ", " << correct.size() << ")" << std::endl;
      success = false;
    }
    else if (parseout != correct)
    {
      success = false; 
      std::cout << "[FAIL] super_mario_world: Differences found between assembled file and correct result." << std::endl;
    }
    else
    {
      std::cout << "[PASS] super_mario_world" << std::endl;
    }

    return success;
  }
}