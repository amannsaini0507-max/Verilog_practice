`timescale 1ns / 1ps



module counter4_enable(
input wire clk,reset,enable,
input wire [3:0] d,
output reg[3:0] q
);
always@(posedge clk) begin
        if(reset) begin
            q<=4'b0000;
        end
        else begin
            if(enable) begin
                q<=q+4'b0001;
            end
        end
    end
endmodule