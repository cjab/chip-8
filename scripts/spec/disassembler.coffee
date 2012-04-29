define [
  "cs!disassembler"
],

(Disassembler) ->

  describe "Disassembler", ->

    disassembler = null

    beforeEach ->
      disassembler = new Disassembler


    describe "#run", ->

      buffer = null
      xhr    = null

      beforeEach ->
        buffer     = new ArrayBuffer(8)
        opArray    = new Uint16Array(buffer)
        opArray.set [ 0xe000, 0x026a, 0x0c6b, 0x3f6c ]
        #xhr = new XMLHttpRequest()
        #xhr.responseType = "arraybuffer"
        #xhr.open "GET", "/data/pong.bin"
        #xhr.onload = (e) -> buffer = xhr.response
        #xhr.send()
        #waitsFor -> xhr.readyState == 4

      it "should return an array of instructions", ->
        result = disassembler.run(buffer)
        expect(result).toEqual [
          "CLS"
          "LD VA, 0x2"
          "LD VB, 0xc"
          "LD VC, 0x3f"
        ]


    describe "#getAddress", ->
      it "should return the instruction's address operand", ->
        expect(disassembler.getAddress(0x12c8)).toEqual("0x2c8")


    describe "#getXRegister", ->
      it "should return the instruction's X register operand", ->
        expect(disassembler.getXRegister(0x32c8)).toEqual("V2")


    describe "#getYRegister", ->
      it "should return the instruction's Y register operand", ->
        expect(disassembler.getYRegister(0x5230)).toEqual("V3")


    describe "#getByte", ->
      it "should return the instruction's byte operand", ->
        expect(disassembler.getByte(0x7225)).toEqual("0x25")


    describe "#getNibble", ->
      it "should return the instruction's nibble operand", ->
        expect(disassembler.getNibble(0xD125)).toEqual("0x5")


    describe "#getInstruction", ->
      it "should return the instruction's mnemonic", ->
        disassembler.getInstruction 0x00e0
        disassembler.getInstruction 0x6a02
