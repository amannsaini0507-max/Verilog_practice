`timescale 1ns / 1ps



module tb_operator_lab;
reg [3:0] a,b;
wire [3:0] w1;
wire w2,w3;
operator_lab d1(.a(a),.b(b),.bitwise_and(w1), .logical_and(w2), .equal(w3));
initial begin 
    a = 4'b0000 ; b=4'b1010 ;
    #10;
    a = 4'b1010 ; b = 4'b1100 ;
    #10;
    a = 4'b1010 ; b = 4'b1010 ;
    #10;
    $finish;
    end
endmodule
