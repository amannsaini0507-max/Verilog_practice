
`timescale 1ns / 1ps

module tb_up_down_counter;

    reg clk, reset, direction, enable;
    wire [3:0] q;

    up_down_counter uut (
        .clk(clk),
        .reset(reset),
        .direction(direction),
        .enable(enable),
        .q(q)
    );

    // 10 ns clock period
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        direction = 1;  // Count up

        // Reset counter
        #10 reset = 0;

        // Count up: 0000 -> 0001 -> 0010 -> 0011
        enable = 1;
        #30;

        // Hold the count
        enable = 0;
        #20;

        // Count down
        direction = 0;
        enable = 1;
        #30;

        // Test underflow: count down from 0000
        reset = 1;
        #10 reset = 0;
        direction = 0;
        enable = 1;
        #10;

        // Test overflow: count up from 1111
        reset = 1;
        #10 reset = 0;
        direction = 0;
        enable = 1;
        #10; // 0000 -> 1111

        direction = 1;
        #10; // 1111 -> 0000

        $finish;
    end

endmodule

