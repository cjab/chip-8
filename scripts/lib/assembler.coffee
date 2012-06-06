define [
  "lib/parser"
],

(parser) ->

  class Assembler

    INSTRUCTION_SIZE: 2 # bytes
    parser: parser


    run: (input) ->
      @program = []
      @parser.yy = this
      @parser.parse(input)
      @program


    toArrayBuffer: (input) ->
      program = @run(input)
      buffer  = new ArrayBuffer(program.length * @INSTRUCTION_SIZE)
      (new Uint16Array(buffer)).set program
      buffer


    cls:         -> @program.push 0x00e0
    ret:         -> @program.push 0x00ee
    sys:  (addr) -> @program.push 0x0000 | addr
    skp:  (xReg) -> @program.push 0xe09e | (xReg << 8)
    sknp: (xReg) -> @program.push 0xe0a1 | (xReg << 8)
    or:   (xReg, yReg) -> @program.push 0x8001 | (xReg << 8) | (yReg << 4)
    and:  (xReg, yReg) -> @program.push 0x8002 | (xReg << 8) | (yReg << 4)
    xor:  (xReg, yReg) -> @program.push 0x8003 | (xReg << 8) | (yReg << 4)
    sub:  (xReg, yReg) -> @program.push 0x8005 | (xReg << 8) | (yReg << 4)
    shr:  (xReg, yReg) -> @program.push 0x8006 | (xReg << 8) | (yReg << 4)
    subn: (xReg, yReg) -> @program.push 0x8007 | (xReg << 8) | (yReg << 4)
    shl:  (xReg, yReg) -> @program.push 0x800e | (xReg << 8) | (yReg << 4)
    rnd:  (xReg, byte) -> @program.push 0xc000 | (xReg << 8) | byte
    call_addr:  (addr) -> @program.push 0x2000 | addr
    drw:  (xReg, yReg, nibble) ->
      @program.push 0xd000 | (xReg << 8) | (yReg << 4) | nibble

    jp_addr:    (addr) -> @program.push 0x1000 | addr
    jp_v0_addr: (addr) -> @program.push 0xb000 | addr

    se_reg_byte:  (xReg, byte) -> @program.push 0x3000 | (xReg << 8) | byte
    se_reg_reg:   (xReg, yReg) -> @program.push 0x5000 | (xReg << 8) | (yReg << 4)

    sne_reg_byte: (xReg, byte) -> @program.push 0x4000 | (xReg << 8) | byte
    sne_reg_reg:  (xReg, yReg) -> @program.push 0x9000 | (xReg << 8) | (yReg << 4)

    ld_reg_byte:  (xReg, byte) -> @program.push 0x6000 | (xReg << 8) | byte
    ld_reg_reg:   (xReg, yReg) -> @program.push 0x8000 | (xReg << 8) | (yReg << 4)
    ld_i_addr:    (addr)       -> @program.push 0xa000 | addr
    ld_reg_dt:    (xReg)       -> @program.push 0xf007 | (xReg << 8)
    ld_reg_k:     (xReg)       -> @program.push 0xf00a | (xReg << 8)
    ld_reg_k:     (xReg)       -> @program.push 0xf00a | (xReg << 8)
    ld_dt_reg:    (xReg)       -> @program.push 0xf015 | (xReg << 8)
    ld_st_reg:    (xReg)       -> @program.push 0xf018 | (xReg << 8)
    ld_f_reg:     (xReg)       -> @program.push 0xf029 | (xReg << 8)
    ld_b_reg:     (xReg)       -> @program.push 0xf033 | (xReg << 8)
    ld_b_reg:     (xReg)       -> @program.push 0xf033 | (xReg << 8)
    ld_start_reg: (xReg)       -> @program.push 0xf055 | (xReg << 8)
    ld_reg_start: (xReg)       -> @program.push 0xf065 | (xReg << 8)

    add_reg_byte: (xReg, byte) -> @program.push 0x7000 | (xReg << 8) | byte
    add_reg_reg:  (xReg, yReg) -> @program.push 0x8004 | (xReg << 8) | (yReg << 4)
    add_i_reg:    (xReg)       -> @program.push 0xf01e | (xReg << 8)
