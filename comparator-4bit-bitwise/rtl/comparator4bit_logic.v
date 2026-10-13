`timescale 1ns / 1ps

module comparator4bit_logic(
    input wire [3:0] a,
    input wire [3:0] b,
    output reg a_gt_b,
    output reg a_lt_b,
    output reg a_eq_b
);
    always @(*) begin
        if ((a[3] ^ b[3])) begin
            a_gt_b = (~a[3] & b[3]) ? 0 : 1;
            a_lt_b = (~a[3] & b[3]) ? 1 : 0;
            a_eq_b = 0;
        end
        else if ((a[2] ^ b[2])) begin
            a_gt_b = (~a[2] & b[2]) ? 0 : 1;
            a_lt_b = (~a[2] & b[2]) ? 1 : 0;
            a_eq_b = 0;
        end
        else if ((a[1] ^ b[1])) begin
            a_gt_b = (~a[1] & b[1]) ? 0 : 1;
            a_lt_b = (~a[1] & b[1]) ? 1 : 0;
            a_eq_b = 0;
        end
        else if ((a[0] ^ b[0])) begin
            a_gt_b = (~a[0] & b[0]) ? 0 : 1;
            a_lt_b = (~a[0] & b[0]) ? 1 : 0;
            a_eq_b = 0;
        end
        else begin
            a_eq_b = 1;
            a_gt_b = 0;
            a_lt_b = 0;
        end
    end
endmodule
