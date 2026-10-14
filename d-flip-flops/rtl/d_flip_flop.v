`timescale 1ns / 1ps



module d_flip_flop(
input wire d,clk,
output reg q
    );
    always @(posedge clk)begin
    q<=d;
    end
endmodule
