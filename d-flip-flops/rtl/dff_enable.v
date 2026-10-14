`timescale 1ns / 1ps



module dff_enable(
input wire d,clk,enable,
output reg q
    );
    always @(posedge clk)begin
        if(enable)begin
            q<=d;
        end
    end
endmodule
