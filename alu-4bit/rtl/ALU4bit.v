`timescale 1ns / 1ps



module ALU4bit(
input wire [3:0] a,b,
input wire [1:0] sel,
output reg [3:0] out,

output reg zero,carry
    );
     reg [4:0] sum;
    always @(*)begin
    case(sel)
    2'b00 : begin
    sum = {1'b0,a} + {1'b0,b};
            out= sum[3:0];
            carry = sum[4];
            end
            
    2'b01 : begin
            out = a-b;
            carry = 1'b0;
            end
    2'b10 : begin 
            out = a&b;
            carry = 1'b0;
            end
    2'b11 : begin 
            out = a^b;
            carry = 1'b0;
            end
    default : begin 
            out = 4'b0000;
            carry = 1'b0;
            end
    endcase
    if(out == 4'b0000)begin
        zero = 1;
        end
     else begin
        zero = 0;
        end
       
    end
endmodule
