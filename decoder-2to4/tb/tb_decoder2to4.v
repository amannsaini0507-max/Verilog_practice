`timescale 1ns / 1ps



module tb_decoder2to4;
reg en;
reg [1:0] a;
wire [3:0] y;
decoder2to4 d1 (.a(a),.en(en),.y(y));
initial begin
en = 1'b0 ; a = 2'bxx ; #10;
en = 1'b1 ; a = 2'b00 ; #10;
en = 1'b1 ; a = 2'b01 ; #10;
en = 1'b1 ; a = 2'b10 ; #10;
en = 1'b1 ; a = 2'b11 ; #10;
$finish;
end


endmodule
