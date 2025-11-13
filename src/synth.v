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

    wire reset;
    wire [4:0] NOTE;
    wire [31:0] AUDIO_OUT;
    wire audio_out_allowed;
    wire [31:0] left_unused, right_unused; 
    wire audio_in_unused;
    wire sent_enable;
    wire [7:0]keyboard_input;
    wire unused;

    // Static assignments
    assign reset = !KEY[0];
    assign enable = SW[6];
    //assign NOTE [4:0] = SW[4:0];

    parameter tSINE = 3'b000, tSQUARE = 3'b001, tSAW = 3'b010;

    avconf av_config (CLOCK_50, reset, FPGA_I2C_SCLK, FPGA_I2C_SDAT); // Module for configuring the audio_controller
    waveform_gen sine_gen (tSINE, NOTE, AUDIO_OUT, CLOCK_50, enable, reset); // Instantiate the waveform generator
    Audio_Controller processor  (CLOCK_50, reset, 1'b0, 1'b0, 1'b0, AUDIO_OUT, AUDIO_OUT, // Output the same signal to the left and right channels
                                enable, AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCK, AUD_DACLRCK, left_unused, // Audio inputs are not used
                                right_unused, audio_in_unused, audio_out_allowed, AUD_XCK, AUD_DACDAT);
    PS2_Controller keyboard(CLOCK_50, reset, 8'b0, 1'b0, PS2_CLK, PS2_DAT, unused, unused, keyboard_input, sent_enable); 
    keyboard_transfer decoder(CLOCK_50, reset, keyboard_input, sent_enable, NOTE);
endmodule