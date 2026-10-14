`timescale 1ns / 1ps



module tb_d_flip_flop;
reg d,clk;
wire q;
d_flip_flop uut(.d(d),.clk(clk),.q(q));
always #5 clk = ~clk;
initial begin
    clk = 0;
    d=0;
    #12 d = 1;
    #10 d = 0;
    #12 d = 1;
    #10 $finish;
    end
    

endmodule
