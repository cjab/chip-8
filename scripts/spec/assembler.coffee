define [
  "cs!assembler"
],

(Assembler) ->

  describe "Assembler", ->

    assembler = null

    beforeEach ->
      assembler = new Assembler

    describe "#toArrayBuffer", ->

      it "should return a buffer containing the assembled program", ->
        program = "
          CLS
          RET
          LD V2, V1
        "
        expect(assembler.toArrayBuffer(program).byteLength).toEqual(6)


    #it "should work", ->
    #  program = ""
    #  xhr = new XMLHttpRequest()
    #  xhr.open "GET", "/data/pong.asm"
    #  xhr.onload = (e) -> program = xhr.responseText
    #  xhr.send()
    #  waitsFor -> xhr.readyState == 4

    #  runs ->
    #    assembler.run(program)
    #    console.log("0x#{i.toString(16)}") for i in assembler.program

    it "should assemble CLS", ->
      expect(assembler.run("CLS")[0]).toEqual 0x00e0

    it "should assemble RET", ->
      expect(assembler.run("RET")[0]).toEqual 0x00ee

    it "should assemble SYS addr", ->
      expect(assembler.run("SYS 0x123")[0]).toEqual 0x0123

    it "should assemble JP addr", ->
      expect(assembler.run("JP 0x123")[0]).toEqual 0x1123

    it "should assemble CALL addr", ->
      expect(assembler.run("CALL 0x123")[0]).toEqual 0x2123

    it "should assemble SE Vx, byte", ->
      expect(assembler.run("SE V1, 0x12")[0]).toEqual 0x3112

    it "should assemble SNE Vx, byte", ->
      expect(assembler.run("SNE V1, 0x12")[0]).toEqual 0x4112

    it "should assemble SE Vx, Vy", ->
      expect(assembler.run("SE V1, V2")[0]).toEqual 0x5120

    it "should assemble LD Vx, byte", ->
      expect(assembler.run("LD V1, 0x12")[0]).toEqual 0x6112

    it "should assemble LD Vx, byte", ->
      expect(assembler.run("LD VA, 0x12")[0]).toEqual 0x6a12

    it "should assemble ADD Vx, byte", ->
      expect(assembler.run("ADD V1, 0x12")[0]).toEqual 0x7112

    it "should assemble LD Vx, Vy", ->
      expect(assembler.run("LD V1, V2")[0]).toEqual 0x8120

    it "should assemble OR Vx, Vy", ->
      expect(assembler.run("OR V1, V2")[0]).toEqual 0x8121

    it "should assemble AND Vx, Vy", ->
      expect(assembler.run("AND V1, V2")[0]).toEqual 0x8122

    it "should assemble XOR Vx, Vy", ->
      expect(assembler.run("XOR V1, V2")[0]).toEqual 0x8123

    it "should assemble ADD Vx, Vy", ->
      expect(assembler.run("ADD V1, V2")[0]).toEqual 0x8124

    it "should assemble SUB Vx, Vy", ->
      expect(assembler.run("SUB V1, V2")[0]).toEqual 0x8125

    it "should assemble SHR Vx", ->
      expect(assembler.run("SHR V1")[0]).toEqual 0x8106

    it "should assemble SHR Vx, Vy", ->
      expect(assembler.run("SHR V1, V2")[0]).toEqual 0x8126

    it "should assemble SUBN Vx, Vy", ->
      expect(assembler.run("SUBN V1, V2")[0]).toEqual 0x8127

    it "should assemble SHL Vx", ->
      expect(assembler.run("SHL V1")[0]).toEqual 0x810e

    it "should assemble SHL Vx, Vy", ->
      expect(assembler.run("SHL V1, V2")[0]).toEqual 0x812e

    it "should assemble SNE Vx, Vy", ->
      expect(assembler.run("SNE V1, V2")[0]).toEqual 0x9120

    it "should assemble LD I, addr", ->
      expect(assembler.run("LD I, 0x123")[0]).toEqual 0xa123

    it "should assemble JP V0, addr", ->
      expect(assembler.run("JP V0, 0x123")[0]).toEqual 0xb123

    it "should assemble RND Vx, byte", ->
      expect(assembler.run("RND V1, 0x12")[0]).toEqual 0xc112

    it "should assemble DRW Vx, Vy, nibble", ->
      expect(assembler.run("DRW V1, V2, 0xf")[0]).toEqual 0xd12f

    it "should assemble SKP Vx", ->
      expect(assembler.run("SKP V1")[0]).toEqual 0xe19e

    it "should assemble SKNP Vx", ->
      expect(assembler.run("SKNP V1")[0]).toEqual 0xe1a1

    it "should assemble LD Vx, DT", ->
      expect(assembler.run("LD V1, DT")[0]).toEqual 0xf107

    it "should assemble LD Vx, K", ->
      expect(assembler.run("LD V1, K")[0]).toEqual 0xf10a

    it "should assemble LD DT, Vx", ->
      expect(assembler.run("LD DT, V1")[0]).toEqual 0xf115

    it "should assemble LD ST, Vx", ->
      expect(assembler.run("LD ST, V1")[0]).toEqual 0xf118

    it "should assemble ADD I, Vx", ->
      expect(assembler.run("ADD I, V1")[0]).toEqual 0xf11e

    it "should assemble LD F, Vx", ->
      expect(assembler.run("LD F, V1")[0]).toEqual 0xf129

    it "should assemble LD B, Vx", ->
      expect(assembler.run("LD B, V1")[0]).toEqual 0xf133

    it "should assemble LD [I], Vx", ->
      expect(assembler.run("LD [I], V1")[0]).toEqual 0xf155

    it "should assemble LD Vx, [I]", ->
      expect(assembler.run("LD V1, [I]")[0]).toEqual 0xf165
