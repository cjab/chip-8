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
        chip8.registers[Chip8.REGISTER.V0] = 0x000f
        chip8.registers[Chip8.REGISTER.V1] = 0x0020
        chip8.or(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x002f


    describe "#and", ->

      it "should perform a bitwise and on two registers and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x0f0f
        chip8.registers[Chip8.REGISTER.V1] = 0x020f
        chip8.and(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x020f


    describe "#xor", ->

      it "should perform a bitwise xor on two registers and store to the first", ->
        chip8.registers[Chip8.REGISTER.V0] = 0x00ff
        chip8.registers[Chip8.REGISTER.V1] = 0x000f
        chip8.xor(0x0, 0x1)
        expect(chip8.registers[Chip8.REGISTER.V0]).toEqual 0x00f0
