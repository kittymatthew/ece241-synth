module keyboard_transfer(clock, reset, data_to_be_transferred, data_transfered_enable, note_out)
    input clock, reset; 
    input [7:0]data_to_be_transferred; 
    input data_transfered_enable;
    reg [4:0]buffer;
    output reg [4:0] note_out;
    parameter: A=8'h1A, S=8'h1B, X=8'h22, D=8'h23, C=8'h21, V=8'h2A, G=8'h34, B=8'h32 , H=8'h33, N=8'h31 ,J=8'h3B, M=8'h3A, Q= 8'h15, 2= 8'h1E, W=8'h1D , 3=8'h26, E=8'h24 , R=8'h2D,5=8'h2E, T=8'h2C, 6=8'h36,Y=8'h35,7=8'h3D,U=8'h3C,I=8'h43;
    parameter C_note = 5'b00001;
    parameter Csharp_note = 5'b00010;
    parameter D_note = 5'b00011;
    parameter Dsharp_note = 5'b00100;
    parameter E_note = 5'b00101;
    parameter F_note = 5'b00110;
    parameter Fsharp_note = 5'b00111;
    parameter G_note = 5'b01000;
    parameter Gsharp_note = 5'b01001;
    parameter A_note = 5'b01010;
    parameter Asharp_note = 5'b01011;
    parameter B_note = 5'b01100;
    parameter C2_note = 5'b01101;
    parameter Csharp2_note = 5'b01110;
    parameter D2_note = 5'b01111;
    parameter Dsharp2_note = 5'b10000;
    parameter E2_note = 5'b10001;
    parameter F2_note = 5'b10010;
    parameter Fsharp2_note = 5'b10011;
    parameter G2_note = 5'b10100;
    parameter Gsharp2_note = 5'b10101;
    parameter A2_note = 5'b10110;
    parameter Asharp2_note = 5'b10111;
    parameter B2_note = 5'b11000;
    parameter C3_note = 5'b11001;

    always@(*)
        begin
            case(data_to_be_transferred):
                A: buffer=C_note; 
                S: buffer=Csharp_note; 
                X: bffer=D_note; 
                D: buffer=Dsharp_note; 
                C: buffer=E_note; 
                V: buffer=F_note; 
                G: buffer=Fsharp_note; 
                B: buffer=G_note; 
                H: buffer=Gsharp_note; 
                N: buffer=A_note; 
                J: buffer=Asharp_note; 
                M: buffer=B_note; 
                Q: buffer=C2_note; 
                2: buffer=Csharp2_note; 
                W: buffer=D2_note; 
                3: buffer=Dsharp2_note; 
                E: buffer=E2_note; 
                R: buffer=F2_note; 
                5: buffer=Fsharp2_note; 
                T: buffer=G2_note; 
                6: buffer=Gsharp2_note; 
                Y: buffer=A2_note; 
                7: buffer=Asharp2_note; 
                U: buffer=B2_note; 
                I: buffer=C3_note; 
                default: buffer=5'b00000;
        endcase
    end
    always@(posedge CLOCK_50)
    begin
        if(reset)begin
            note_out<=0; 
        end
        else if(data_transfered_enable)begin 
            note_out<=buffer;
        end
    end

endmodule
