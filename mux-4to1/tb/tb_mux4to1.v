`timescale 1ns / 1ps



module tb_mux4to1;
reg i0,i1,i2,i3;
reg [1:0] sel;
wire out;
mux4to1 d1(.i0(i0),.i1(i1),.i2(i2),.i3(i3),.sel(sel),.out(out));
initial begin
    i0 = 1'b0 ; i1 = 1'b0 ; i2 = 1'b0 ; i3 = 1'b0 ; sel = 2'b00 ;#10;
    i0 = 1'b0 ; i1 = 1'b0 ; i2 = 1'b0 ; i3 = 1'b1 ; sel = 2'b01 ;#10;
    i0 = 1'b0 ; i1 = 1'b0 ; i2 = 1'b1 ; i3 = 1'b0 ; sel = 2'b10 ;#10;
    i0 = 1'b0 ; i1 = 1'b0 ; i2 = 1'b1 ; i3 = 1'b1 ; sel = 2'b00 ;#10;
    i0 = 1'b0 ; i1 = 1'b1 ; i2 = 1'b0 ; i3 = 1'b0 ; sel = 2'b11 ;#10;
    i0 = 1'b0 ; i1 = 1'b1 ; i2 = 1'b0 ; i3 = 1'b1 ; sel = 2'b00 ;#10;
    i0 = 1'b0 ; i1 = 1'b1 ; i2 = 1'b1 ; i3 = 1'b0 ; sel = 2'b00 ;#10;
    i0 = 1'b0 ; i1 = 1'b1 ; i2 = 1'b1 ; i3 = 1'b1 ; sel = 2'b01 ;#10;
    i0 = 1'b1 ; i1 = 1'b0 ; i2 = 1'b0 ; i3 = 1'b0 ; sel = 2'b10 ;#10;
    i0 = 1'b1 ; i1 = 1'b0 ; i2 = 1'b0 ; i3 = 1'b1 ; sel = 2'b00 ;#10;
    i0 = 1'b1 ; i1 = 1'b0 ; i2 = 1'b1 ; i3 = 1'b0 ; sel = 2'b01 ;#10;
    i0 = 1'b1 ; i1 = 1'b0 ; i2 = 1'b1 ; i3 = 1'b1 ; sel = 2'b00 ;#10;
    i0 = 1'b1 ; i1 = 1'b1 ; i2 = 1'b0 ; i3 = 1'b0 ; sel = 2'b11 ;#10;
    i0 = 1'b1 ; i1 = 1'b1 ; i2 = 1'b0 ; i3 = 1'b1 ; sel = 2'b01 ;#10;
    i0 = 1'b1 ; i1 = 1'b1 ; i2 = 1'b1 ; i3 = 1'b0 ; sel = 2'b10 ;#10;
    i0 = 1'b1 ; i1 = 1'b1 ; i2 = 1'b1 ; i3 = 1'b1 ; sel = 2'b01 ;#10;
    $finish;
end

endmodule
