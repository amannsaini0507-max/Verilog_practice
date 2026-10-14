`timescale 1ns / 1ps



module register4_enable(
input wire clk,enable,
input wire[3:0] d,
output reg [3:0] q
    );
    always @(posedge clk) begin
        if(enable)begin
            q<=d;
        end
    end
endmodule
