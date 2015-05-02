#ifndef YASA_ADDRESSMODE
#define YASA_ADDRESSMODE

namespace yasa
{
  enum AddressMode {
    Invalid,
    Implied = 1,
    Immediate_Mem,
    Immediate_Index,
    Immediate_8bit,
    Immediate,
    Label,
    //Near_Label,
    Relative,
    Relative_Long,
    Direct,
    Direct_X,
    Direct_Y,
    Indirect,
    Indirect_X,
    Indirect_Y,
    Indirect_Long,
    Indirect_Long_Y,
    Absolute,
    Absolute_X,
    Absolute_Y,
    Absolute_Long,
    Absolute_Long_X,
    Stack,
    Stack_Y,
    Absolute_Indirect,
    Absolute_Indirect_Long,
    Absolute_Indirect_X,
    Accumulator,
    Block
  };
}

#endif
