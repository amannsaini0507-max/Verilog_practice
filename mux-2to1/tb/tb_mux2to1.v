`timescale 1ns / 1ps



module tb_mux2to1;
reg a,b,sel;
wire out;
mux2to1 d1(.a(a),.b(b),.sel(sel),.out(out));
initial begin
    a = 1'b0 ; b=1'b1 ; sel = 1'b0;
    #10;
    a = 1'b0 ; b = 1'b1 ; sel = 1'b1;
    #10;
    a = 1'b1 ; b = 1'b0 ; sel = 1'b0;
    #10;
    a = 1'b1 ; b = 1'b0 ; sel = 1'b1 ;
    #10;
    $finish;
    end
    
endmodule
