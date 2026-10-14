
`timescale 1ns / 1ps

module tb_down_counter4;

    reg clk, reset, enable;
    wire [3:0] q;

    down_counter4 uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;

        #10 reset = 0;
        #10 enable = 1;
        #40 enable = 0;
        #20 enable = 1;
        #30 $finish;
    end

endmodule
