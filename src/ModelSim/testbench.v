`timescale 1ns / 1ps
`define MODELSIM
//`define TESTA

module testbench ();
    reg   CLOCK_50; // 50 MHz Clock
    reg   [3:0] KEY; // DE1 Board Elements
    reg   [9:0] SW;
    wire  [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
    wire  [9:0] LEDR;

    wire   FPGA_I2C_SDAT; // A/V Configuration Module required outputs
    wire  FPGA_I2C_SCLK;

    wire	AUD_ADCDAT; // Audio Controller Module required inputs/outputs
    wire	AUD_BCLK;
    wire	AUD_ADCLRCLK;
    wire	AUD_DACLRCLK;
    wire	AUD_XCK;
    wire	AUD_DACDAT;

    wire	PS2_CLK; // PS/2 Controller Module required inputs/outputs
    wire	PS2_DAT;

    initial begin CLOCK_50 <= 1'b0; end // Initialize the clock signal to 0

    always begin // Toggle the clock (50MHz)
        #10 CLOCK_50 <= ~CLOCK_50;
    end

    initial begin // Reset the circuit at the beginning
        KEY[0] <= 1'b0;
        #10 KEY[0] <= 1'b1;
    end

    initial begin // Main testbench actions
        `ifdef TESTA
            SW <= 10'b0000000000;
            SW[9] <= 1'b1; // Set enable to on
            #50000000 SW <= 10'b0001000001; // Switch waveform to square
        `endif 
        `ifndef TESTA
            SW <= 10'b0000000000;
            SW[9] <= 1'b1; // Set enable to on
            SW[0] <= 1'b1; // Set waveform to sqaure
            SW[1] <= 1'b1; // Set modulation on
            SW[2] <= 1'b1; // Set modulation speed to slow
            SW[3] <= 1'b0;
            SW[4] <= 1'b1; // Set modulation amplitude to high
            SW[5] <= 1'b1;
            #50000000 SW[2] <= 1'b0; // Switch modulation speed to very fast
            SW[3] <= 1'b1;
            SW[4] <= 1'b1; // Set modulation amplitude to low
            SW[5] <= 1'b0;
        `endif 
    end

    synth U1    (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR,
                SW, KEY, FPGA_I2C_SDAT, FPGA_I2C_SCLK, AUD_ADCDAT, AUD_BCLK, AUD_ADCLRCLK,
                AUD_DACLRCLK, AUD_XCK, AUD_DACDAT, PS2_CLK, PS2_DAT);
endmodule
