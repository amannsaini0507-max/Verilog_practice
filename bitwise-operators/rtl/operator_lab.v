`timescale 1ns / 1ps



module operator_lab(
input wire[3:0] a,b,
output wire[3:0] bitwise_and,
output wire logical_and,equal
    );
    assign bitwise_and = a&b ;
    assign logical_and = a&&b ;
    assign equal = (a==b );
endmodule
