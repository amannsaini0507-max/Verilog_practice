
`timescale 1ns / 1ps

module tb_dff_enable;

reg clk, d, enable;
wire q;

dff_enable uut (
    .clk(clk),
    .d(d),
    .enable(enable),
    .q(q)
);

// Clock generation: 10 ns period
always #5 clk = ~clk;

initial begin
    clk = 0;
    d = 0;
    enable = 0;

    // Test 1: Enable disabled
    #10;
    d = 1;

    // Test 2: Enable enabled
    #10;
    enable = 1;

    // Test 3: Change data while enabled
    #10;
    d = 0;

    // Test 4: Disable and change data
    #10;
    enable = 0;
    d = 1;

    // Test 5: Re-enable
    #10;
    enable = 1;

    #10;
    $finish;
end

endmodule