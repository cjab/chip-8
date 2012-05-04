define [
],

() ->

  class Chip8

    @MEMORY_SIZE:      4096
    @PROGRAM_START:     512
    @NUM_OF_REGISTERS:   16 + 5 # 16 general and 5 special registers
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
      I:  0x10
      PC: 0x11
      SP: 0x12
      DT: 0x13
      ST: 0x14

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
      0x4: (i) -> @add @xReg(i), @yReg(i)
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
      0x1e: (i) -> @ld_i_reg @xReg(i)
      0x29: (i) -> @ld_f_reg @xReg(i)
      0x33: (i) -> @ld_b_reg @xReg(i)
      0x55: (i) -> @ld_start_x @xReg(i)
      0x65: (i) -> @ld_reg_start @xReg(i)


    constructor: ->
      @memoryBuffer   = new ArrayBuffer Chip8.MEMORY_SIZE
      @registerBuffer =
        new ArrayBuffer Chip8.INSTRUCTION_SIZE * Chip8.NUM_OF_REGISTERS
      @memory    = new Uint16Array @memoryBuffer
      @registers = new Uint16Array @registerBuffer
      @registers[Chip8.REGISTER.PC] = Chip8.PROGRAM_START


    load: (buffer) ->
      program = new Uint16Array buffer
      @memory.set program, Chip8.PROGRAM_START


    cycle: ->
      instruction = @memory[@registers[Chip8.REGISTER.PC]]
      @operations[instruction >>> 12].call(this, instruction)
      @registers[Chip8.REGISTER.PC] += 1


    sys: (addr) -> console.log "SYS instruction not implemented"
    cls: -> console.log "CLS instruction not implemented"
    ret: -> console.log "RET instruction not implemented"
    rnd: (xReg, byte) -> console.log "instruction not implemented"
    drw: (xReg, yReg, nibble) -> console.log "instruction not implemented"


    or:  (xReg, yReg) -> @registers[xReg] = @registers[xReg] | @registers[yReg]
    and: (xReg, yReg) -> @registers[xReg] = @registers[xReg] & @registers[yReg]
    xor: (xReg, yReg) -> @registers[xReg] = @registers[xReg] ^ @registers[yReg]

    shr: (xReg, yReg) -> console.log "instruction not implemented"
    shl: (xReg, yReg) -> console.log "instruction not implemented"
    subn: (xReg, yReg) -> console.log "instruction not implemented"
    call: (addr) -> console.log "instruction not implemented"


    jp: (addr) -> console.log "JP instruction not implemented"
    jp_v0_addr: (addr) -> console.log "instruction not implemented"

    se_reg_byte: (xReg, byte) -> console.log "instruction not implemented"
    se_reg_reg:  (xReg, yReg) -> console.log "instruction not implemented"

    sne_reg_byte: (xReg, byte) -> console.log "instruction not implemented"
    sne_reg_reg:  (xReg, yReg) -> console.log "instruction not implemented"

    add: (xReg, yReg) -> console.log "instruction not implemented"
    add_reg_byte: (xReg, byte) -> console.log "instruction not implemented"

    sub: (xReg, yReg) -> console.log "instruction not implemented"

    ld_i_addr: (addr) -> console.log "instruction not implemented"
    ld_reg_byte: (xReg, byte) -> console.log "instruction not implemented"
    ld_reg_reg: (xReg, yReg) -> console.log "instruction not implemented"
    ld_reg_dt: (xReg) -> console.log "instruction not implemented"
    ld_reg_k:  (xReg) -> console.log "instruction not implemented"
    ld_dt_reg: (xReg) -> console.log "instruction not implemented"
    ld_st_reg: (xReg) -> console.log "instruction not implemented"
    ld_i_reg:  (xReg) -> console.log "instruction not implemented"
    ld_f_reg:  (xReg) -> console.log "instruction not implemented"
    ld_b_reg:  (xReg) -> console.log "instruction not implemented"
    ld_start_reg: (xReg) -> console.log "instruction not implemented"
    ld_reg_start: (xReg) -> console.log "instruction not implemented"

    skp: (xReg) -> console.log "instruction not implemented"
    skpnp: (xReg) -> console.log "instruction not implemented"
