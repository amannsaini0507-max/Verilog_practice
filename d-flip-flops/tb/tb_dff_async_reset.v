`timescale 1ns / 1ps

module tb_dff_async_reset;

reg clk, reset, d;
wire q;

dff_async_reset uut (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q)
);

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 0;
    d = 0;

    #2  d = 1;
    #6  reset = 1;
    #4  reset = 0;
    #3  d = 0;
    #10 $finish;
end

endmodule
