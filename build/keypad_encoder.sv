module keypad_encoder(
    input logic pin1,pin2,pin3,pin4,pin5,pin6,pin7,pin8,
    output logic [3:0] keycode,
    output logic read, modekey
);

logic [3:0] out;
logic [7:0] code;

assign code = {pin1,pin2,pin3,pin4,pin5,pin6,pin7,pin8};

always_comb begin 
    case(code)
        8'b10001000: out=4'b0000; //C 
        8'b10000100: out=4'b0001; //C#
        8'b10000010: out=4'b0010; //D
        8'b10000001: out=4'b0011; //D#
        8'b01001000: out=4'b0100; //E
        8'b01000100: out=4'b0101; //F
        8'b01000010: out=4'b0110; //F#
        8'b01000001: out=4'b0111; //G
        8'b00101000: out=4'b1000; //G#
        8'b00100100: out=4'b1001; //A
        8'b00100010: out=4'b1010; //A#
        8'b00100001: out=4'b1011; //B
        8'b00011000: out=4'b1100; //C
        8'b00010100: out=4'b1101; //not used 
        8'b00010010: out=4'b1110; //not used
        8'b00010001: out=4'b1111; //mode key
        default: out=4'b0;
    endcase
    if (pin1|pin2|pin3|pin4|pin5|pin6|pin7|pin8) begin
        read = 1'b1;
    end else begin
        read = 1'b0;
    end
end

always_comb begin
    keycode=4'b0;
    modekey=1'b0;
    case(out)
        4'b0000: keycode=4'd1;
        4'b0001: keycode=4'd2;
        4'b0010: keycode=4'd3;
        4'b0011: keycode=4'd4;
        4'b0100: keycode=4'd5;
        4'b0101: keycode=4'd6;
        4'b0110: keycode=4'd7;
        4'b0111: keycode=4'd8;
        4'b1000: keycode=4'd9;
        4'b1001: keycode=4'd10;
        4'b1010: keycode=4'd11;
        4'b1011: keycode=4'd12;
        4'b1100: keycode=4'd13; 
        // 4'b1101: num=4'd0; 
        // 4'b1110: num=4'd15;
        4'b1111: modekey=1'b1;
        default: begin
            keycode=4'b0;
            modekey=1'b0;
        end
    endcase
end


        //  out=4'b0000; 1
        //  out=4'b0001; 2
        //  out=4'b0010; 3
        //  out=4'b0011; A
        //  out=4'b0100; 4
        //  out=4'b0101; 5
        //  out=4'b0110; 6
        //  out=4'b0111; B
        //  out=4'b1000; 7
        //  out=4'b1001; 8
        //  out=4'b1010; 9
        //  out=4'b1011; C
        //  out=4'b1100; * 
        //  out=4'b1101; 0 
        //  out=4'b1110; #
        //  out=4'b1111; D

endmodule