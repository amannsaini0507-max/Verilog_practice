
`timescale 1ns / 1ps

module tb_counter4;

    reg clk, reset;
    wire [3:0] q;

    counter4 uut (
        .clk(clk),
        .reset(reset),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10 reset = 0;
        #180 $finish;
    end

endmodule
