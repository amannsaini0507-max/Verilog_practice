
`timescale 1ns / 1ps

module tb_counter4_enable;

    reg clk, reset, enable;
    wire [3:0] q;

    counter4_enable uut (
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
        #30 enable = 0;
        #20 enable = 1;
        #30 $finish;
    end

endmodule
