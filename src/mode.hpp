#ifndef YASA_ADDRESSMODE
#define YASA_ADDRESSMODE

namespace yasa
{
  enum AddressMode 
  {
    Immediate,
    Implied,
    Direct,
    Indexed_X,
    Indexed_Y,
    Indirect,
    Indirect_X,
    Indirect_Y,
    Indirect_Long,
    Indirect_Long_Y,
    Stack,
    Stack_Y,
    Label,
    Block,
    SIZE
  };

  static const std::string AddressModeString[AddressMode::SIZE] = {
    "Immediate",
    "Implied",
    "Direct",
    "Indexed_X",
    "Indexed_Y",
    "Indirect",
    "Indirect_X",
    "Indirect_Y",
    "Indirect_Long",
    "Indirect_Long_Y",
    "Stack",
    "Stack_Y",
    "Label",
    "Block"
  };
}

#endif
