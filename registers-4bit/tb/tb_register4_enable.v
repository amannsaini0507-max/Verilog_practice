
`timescale 1ns / 1ps

module tb_register4_enable;

reg clk, enable;
reg [3:0] d;
wire [3:0] q;

register4_enable uut (
    .clk(clk),
    .enable(enable),
    .d(d),
    .q(q)
);

// Clock period = 10 ns
always #5 clk = ~clk;

initial begin
    clk = 0;
    enable = 0;
    d = 4'b0000;

    // Test 1: Disabled
    #10;
    d = 4'b1010;

    // Test 2: Enabled
    #10;
    enable = 1;

    // Test 3: Change input while enabled
    #10;
    d = 4'b0111;

    // Test 4: Disable and change input
    #10;
    enable = 0;
    d = 4'b1100;

    // Test 5: Re-enable
    #10;
    enable = 1;

    #10;
    $finish;
end

endmodule

