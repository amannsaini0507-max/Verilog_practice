
`timescale 1ns / 1ps

module tb_register4_syncreset_enable;

    reg clk, reset, enable;
    reg [3:0] d;
    wire [3:0] q;

    register4_syncreset_enable uut (
        .reset(reset),
        .clk(clk),
        .enable(enable),
        .d(d),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        enable = 0;
        d = 4'b0000;

        #10; d = 4'b1010;
        #10; enable = 1;
        #10; d = 4'b0111;
        #10; enable = 0; d = 4'b1100;
        #10; reset = 1; enable = 1;
        #10; reset = 0;
        #10; enable = 1;
        #10; $finish;
    end

endmodule

