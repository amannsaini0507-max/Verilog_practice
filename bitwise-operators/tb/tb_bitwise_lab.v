`timescale 1ns / 1ps



module tb_bitwise_lab;
reg [3:0] a,b ;
wire [3:0] y_and,y_or,y_xor,y_not_a;
bitwise_lab b1 (.a(a),.b(b),.y_and(y_and),.y_or(y_or),.y_xor(y_xor),.y_not_a(y_not_a));
initial begin 
    a=4'b1010 ; b=4'b1100;
    #10;
    a=4'b0110 ; b=4'b0011 ;
    #10;
    $finish;
    end
    
endmodule
