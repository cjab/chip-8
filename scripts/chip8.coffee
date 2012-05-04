define [
],

() ->

  class Chip8

    @MEMORY_SIZE:      4096
    @PROGRAM_START:     512
    @REGISTERS_SIZE:     19
    @STACK_SIZE:         16
    @STACK_START:       255
    @INSTRUCTION_SIZE:    2

    @REGISTER:
      V0: 0x00
      V1: 0x01
      V2: 0x02
      V3: 0x03
      V4: 0x04
      V5: 0x05
      V6: 0x06
      V7: 0x07
      V8: 0x08
      V9: 0x09
      VA: 0x0a
      VB: 0x0b
      VC: 0x0c
      VD: 0x0d
      VE: 0x0e
      VF: 0x0f
      SP: 0x10
      DT: 0x11
      ST: 0x12

    addr:   (instruction) -> instruction & 0x0fff
    xReg:   (instruction) -> (instruction & 0x0f00) >> 8
    yReg:   (instruction) -> (instruction & 0x00f0) >> 4
    byte:   (instruction) -> instruction & 0x00ff
    nibble: (instruction) -> instruction & 0x000f


    operations:
      0x0: (i) ->
        switch i
          when 0x00e0 then @cls()
          when 0x00ee then @ret()
          else @sys @addr(i)
      0x1: (i) -> @jp @addr(i)
      0x2: (i) -> @call @addr(i)
      0x3: (i) -> @se_reg_byte @xReg(i), @byte(i)
      0x4: (i) -> @sne_reg_byte @xReg(i), @byte(i)
      0x5: (i) -> @se_reg_reg @xReg(i), @yReg(i)
      0x6: (i) -> @ld_reg_byte @xReg(i), @byte(i)
      0x7: (i) -> @add_reg_byte @xReg(i), @byte(i)
      0x8: (i) -> @arithmeticOperations[i & 0x000f].call(this, i)
      0x9: (i) -> @sne_reg_reg @xReg(i), @yReg(i)
      0xa: (i) -> @ld_i_addr @addr(i)
      0xb: (i) -> @jp_v0_addr @addr(i)
      0xc: (i) -> @rnd @xReg(i), @byte(i)
      0xd: (i) -> @drw @xReg(i), @yReg(i), @nibble(i)
      0xe: (i) -> @skpOperations[i & 0x00ff].call(this, i)
      0xf: (i) -> @loadOperations[i & 0x00ff].call(this, i)


    arithmeticOperations:
      0x0: (i) -> @ld_reg_reg @xReg(i), @yReg(i)
      0x1: (i) -> @or @xReg(i), @yReg(i)
      0x2: (i) -> @and @xReg(i), @yReg(i)
      0x3: (i) -> @xor @xReg(i), @yReg(i)
      0x4: (i) -> @add_reg_reg @xReg(i), @yReg(i)
      0x5: (i) -> @sub @xReg(i), @yReg(i)
      0x6: (i) -> @shr @xReg(i), @yReg(i)
      0x7: (i) -> @subn @xReg(i), @yReg(i)
      0xe: (i) -> @shl @xReg(i), @yReg(i)


    skpOperations:
      0x9e: (i) -> @skp @xReg(i)
      0xa1: (i) -> @skpnp @xReg(i)


    loadOperations:
      0x07: (i) -> @ld_reg_dt @xReg(i)
      0x0A: (i) -> @ld_reg_k @xReg(i)
      0x15: (i) -> @ld_dt_reg @xReg(i)
      0x18: (i) -> @ld_st_reg @xReg(i)
      0x1e: (i) -> @add_i_reg @xReg(i)
      0x29: (i) -> @ld_f_reg @xReg(i)
      0x33: (i) -> @ld_b_reg @xReg(i)
      0x55: (i) -> @ld_start_x @xReg(i)
      0x65: (i) -> @ld_reg_start @xReg(i)


    constructor: ->
      @memoryBuffer   = new ArrayBuffer Chip8.MEMORY_SIZE
      @registerBuffer = new ArrayBuffer Chip8.REGISTERS_SIZE
      @stackBuffer    = new ArrayBuffer Chip8.STACK_SIZE
      @memory    = new Uint16Array @memoryBuffer
      @registers = new Uint8Array  @registerBuffer
      @stack     = new Uint16Array @stackBuffer
      @i  = 0x0000
      @pc = Chip8.PROGRAM_START
      @registers[Chip8.REGISTER.SP] = Chip8.STACK_START


    load: (buffer) ->
      program = new Uint16Array buffer
      @memory.set program, Chip8.PROGRAM_START


    cycle: ->
      instruction = @memory[@pc]
      @operations[instruction >>> 12].call(this, instruction)
      @pc += 1


    ret: ->
      @pc = @stack[@registers[Chip8.REGISTER.SP]]
      @registers[Chip8.REGISTER.SP] -= 1


    rnd: (xReg, byte) ->
      @registers[xReg] = Math.floor(Math.random() * 256) & byte


    or: (xReg, yReg) ->
      @registers[xReg] = @registers[xReg] | @registers[yReg]


    and: (xReg, yReg) ->
      @registers[xReg] = @registers[xReg] & @registers[yReg]


    xor: (xReg, yReg) ->
      @registers[xReg] = @registers[xReg] ^ @registers[yReg]


    shr: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = @registers[xReg] & 0x01
      @registers[xReg] = @registers[xReg] >>> 1


    shl: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = (@registers[xReg] & 0x80) >>> 7
      @registers[xReg] = @registers[xReg] << 1


    call: (addr) ->
      @registers[Chip8.REGISTER.SP] += 1
      @stack[@registers[Chip8.REGISTER.SP]] = @pc
      @pc = addr


    jp: (addr) ->
      @pc = addr


    jp_v0_addr: (addr) ->
      @pc = @registers[Chip8.REGISTER.V0] + addr


    se_reg_byte: (xReg, byte) ->
      @pc += 2 if @registers[xReg] == byte


    se_reg_reg:  (xReg, yReg) ->
      @pc += 2 if @registers[xReg] == @registers[yReg]


    sne_reg_byte: (xReg, byte) ->
      @pc += 2 if @registers[xReg] != byte


    sne_reg_reg:  (xReg, yReg) ->
      @pc += 2 if @registers[xReg] != @registers[yReg]


    add_reg_reg: (xReg, yReg) ->
      result = @registers[xReg] + @registers[yReg]
      @registers[Chip8.REGISTER.VF] = (result > 0xff)
      @registers[xReg] = result


    add_reg_byte: (xReg, byte) ->
      @registers[xReg] = @registers[xReg] + byte


    add_i_reg: (xReg) ->
      @i += @registers[xReg]


    sub: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = (@registers[xReg] > @registers[yReg])
      @registers[xReg] = @registers[xReg] - @registers[yReg]


    subn: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = (@registers[yReg] > @registers[xReg])
      @registers[xReg] = @registers[yReg] - @registers[xReg]


    ld_i_addr: (addr) ->
      @i = addr


    ld_reg_byte: (xReg, byte) ->
      @registers[xReg] = byte


    ld_reg_reg: (xReg, yReg) ->
      @registers[xReg] = @registers[yReg]


    ld_reg_dt: (xReg) ->
      @registers[xReg] = @registers[Chip8.REGISTER.DT]


    ld_dt_reg: (xReg) ->
      @registers[Chip8.REGISTER.DT] = @registers[xReg]


    ld_st_reg: (xReg) ->
      @registers[Chip8.REGISTER.ST] = @registers[xReg]


    ld_b_reg: (xReg) ->
      val = @registers[xReg]
      hundreds = @memory[@i] = Math.floor(val / 100)
      val -= hundreds * 100
      tens     = @memory[@i + 1] = Math.floor(val / 10)
      val -= tens * 10
      ones     = @memory[@i + 2] = val


    ld_start_reg: (xReg) ->
      @memory[@i + i] = @registers[i] for i in [Chip8.REGISTER.V0..xReg]


    ld_reg_start: (xReg) ->
      @registers[i] = @memory[@i + i] for i in [Chip8.REGISTER.V0..xReg]


    ld_reg_k:  (xReg) -> console.log "instruction not implemented"
    ld_f_reg:  (xReg) -> console.log "instruction not implemented"
    skp: (xReg) -> console.log "instruction not implemented"
    skpnp: (xReg) -> console.log "instruction not implemented"
    sys: (addr) -> console.log "SYS instruction not implemented"
    cls: -> console.log "CLS instruction not implemented"
    drw: (xReg, yReg, nibble) -> console.log "instruction not implemented"
