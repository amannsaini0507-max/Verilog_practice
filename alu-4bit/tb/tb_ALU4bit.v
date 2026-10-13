`timescale 1ns / 1ps



module tb_ALU4bit;
reg [3:0] a,b;
reg[1:0] sel;
wire [3:0] out;
wire carry,zero;
ALU4bit d1(.a(a),.b(b),.sel(sel),.out(out),.carry(carry),.zero(zero));
initial begin 
    a = 4'b1111 ; b = 4'b0001; sel = 2'b00; #10;
    a = 4'b1111 ; b = 4'b1111; sel = 2'b00; #10;
    a = 4'b1111 ; b = 4'b1111; sel = 2'b00; #10;
    a = 4'b0011 ; b = 4'b1001; sel = 2'b01;#10;
    a = 4'b0001 ; b = 4'b1111; sel = 2'b10;#10;
    a = 4'b1111 ; b = 4'b1011; sel = 2'b11;#10;
    a = 4'b1011 ; b = 4'b1111; sel = 2'b00;#10;
    a = 4'b1010 ; b = 4'b1001; sel = 2'b01;#10;
    a = 4'b1111 ; b = 4'b1111; sel = 2'b10;#10;
    a = 4'b1010 ; b = 4'b1001; sel = 2'b11;#10;
    $finish;
end
endmodule
