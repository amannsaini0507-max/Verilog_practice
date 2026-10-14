`timescale 1ns / 1ps



module dff_sync_reset(
input wire d,clk,reset,
output reg q
    );
    always @(posedge clk) begin
    if(reset)begin 
        q<=0;
        end
    else begin
        q<=d;
    end
    
    end
endmodule
