`timescale 1ns / 1ps



module demux1to4(
input wire d,
input wire [1:0] sel,
output reg [3:0] y
    );
    always @(*) begin
    if(d==0) begin
        y = 4'b0000;
        end
    else begin
        case(sel)
        2'b00 : y = 4'b0001;
        2'b01 : y = 4'b0010;
        2'b10 : y = 4'b0100;
        2'b11 : y = 4'b1000;
        default : y = 4'b0000;
        endcase
        end
    end
endmodule
