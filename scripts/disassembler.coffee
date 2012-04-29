define [
],

() ->

  class Disassembler

    run: (buffer) ->
      program = new Uint16Array(buffer)

      for instruction in program
        # Chip-8 is Big Endian, more than likely the buffer is little endian...
        # Unfortunately endianness of the buffer array depends on the machine.
        # TODO: Find a way to determine if the endianness needs to be fixed
        instruction = ((instruction << 8) & 0xff00) | (instruction >>> 8)
        @getInstruction(instruction)


    getAddress:   (instruction) -> "0x#{(instruction & 0x0fff).toString(16)}"
    getXRegister: (instruction) -> "V#{((instruction & 0x0f00) >> 8).toString(16).toUpperCase()}"
    getYRegister: (instruction) -> "V#{((instruction & 0x00f0) >> 4).toString(16).toUpperCase()}"
    getByte:      (instruction) -> "0x#{(instruction & 0x00ff).toString(16)}"
    getNibble:    (instruction) -> "0x#{(instruction & 0x000f).toString(16)}"


    getInstruction: (instruction) ->
      addr   = @getAddress   instruction
      x      = @getXRegister instruction
      y      = @getYRegister instruction
      byte   = @getByte      instruction
      nibble = @getNibble    instruction

      switch instruction >>> 12
        when 0x0
          switch instruction
            when 0x00e0 then "CLS"
            when 0x00ee then "RET"
            else "SYS #{addr}"
        when 0x1 then "JP #{addr}"
        when 0x2 then "CALL #{addr}"
        when 0x3 then "SE #{x}, #{byte}"
        when 0x4 then "SNE #{x}, #{byte}"
        when 0x5 then "SE #{x}, #{y}"
        when 0x6 then "LD #{x}, #{byte}"
        when 0x7 then "ADD #{x}, #{byte}"
        when 0x8
          switch instruction & 0x000f
            when 0x0 then "LD #{x}, #{y}"
            when 0x1 then "OR #{x}, #{y}"
            when 0x2 then "AND #{x}, #{y}"
            when 0x3 then "XOR #{x}, #{y}"
            when 0x4 then "ADD #{x}, #{y}"
            when 0x5 then "SUB #{x}, #{y}"
            when 0x6 then "SHR #{x}" + (if y then ", #{y}" else "")
            when 0x7 then "SUBN #{x}, #{y}"
            when 0xe then "SHL #{x}" + (if y then ", #{y}" else "")
        when 0x9 then "SNE #{x}, #{y}"
        when 0xa then "LD I, #{addr}"
        when 0xb then "JP V0, #{addr}"
        when 0xc then "RND #{x}, #{byte}"
        when 0xd then "DRW #{x}, #{y}, #{nibble}"
        when 0xe
          switch instruction & 0x00ff
            when 0x9e then "SKP #{x}"
            when 0xa1 then "SKNP #{x}"
        when 0xf
          switch instruction & 0x00ff
            when 0x07 then "LD #{x}, DT"
            when 0x0A then "LD #{x}, K"
            when 0x15 then "LD DT, #{x}"
            when 0x18 then "LD ST, #{x}"
            when 0x1e then "ADD I, #{x}"
            when 0x29 then "LD F, #{x}"
            when 0x33 then "LD B, #{x}"
            when 0x55 then "LD [I], #{x}"
            when 0x65 then "LD #{x}, [I]"
