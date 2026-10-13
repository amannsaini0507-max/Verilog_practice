`timescale 1ns / 1ps



module bitwise_lab(
input wire [3:0]a,b,
output wire [3:0] y_and,y_or,y_xor,y_not_a 
    );
    assign y_and = a&b ;
    assign y_or = a|b ;
    assign y_xor = a^b ;
    assign y_not_a = ~a;
endmodule
