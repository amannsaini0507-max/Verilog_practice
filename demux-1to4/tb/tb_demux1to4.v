`timescale 1ns / 1ps



module tb_demux1to4;
reg d;
reg [1:0] sel;
wire [3:0] y;
demux1to4 d1(.d(d),.sel(sel),.y(y));
initial begin
d = 1'b0 ; sel = 2'b00; #10;
d = 1'b1 ; sel = 2'b00; #10;
d = 1'b1 ; sel = 2'b01; #10;
d = 1'b1 ; sel = 2'b10; #10;
d = 1'b1 ; sel = 2'b11; #10;
d = 1'b0 ; sel = 2'b10; #10;
d = 1'b0 ; sel = 2'b11; #10;
$finish;
end

endmodule
