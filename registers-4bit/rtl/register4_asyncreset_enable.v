`timescale 1ns / 1ps



module register4_asyncreset_enable(
input wire reset,clk,enable,
input wire[3:0] d,
output reg[3:0] q
    );
    always@(posedge clk or posedge reset) begin
        if(reset)begin
            q<=4'b0000;
        end
        else begin
            if(enable)begin
                q<=d;
            end
        end
    end
endmodule
