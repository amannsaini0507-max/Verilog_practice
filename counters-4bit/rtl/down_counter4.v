`timescale 1ns / 1ps


module down_counter4(
input clk,reset,enable,

output reg [3:0] q
    );
    always @(posedge clk) begin
        if(reset)begin
            q<=4'b0000;
        end
        else begin
            if(enable) begin
                q<=q-4'b0001;
            end
        end
    end
endmodule
