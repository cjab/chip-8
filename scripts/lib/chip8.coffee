define [
  "cs!lib/display"
  "keyboard"
],

(Display, Keyboard) ->

  class Chip8

    @MEMORY_SIZE:      4096
    @PROGRAM_START:     512
    @REGISTERS_SIZE:     19
    @STACK_SIZE:         16
    @STACK_START:       255
    @INSTRUCTION_SIZE:    2
    @TIMER_FREQUENCY:    60 # Hz
    @CLOCK_SPEED:        10 # ms

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


    @DEFAULT_KEY_MAP:
      0x0: "1"
      0x1: "2"
      0x2: "3"
      0x3: "up"
      0x4: "q"
      0x5: "w"
      0x6: "down"
      0x7: "left"
      0x8: "right"
      0x9: "s"
      0xa: "d"
      0xb: "f"
      0xc: "z"
      0xd: "x"
      0xe: "c"
      0xf: "v"


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
      0xa1: (i) -> @sknp @xReg(i)


    loadOperations:
      0x07: (i) -> @ld_reg_dt @xReg(i)
      0x0A: (i) -> @ld_reg_k @xReg(i)
      0x15: (i) -> @ld_dt_reg @xReg(i)
      0x18: (i) -> @ld_st_reg @xReg(i)
      0x1e: (i) -> @add_i_reg @xReg(i)
      0x29: (i) -> @ld_f_reg @xReg(i)
      0x33: (i) -> @ld_b_reg @xReg(i)
      0x55: (i) -> @ld_start_reg @xReg(i)
      0x65: (i) -> @ld_reg_start @xReg(i)


    constructor: (@renderer, @keyMap = Chip8.DEFAULT_KEY_MAP) -> @init()


    init: ->
      @initRegisters()
      @initMemory()
      @initStack()
      @initDisplay(@renderer)
      @initMemory()
      @initFonts()
      @running = false
      @waitingForInput = false


    reset: ->
      clearInterval(@pcInterval)
      @init()


    run: ->
      @running = true
      @pcInterval = setInterval(@cycle, Chip8.CLOCK_SPEED)


    initMemory: -> @memory = new Uint8Array(new ArrayBuffer(Chip8.MEMORY_SIZE))


    initFonts: -> (new Uint8Array(@memory.buffer)).set @display.buildFonts()


    initDisplay: (renderer) -> @display = new Display(renderer)


    initStack: -> @stack = new Uint16Array(new ArrayBuffer(Chip8.STACK_SIZE))


    initRegisters: ->
      @registers = new Uint8Array(new ArrayBuffer(Chip8.REGISTERS_SIZE))
      @i  = 0x0000
      @pc = Chip8.PROGRAM_START
      @registers[Chip8.REGISTER.SP] = Chip8.STACK_START


    # Dump the entire contents of memory, stack, display, and all registers to
    # console for debugging purposes.
    dump: ->
      console.log "Memory Dump:",   @memory
      console.log "Register Dump:", @registers
      console.log "Display Dump:",  @display
      console.log "Stack Dump:",    @stack
      console.log "PC Dump:",       "0x#{@pc.toString(16)}"
      console.log "I Dump:",        "0x#{@i.toString(16)}"


    # Load a program into memory.
    load: (buffer) ->
      program = new Uint8Array buffer
      @memory.set program, Chip8.PROGRAM_START


    # Update the delay timer (DT) and sound timer (ST).
    updateTimers: =>
      #secondsPassed = Chip8.CLOCK_SPEED / 1000
      #step = Math.floor(secondsPassed * Chip8.TIMER_FREQUENCY)
      step = 5

      dt = @registers[Chip8.REGISTER.DT]
      st = @registers[Chip8.REGISTER.ST]

      if (dt - step) < 0
        @registers[Chip8.REGISTER.DT] = 0x00
      else
        @registers[Chip8.REGISTER.DT] -= step

      if (st - step) < 0
        @registers[Chip8.REGISTER.ST] = 0x00
      else
        @registers[Chip8.REGISTER.ST] -= step


    # Run a processor cycle. This may run more than one instruction. The number
    # of instructions per cycle can be tweaked to improve emulation.
    cycle: =>
      @updateTimers()

      for i in [0..10]
        highByte = @memory[@pc]
        lowByte  = @memory[@pc + 1]
        instruction = (highByte << 8) | lowByte

        #console.log "[#{@pc}] 0x#{instruction.toString(16)}"
        #debugger
        @operations[instruction >>> 12].call(this, instruction)
        @pc += 2

        running = false if @pc > Chip8.MEMORY_SIZE
        clearInterval(@pcInterval) unless @running


    #### Instructions
    #

    # Return from a subroutine.
    # The program counter will be set to the value on top of the stack
    # and the stack pointer decremented.
    ret: ->
      @pc = @stack[@registers[Chip8.REGISTER.SP]]
      @registers[Chip8.REGISTER.SP] -= 1


    # Generate a random byte.
    # The `xReg` register will be set to a random byte value that has been
    # ANDed with `byte`.
    rnd: (xReg, byte) ->
      @registers[xReg] = Math.floor(Math.random() * 256) & byte


    # Bitwise OR of two registers.
    # Perform a bitwise OR of `xReg` and `yReg` and store the result in `xReg`
    or: (xReg, yReg) ->
      @registers[xReg] = @registers[xReg] | @registers[yReg]


    # Bitwise AND of two registers.
    # Perform a bitwise AND of `xReg` and `yReg` and store the result in `xReg`
    and: (xReg, yReg) ->
      @registers[xReg] = @registers[xReg] & @registers[yReg]


    # Bitwise XOR of two registers.
    # Perform a bitwise XOR of `xReg` and `yReg` and store the result in `xReg`
    xor: (xReg, yReg) ->
      @registers[xReg] = @registers[xReg] ^ @registers[yReg]


    # Shift right.
    # Shift the value in `xReg` right by 1. The value shifted off of the right
    # is stored in the VF register.
    shr: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = @registers[xReg] & 0x01
      @registers[xReg] = @registers[xReg] >>> 1


    # Shift left.
    # Shift the value in `xReg` left by 1. The value shifted off of the left
    # is stored in the VF register.
    shl: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = (@registers[xReg] & 0x80) >>> 7
      @registers[xReg] = @registers[xReg] << 1


    # Call a subroutine.
    # Store the currunt program counter on the stack and then set the
    # program counter to instruction before `addr`. On the next cycle
    # the program counter will be incremented and the instruction at
    # `addr` will be executed.
    call: (addr) ->
      @registers[Chip8.REGISTER.SP] += 1
      @stack[@registers[Chip8.REGISTER.SP]] = @pc
      @pc = addr - 2


    # Jump execution to `addr`.
    # Set the program counter to the instruction before `addr`.
    # On the next cycle the program counter will be incremented and the
    # instruction at `addr` will be executed. This is the same as call
    # but without storing the current program counter to the stack.
    jp: (addr) -> @pc = addr - 2


    # Jump execution to `addr` plus the value of V0.
    jp_v0_addr: (addr) -> @pc = (@registers[Chip8.REGISTER.V0] + addr) - 2


    # Skip the next instruction if the value of `xReg` is equal to `byte`.
    se_reg_byte: (xReg, byte) -> @pc += 2 if @registers[xReg] == byte


    # Skip the next instruction if the value of `xReg` is equal to the value
    # of `yReg`.
    se_reg_reg:  (xReg, yReg) ->
      @pc += 2 if @registers[xReg] == @registers[yReg]


    # Skip the next instruction if the value of `xReg` is NOT equal to `byte`.
    sne_reg_byte: (xReg, byte) -> @pc += 2 if @registers[xReg] != byte


    # Skip the next instruction if the value of `xReg` is NOT equal to the
    # value of 'yReg'.
    sne_reg_reg:  (xReg, yReg) ->
      @pc += 2 if @registers[xReg] != @registers[yReg]


    # Add `yReg` to `xReg` and store the result in `xReg`. If the result is
    # greater than 8 bits the VF register is set to 1, otherwise it is set to 0.
    # In the event of an overflow the lower 8 bits of the result are still
    # stored in `xReg`.
    add_reg_reg: (xReg, yReg) ->
      result = @registers[xReg] + @registers[yReg]
      @registers[Chip8.REGISTER.VF] = (result > 0xff)
      @registers[xReg] = result


    # Add `byte` to `xReg` and store the result in `xReg`. If the result is
    # greater than 8 bits the VF register is set to 1, otherwise it is set to 0.
    # In the event of an overflow the lower 8 bits of the result are still
    # stored in `xReg`.
    add_reg_byte: (xReg, byte) -> @registers[xReg] = @registers[xReg] + byte


    # Add `xReg` to `I` and store the result in `I`.
    add_i_reg: (xReg) -> @i += @registers[xReg]


    # Subtract `yReg` from `xReg` and store the result in `xReg`. If the
    # operation does NOT require a borrow the VF register is set to 1,
    # otherwise it is set to 0.
    sub: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = (@registers[xReg] > @registers[yReg])
      @registers[xReg] = @registers[xReg] - @registers[yReg]


    # Subtract `xReg` from `yReg` and store the result in `xReg`. If the
    # operation does NOT require a borrow the VF register is set to 1,
    # otherwise it is set to 0.
    subn: (xReg, yReg) ->
      @registers[Chip8.REGISTER.VF] = (@registers[yReg] > @registers[xReg])
      @registers[xReg] = @registers[yReg] - @registers[xReg]


    # Load the value `addr` into the `I` register.
    ld_i_addr: (addr) -> @i = addr


    # Load the value `byte` into the `xReg` register.
    ld_reg_byte: (xReg, byte) -> @registers[xReg] = byte


    # Load the value of the `yReg` register into the `xReg` register.
    ld_reg_reg: (xReg, yReg) -> @registers[xReg] = @registers[yReg]


    # Load the current value of the delay timer into the `xReg` register.
    ld_reg_dt: (xReg) -> @registers[xReg] = @registers[Chip8.REGISTER.DT]


    # Load the value of the `xReg` register into the delay timer register.
    ld_dt_reg: (xReg) -> @registers[Chip8.REGISTER.DT] = @registers[xReg]


    # Load the value of the `xReg` register into the sound timer register.
    ld_st_reg: (xReg) -> @registers[Chip8.REGISTER.ST] = @registers[xReg]


    # Store the BCD representation of `xReg` in memory starting at location I.
    # The hundreds place digit will be stored in I, tens in I+1 and ones in I+2.
    ld_b_reg: (xReg) ->
      val = @registers[xReg]
      hundreds = @memory[@i] = Math.floor(val / 100)
      val -= hundreds * 100
      tens = @memory[@i + 1] = Math.floor(val / 10)
      val -= tens * 10
      ones = @memory[@i + 2] = val


    # Store the value of registers V0 through `xReg` into memory starting at
    # location I.
    ld_start_reg: (xReg) ->
      @memory[@i + i] = @registers[i] for i in [Chip8.REGISTER.V0..xReg]


    # Load values from memory into registers V0 to `xReg` with values
    # starting at location I.
    ld_reg_start: (xReg) ->
      @registers[i] = @memory[@i + i] for i in [Chip8.REGISTER.V0..xReg]


    # Clear the display
    cls: -> @display.clear()


    # Draw a sprite of `nibble` bytes starting from the I register and to
    # the (`xReg`, `yReg`) coordinates of the display. The VF register is set
    # to 1 if an XOR of the sprite to the display would cause a pixel that was
    # initially 1 to be set to 0 otherwise VF is set to 0. This is useful for
    # collision detection.
    drw: (xReg, yReg, nibble) ->
      x = @registers[xReg]
      y = @registers[yReg]
      sprite = new Uint8Array(new ArrayBuffer(nibble))
      sprite[i] = @memory[@i + i] for i in [0..(nibble - 1)]
      collision = @display.drawSprite(x, y, sprite.buffer)
      @registers[Chip8.REGISTER.VF] = collision


    # Skip the next instruction if the key with value `xReg` is currently
    # being pressed.
    skp: (xReg) ->
      for key in Keyboard.activeKeys()
        @pc += 2 if key == @keyMap[@registers[xReg]]


    # Skip the next instruction if the key with value `xReg` is currently
    # NOT being pressed.
    sknp: (xReg) ->
      for key in Keyboard.activeKeys()
        return if key == @keyMap[@registers[xReg]]
      @pc += 2


    # Wait for a key to be pressed and store the value of the key to the `xReg`
    # register. This is a blocking instruction. All execution stops while
    # waiting for a key press.
    ld_reg_k: (xReg) ->
      @waitingForInput = true

      @didGetInput = (event) =>
        keyPressed = String.fromCharCode(event.keyCode || event.keyLocation)
        for own value, key of @keyMap
          if key == keyPressed
            @waitingForInput  = false
            @registers[xReg]  = value
            document.removeEventListener "keydown", @didGetInput

      document.addEventListener "keydown", @didGetInput


    # Load the location of the sprite representing the `xReg` register into
    # the I register.
    ld_f_reg: (xReg) -> @i = @registers[xReg] * Display.FONT_HEIGHT


    # Jump to the machine code routine at `addr`. (NOT IMPLEMENTED)
    sys: (addr) ->
      console.log "SYS instruction not implemented"
      @running = false
