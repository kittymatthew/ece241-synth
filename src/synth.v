`define MODELSIM

module synth (
    CLOCK_50, // 50 MHz clock
    HEX0, // DE1 Board Elements
    HEX1,
    HEX2,
    HEX3,
    HEX4,
    HEX5,
    LEDR,
    SW,
    KEY,
    FPGA_I2C_SDAT, // A/V Configuration Module required inputs/outputs
    FPGA_I2C_SCLK,
    AUD_ADCDAT, // Audio Controller Module required inputs/outputs
    AUD_BCLK,
    AUD_ADCLRCK,
    AUD_DACLRCK,
    AUD_XCK,
    AUD_DACDAT,
    PS2_CLK, // PS/2 Controller Module required inputs/outputs
    PS2_DAT
);

    input   CLOCK_50; // 50 MHz Clock
    input   [3:0] KEY; // DE1 Board Elements
    input   [9:0] SW;
    output  [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    output  [9:0] LEDR;

    inout   FPGA_I2C_SDAT; // A/V Configuration Module required outputs
    output  FPGA_I2C_SCLK;

    input	AUD_ADCDAT; // Audio Controller Module required inputs/outputs
    inout	AUD_BCLK;
    inout	AUD_ADCLRCK;
    inout	AUD_DACLRCK;
    output	AUD_XCK;
    output	AUD_DACDAT;

    inout	PS2_CLK; // PS/2 Controller Module required inputs/outputs
    inout	PS2_DAT;

    // Internal Signals

    wire reset, enable;
    wire [4:0] NOTE, SUSTAIN_NOTE;
    wire [31:0] WAVE1_OUT, WAVE2_OUT;
    reg [31:0] AUDIO_OUT;
    wire [31:0] MOD_OUT;
    wire audio_out_allowed;
    wire [31:0] left_unused, right_unused; 
    wire audio_in_unused;
    wire sent_enable;
    wire [7:0] keyboard_input;
    wire unused;
    wire unused2;


    // Static assignments
    assign reset = !KEY[0];
    assign enable = SW[9];
    `ifdef MODELSIM
        assign NOTE [4:0] = 5'b01100; // For simulation use
    `endif 

    parameter tSINE = 3'b000, tSQUARE = 3'b001, tSAW = 3'b010;

    waveform_gen wave_gen ({2'b00, SW[0]}, NOTE, // SW[0] controls the wave type
                            ((SW[1] & SW[0]) ? MOD_OUT : 32'b1111_1111_1111_1111_1111_1111_1111_1111), // SW[1] enables modulation on the square wave
                            WAVE1_OUT, CLOCK_50, enable, reset); // Output to WAVE1_OUT, and pass the enable, reset, and clock signals

    waveform_gen mod_gen (tSINE, {1'b1, 1'b1, 1'b1, SW[3], SW[2]}, // SW[2] and SW[3] determine the speed of the modulation
                        {SW[5], 1'b0, SW[4], 29'b0}, // SW[5] and SW[4] determine the amplitude of the modulation
                        MOD_OUT, CLOCK_50, enable, reset); // Output to MOD_OUT, and pass the enable, reset, and clock signals

    waveform_gen wave_gen_sustain ({2'b00, SW[6]}, SUSTAIN_NOTE, // SW[6] controls the wave type
                                    32'b1111_1111_1111_1111_1111_1111_1111_1111, WAVE2_OUT, CLOCK_50, enable, reset); // Output to WAVE2_OUT

    sustain_fsm sustain (CLOCK_50, reset, !KEY[1], sent_enable, NOTE, SUSTAIN_NOTE);

    /*
        Playing multiple notes at once is as simple as adding the output waveforms together arithmetically.
        However, in order to prevent overflow, we divide by two by bit-shifting one place to the right.
        I.e. a max amplitude signal from both wave generators would yield a max amplitude signal on the output.
        The given speakers are more than loud enough that this actually improves the quality of the design.
    */
    always @ (*) begin
        AUDIO_OUT <= ((WAVE1_OUT + WAVE2_OUT) >> 1); 
    end

    `ifndef MODELSIM
        Audio_Controller processor (CLOCK_50, reset, 1'b0, 1'b0, 1'b0, AUDIO_OUT, AUDIO_OUT, // Output the same signal to the left and right channels
                                    enable, AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, left_unused, // Audio inputs are not used
                                    right_unused, audio_in_unused, audio_out_allowed, AUD_XCK, AUD_DACDAT);
        avconf av_config (CLOCK_50, reset, FPGA_I2C_SCLK, FPGA_I2C_SDAT); // Module for configuring the audio_controller

        PS2_Controller keyboard (CLOCK_50, reset, 8'b0, 1'b0, PS2_CLK, PS2_DAT, unused, unused2, keyboard_input, sent_enable); 
        keyboard_transfer decoder (CLOCK_50, reset, keyboard_input, sent_enable, NOTE); 
    `endif 
endmodule