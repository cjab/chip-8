define [
  "cs!chip8"
],

(Chip8) ->

  describe "Chip8", ->

    chip8 = null

    beforeEach ->
      chip8 = new Chip8


    describe "#addr", ->

      it "should return the address portion of an instruction", ->
        expect(chip8.addr(0x1234)).toEqual(0x234)


    describe "#xReg", ->

      it "should return the x register portion of an instruction", ->
        expect(chip8.xReg(0x1234)).toEqual(0x2)


    describe "#yReg", ->

      it "should return the x register portion of an instruction", ->
        expect(chip8.yReg(0x1234)).toEqual(0x3)


    describe "#byte", ->

      it "should return the byte portion of an instruction", ->
        expect(chip8.byte(0x1234)).toEqual(0x34)


    describe "#nibble", ->

      it "should return the nibble portion of an instruction", ->
        expect(chip8.nibble(0x1234)).toEqual(0x4)


    describe "#load", ->

      it "should load a program into memory at the program start address", ->
        buffer = new ArrayBuffer 4
        program = new Uint16Array buffer
        program[0] = 0x1234
        chip8.load(buffer)
        expect(chip8.memory[Chip8.PROGRAM_START]).toEqual 0x1234


    describe "#cycle", ->

      beforeEach ->
        buffer = new ArrayBuffer 4
        program = new Uint16Array buffer
        program[0] = 0x1234
        chip8.load(buffer)

      it "works", ->
        chip8.cycle()


    describe "#or", ->

      it "should perform a bitwise or on two registers and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x0f
        chip8.registers[Chip8.REGISTER.V1] = 0x20
        chip8.or(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x2f


    describe "#and", ->

      it "should perform a bitwise and on two registers and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x0f
        chip8.registers[Chip8.REGISTER.V1] = 0x1f
        chip8.and(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x0f


    describe "#xor", ->

      it "should perform a bitwise xor on two registers and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.registers[Chip8.REGISTER.V1] = 0x0f
        chip8.xor(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0xf0


    describe "#shr", ->

      it "should perform a right shift on a register", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x10
        chip8.shr(0x0)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x08

      it "should set VF to 0 if least significant bit is 0", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xf2
        chip8.shr(0x0)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x0

      it "should set VF to 1 if most significant bit is 1", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.shr(0x0)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x1


    describe "#shl", ->

      it "should perform a left shift on a register", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.shl(0x0)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0xfe

      it "should set VF to 0 if least significant bit is 0", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x0f
        chip8.shl(0x0)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x0

      it "should set VF to 1 if most significant bit is 1", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.shl(0x0)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x1


    describe "#add_reg_reg", ->

      it "should add two registers and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x09
        chip8.registers[Chip8.REGISTER.V1] = 0x11
        chip8.add_reg_reg(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x1a

      it "should set VF to 0 if result less than or equal to 255", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x09
        chip8.registers[Chip8.REGISTER.V1] = 0x10
        chip8.add_reg_reg(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x0

      it "should set VF to 1 if result greater than 255 (overflow)", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.registers[Chip8.REGISTER.V1] = 0x01
        chip8.add_reg_reg(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x1


    describe "#add_reg_byte", ->

      it "should add a constant to the register", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x08
        chip8.add_reg_byte(Chip8.REGISTER.V0, 0x08)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x10

      it "should not set VF on overflow", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.add_reg_reg(Chip8.REGISTER.V0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x0


    describe "#sub", ->

      it "should subtract two registers and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x0a
        chip8.registers[Chip8.REGISTER.V1] = 0x02
        chip8.sub(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x08

      it "should set VF to 1 on !overflow", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.registers[Chip8.REGISTER.V1] = 0xf1
        chip8.sub(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x1

      it "should set VF to 0 on overflow", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xf1
        chip8.registers[Chip8.REGISTER.V1] = 0xff
        chip8.sub(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x0


    describe "#subn", ->

      it "should subtract the first from the second and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x02
        chip8.registers[Chip8.REGISTER.V1] = 0x0a
        chip8.subn(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x08

      it "should set VF to 1 on !overflow", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xf1
        chip8.registers[Chip8.REGISTER.V1] = 0xff
        chip8.subn(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x1

      it "should set VF to 0 on overflow", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.registers[Chip8.REGISTER.V1] = 0xf1
        chip8.subn(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.registers[Chip8.REGISTER.VF]).toEqual 0x0


    describe "#ret", ->

      it "should set the program counter to the value at the top of the stack", ->
        chip8.stack[0x0] = 0x2ff
        chip8.registers[Chip8.REGISTER.SP] = 0x0
        chip8.ret()
        expect(chip8.pc).toEqual 0x2ff

      it "should decrement the stack pointer", ->
        chip8.registers[Chip8.REGISTER.SP] = 0x1
        chip8.ret()
        expect(chip8.registers[Chip8.REGISTER.SP]).toEqual 0x0

      it "should wrap around when decrementing the stack pointer", ->
        chip8.registers[Chip8.REGISTER.SP] = 0x0
        chip8.ret()
        expect(chip8.registers[Chip8.REGISTER.SP]).toEqual 0xff


    describe "#jp", ->

      it "should set the program counter", ->
        chip8.jp(0x2ff)
        expect(chip8.pc).toEqual 0x2ff


    describe "#call", ->

      it "should set the program counter to the address", ->
        chip8.call(0x2ff)
        expect(chip8.pc).toEqual 0x2ff

      it "should increment the stack pointer", ->
        chip8.call(0x2ff)
        expect(chip8.registers[Chip8.REGISTER.SP]).toEqual 0x0

      it "should place the current pc on top of the stack", ->
        pc = chip8.pc
        chip8.call(0x2ff)
        expect(chip8.stack[0]).toEqual pc


    describe "#se_reg_byte", ->

      it "should increment the program counter by two if equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.se_reg_byte(Chip8.REGISTER.V0, 0x05)
        expect(chip8.pc).toEqual(pc + 2)

      it "should not increment the program counter if NOT equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.se_reg_byte(Chip8.REGISTER.V0, 0x07)
        expect(chip8.pc).toEqual(pc)


    describe "#sne_reg_byte", ->

      it "should increment the program counter by two if NOT equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.sne_reg_byte(Chip8.REGISTER.V0, 0x07)
        expect(chip8.pc).toEqual(pc + 2)

      it "should not increment the program counter if equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.sne_reg_byte(Chip8.REGISTER.V0, 0x05)
        expect(chip8.pc).toEqual(pc)


    describe "#se_reg_reg", ->

      it "should increment the program counter by two if equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.registers[Chip8.REGISTER.V1] = 0x05
        chip8.se_reg_reg(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.pc).toEqual(pc + 2)

      it "should not increment the program counter if NOT equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.registers[Chip8.REGISTER.V1] = 0x07
        chip8.se_reg_reg(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.pc).toEqual(pc)


    describe "#ld_reg_byte", ->

      it "should store the byte in a register", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x00
        chip8.ld_reg_byte(Chip8.REGISTER.V0, 0x2f)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x2f


    describe "#ld_reg_reg", ->

      it "should store the value of the second register in the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x00
        chip8.registers[Chip8.REGISTER.V1] = 0x2f
        chip8.ld_reg_reg(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x2f


    describe "#sne_reg_reg", ->

      it "should increment the program counter by two if NOT equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.registers[Chip8.REGISTER.V1] = 0x07
        chip8.sne_reg_reg(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.pc).toEqual(pc + 2)

      it "should not increment the program counter if equal", ->
        pc = chip8.pc
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.registers[Chip8.REGISTER.V1] = 0x05
        chip8.sne_reg_reg(Chip8.REGISTER.V0, Chip8.REGISTER.V1)
        expect(chip8.pc).toEqual(pc)


    describe "#ld_i_addr", ->

      it "should store the value of the second register in the first", ->
        chip8.ld_i_addr(0x2f)
        expect(chip8.i).toEqual 0x2f


    describe "#jp_v0_addr", ->

      it "should set the program counter to V0 + addr", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.jp_v0_addr(0x03)
        expect(chip8.pc).toEqual 0x8


    describe "#rnd", ->

      it "should set the register to a random number with a mask applied", ->
        chip8.registers[Chip8.REGISTER.V0] = 0xff
        chip8.rnd(Chip8.REGISTER.V0, 0x0f)
        expect(chip8.registers[Chip8.REGISTER.V0] & 0xf0).toEqual 0x00


    describe "#ld_reg_dt", ->

      it "should store the value of the delay timer in the register", ->
        chip8.registers[Chip8.REGISTER.DT] = 0x2f
        chip8.ld_reg_dt(Chip8.REGISTER.V0)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x2f


    describe "#ld_dt_reg", ->

      it "should store the value of the register in the delay timer", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x2f
        chip8.ld_dt_reg(Chip8.REGISTER.V0)
        expect(chip8.registers[Chip8.REGISTER.DT]).toEqual 0x2f


    describe "#ld_st_reg", ->

      it "should store the value of the register in the sound timer", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x2f
        chip8.ld_st_reg(Chip8.REGISTER.V0)
        expect(chip8.registers[Chip8.REGISTER.ST]).toEqual 0x2f


    describe "#add_i_reg", ->

      it "should add the value in the register to i and store in i", ->
        chip8.i = 0x05
        chip8.registers[Chip8.REGISTER.V0] = 0x02

        chip8.add_i_reg(Chip8.REGISTER.V0)
        expect(chip8.i).toEqual 0x07


    describe "#ld_b_reg", ->

      it "should store in I, I+1, and I+2 the bcd value of the register", ->
        chip8.i = 1024
        chip8.registers[Chip8.REGISTER.V0] = 123
        chip8.ld_b_reg(Chip8.REGISTER.V0)
        expect(chip8.memory[chip8.i    ]).toEqual 1
        expect(chip8.memory[chip8.i + 1]).toEqual 2
        expect(chip8.memory[chip8.i + 2]).toEqual 3


    describe "#ld_start_reg", ->

      it "should store in I-I+n the values of V0-Vn", ->
        chip8.i = 1024
        chip8.registers[Chip8.REGISTER.V0] = 0x05
        chip8.registers[Chip8.REGISTER.V1] = 0x1f
        chip8.registers[Chip8.REGISTER.V2] = 0x5c
        chip8.ld_start_reg(Chip8.REGISTER.V2)
        expect(chip8.memory[chip8.i    ]).toEqual 0x05
        expect(chip8.memory[chip8.i + 1]).toEqual 0x1f
        expect(chip8.memory[chip8.i + 2]).toEqual 0x5c


    describe "#ld_reg_start", ->

      it "should store in V0-Vn the values of I-I+n from memory", ->
        chip8.i = 1024
        chip8.memory[chip8.i]     = 0x05
        chip8.memory[chip8.i + 1] = 0x1f
        chip8.memory[chip8.i + 2] = 0x5c
        chip8.ld_reg_start(Chip8.REGISTER.V2)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x05
        expect(chip8.registers[Chip8.REGISTER.V1]).toEqual 0x1f
        expect(chip8.registers[Chip8.REGISTER.V2]).toEqual 0x5c


    describe "#cls", ->

      it "should clear the display buffer", ->
        chip8.display.buffer[3] = 0xff
        chip8.cls()
        expect(chip8.display.isClear()).toBe(true)


    describe "#drw", ->

      it "should draw to the display", ->
        chip8.i = 1024
        chip8.registers[Chip8.REGISTER.V0] = 0
        chip8.registers[Chip8.REGISTER.V1] = 0
        chip8.memory.set [ 0xff, 0xff, 0xff, 0xff, 0xff ], 1024

        chip8.drw(Chip8.REGISTER.V0, Chip8.REGISTER.V1, 0x5)
        expect(chip8.display.isClear()).toBe(false)

      it "should set VF to 1 if there is a collision", ->
        chip8.i = 1024
        chip8.registers[Chip8.REGISTER.V0] = 0
        chip8.registers[Chip8.REGISTER.V1] = 0
        chip8.memory.set [ 0xff, 0xff, 0xff, 0xff, 0xff ], 1024

        chip8.drw(Chip8.REGISTER.V0, Chip8.REGISTER.V1, 0x5)
        chip8.drw(Chip8.REGISTER.V0, Chip8.REGISTER.V1, 0x5)
        expect(chip8.registers[Chip8.REGISTER.VF]).toBe(1)

      it "should set VF to 0 if there is NOT a collision", ->
        chip8.i = 1024
        chip8.registers[Chip8.REGISTER.V0] = 0
        chip8.registers[Chip8.REGISTER.V1] = 0
        chip8.memory.set [ 0xff, 0xff, 0xff, 0xff, 0xff ], 1024

        chip8.drw(Chip8.REGISTER.V0, Chip8.REGISTER.V1, 0x5)
        expect(chip8.registers[Chip8.REGISTER.VF]).toBe(0)
