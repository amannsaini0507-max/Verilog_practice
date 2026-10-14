`timescale 1ns / 1ps



module dff_async_reset(
input wire d,clk,reset,
output reg q
    );
    always @(posedge clk or posedge reset)begin
        if(reset)begin
            q<=0;
        end
        else begin
            q<=d;
        end
        
    end
    
endmodule
