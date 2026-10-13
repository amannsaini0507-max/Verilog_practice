`timescale 1ns / 1ps



module mux2to1_bool(
input wire a,b,sel,
output wire out
    );
    assign out = ((~sel)&a) | (sel & b);
endmodule
