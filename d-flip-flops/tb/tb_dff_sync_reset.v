
`timescale 1ns / 1ps

module tb_dff_sync_reset;

reg clk, reset, d;
wire q;

dff_sync_reset uut (
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
    #10 reset = 1;
    #10 reset = 0;
    #10 d = 0;
    #10 $finish;
end

endmodule