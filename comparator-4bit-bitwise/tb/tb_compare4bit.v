`timescale 1ns / 1ps



module tb_compare4bit;
reg[3:0] a,b;
wire a_gt_b,a_lt_b,a_eq_b;
comparator4bit_logic d1 (.a(a), .b(b), .a_gt_b(a_gt_b), .a_lt_b(a_lt_b), .a_eq_b(a_eq_b));
initial begin 
    a = 4'b0010 ; b = 4'b0101; #10;
     a = 4'b1000 ; b = 4'b0011; #10;
      a = 4'b0110 ; b = 4'b0110; #10;
       a = 4'b0000 ;  b = 4'b1111; #10;
        a = 4'b1111 ; b = 4'b0000; #10;
         a = 4'b1010 ; b = 4'b1011; #10;
         $finish;
         end
         
endmodule
