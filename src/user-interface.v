module seg7 (CODE, HEX);
    input [5:0] CODE;
    output reg [6:0] HEX;

    always @ (*) begin
        case (CODE)
            hexA:       HEX = 7'b0001000;
            hexB:       HEX = 7'b0000011;
            hexC:       HEX = 7'b1000110;
            hexD:       HEX = 7'b0100001;
            hexE:       HEX = 7'b0000110;
            hexF:       HEX = 7'b0001110;
            hexG:       HEX = 7'b1000010;
            hexH:       HEX = 7'b0001001;
            hexI:       HEX = 7'b1001111;
            hexJ:       HEX = 7'b1100001;
            hexK:       HEX = 7'b0001010;
            hexL:       HEX = 7'b1000111;
            hexM:       HEX = 7'b0101011;
            hexN:       HEX = 7'b1001000;
            hexO:       HEX = 7'b0100011;
            hexP:       HEX = 7'b0001100;
            hexQ:       HEX = 7'b0011000;
            hexR:       HEX = 7'b0101111;
            hexS:       HEX = 7'b0010010;
            hexT:       HEX = 7'b0000111;
            hexU:       HEX = 7'b0000001;
            hexV:       HEX = 7'b1100011;
            hexW:       HEX = 7'b1100011;
            hexX:       HEX = 7'b1101011;
            hexY:       HEX = 7'b0010001;
            hexZ:       HEX = 7'b1100100;
            hex0:       HEX = 7'b0100000;
            hex1:       HEX = 7'b0000000;
            hex2:       HEX = 7'b0000000;
            hex3:       HEX = 7'b0000000;
            hex4:       HEX = 7'b0000000;
            hex5:       HEX = 7'b0000000;
            hex6:       HEX = 7'b0000000;
            hex7:       HEX = 7'b0000000;
            hex8:       HEX = 7'b0000000;
            hex9:       HEX = 7'b0000000;
            default:    HEX = 7'b1111111;
        endcase
    end
endmodule