module waveform_gen (TYPE, NOTE, OUT, clock, enable, reset);
    input [2:0] TYPE;
    input [4:0] NOTE;
    input clock, enable, reset;

    wire [31:0] SINE, SQUARE, SAW;
    reg [31:0] BUFFER;
    output reg [31:0] OUT;

    sine_gen sine_generator (NOTE, SINE, clock, reset);
    square_gen square_gen (NOTE, SQUARE, clock, reset);
    saw_gen saw_gen (NOTE, SAW, clock, reset);

    localparam tSINE = 3'b000, tSQUARE = 3'b001, tSAW = 3'b010;

    always @ (*) begin
        case (TYPE)
            tSINE: begin BUFFER = SINE; end
            tSQUARE: begin BUFFER = SQUARE; end
            tSAW: begin BUFFER = SAW; end
            default: begin BUFFER = 32'b0; end
        endcase
    end

    always @ (posedge clock, posedge reset) begin
        if (reset) begin 
            OUT <= 32'b0; 
        end
        else if (enable) begin OUT <= BUFFER; end
        else begin OUT <= OUT; end
    end
endmodule

module sine_gen (NOTE, OUT, clock, reset);
    input [4:0] NOTE;
    input clock, reset;

    output reg [31:0] OUT;
    reg [31:0] COUNT, STEP;

    reg [31:0] SINE_LUT [0:1023];

    initial begin
        $readmemh("sine_lookup.hex", SINE_LUT, 0, 1023);
    end

    localparam C = 5'b00001;
    localparam Csharp = 5'b00010;
    localparam D = 5'b00011;
    localparam Dsharp = 5'b00100;
    localparam E = 5'b00101;
    localparam F = 5'b00110;
    localparam Fsharp = 5'b00111;
    localparam G = 5'b01000;
    localparam Gsharp = 5'b01001;
    localparam A = 5'b01010;
    localparam Asharp = 5'b01011;
    localparam B = 5'b01100;
    localparam C2 = 5'b01101;
    localparam Csharp2 = 5'b01110;
    localparam D2 = 5'b01111;
    localparam Dsharp2 = 5'b10000;
    localparam E2 = 5'b10001;
    localparam F2 = 5'b10010;
    localparam Fsharp2 = 5'b10011;
    localparam G2 = 5'b10100;
    localparam Gsharp2 = 5'b10101;
    localparam A2 = 5'b10110;
    localparam Asharp2 = 5'b10111;
    localparam B2 = 5'b11000;
    localparam C3 = 5'b11001;

    /* 
        The frequency we output is determined based on how 'fast' we traverse through the sine wave.
        We change the speed we traverse through the sine wave based on how many entries of the lookup table we travel through.
        We can calculate this using: increment = (f_out * 2^32) / f_clk
        However, because we want to synthesize this code, we try to avoid using division, so we hard-coded the step values for two full octaves.
        We round the step to the nearest whole number, but because they are so large, this is not noticeable
    */
    always @ (*) begin
        case (NOTE)
            C:       STEP = 32'd22474; // 261.63 Hz
            Csharp:  STEP = 32'd23809; // 277.18 Hz
            D:       STEP = 32'd25225; // 293.66 Hz
            Dsharp:  STEP = 32'd26726; // 311.13 Hz
            E:       STEP = 32'd28315; // 329.63 Hz
            F:       STEP = 32'd29999; // 349.23 Hz
            Fsharp:  STEP = 32'd31782; // 369.99 Hz
            G:       STEP = 32'd33673; // 392.00 Hz
            Gsharp:  STEP = 32'd35674; // 415.30 Hz
            A:       STEP = 32'd37796; // 440.00 Hz
            Asharp:  STEP = 32'd40043; // 466.16 Hz
            B:       STEP = 32'd42424; // 493.88 Hz
            C2:      STEP = 32'd44947; // 523.25 Hz
            Csharp2: STEP = 32'd47620; // 554.37 Hz
            D2:      STEP = 32'd50451; // 587.33 Hz
            Dsharp2: STEP = 32'd53451; // 622.25 Hz
            E2:      STEP = 32'd56630; // 659.26 Hz
            F2:      STEP = 32'd59997; // 698.46 Hz
            Fsharp2: STEP = 32'd63565; // 739.99 Hz
            G2:      STEP = 32'd67344; // 783.99 Hz
            Gsharp2: STEP = 32'd71349; // 830.61 Hz
            A2:      STEP = 32'd75591; // 880.00 Hz
            Asharp2: STEP = 32'd80087; // 932.33 Hz
            B2:      STEP = 32'd84849; // 987.77 Hz
            C3:      STEP = 32'd89901; // 1046.59 Hz
        endcase
    end

    always @ (posedge clock, posedge reset) begin
        if (reset) begin 
            COUNT <= 32'b0; 
        end else begin
            COUNT <= COUNT + STEP;           
        end
    end

    wire [9:0] ADDRESS = COUNT[31:22];
    always @ (posedge clock, posedge reset) begin
        if (reset) begin
            OUT <= 32'b0; 
        end else begin
        OUT <= SINE_LUT[ADDRESS];
        end
    end
endmodule

module square_gen (FREQUENCY, OUT, clock, reset);
    input [4:0] FREQUENCY;
    input clock, reset;

    output [31:0] OUT;
endmodule

module saw_gen (FREQUENCY, OUT, clock, reset);
    input [4:0] FREQUENCY;
    input clock, reset;

    output [31:0] OUT;
endmodule