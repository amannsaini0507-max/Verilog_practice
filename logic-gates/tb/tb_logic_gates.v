`timescale 1ns / 1ps



module tb_logic_gates;
reg a,b;
wire y_and, y_or, y_not, y_xor, y_nand, y_nor;
logic_gates t1(.a(a),.b(b),.y_nand(y_nand),.y_nor(y_nor),.y_and(y_and),.y_or(y_or),.y_not(y_not),.y_xor(y_xor));
initial begin 
    a = 0 ; b=0;
    #10;
    a=0; b=1 ;
    #10;
    a=1 ; b=0 ;
    #10;
    a=1 ; b=1 ;
    #10;
    $finish;
end
    
    
    
    
endmodule
