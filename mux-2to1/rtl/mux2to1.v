`timescale 1ns / 1ps



module mux2to1(
input wire a,b,sel,

output wire out
    );
    assign out = sel ? b:a;
    
endmodule
