`timescale 1ns / 1ps



module up_down_counter(
input wire clk,reset,direction,enable,
output reg[3:0] q
    );
    always @(posedge clk)begin
        if(reset) begin
            q<=4'b0000;
        end
        else begin
            if(enable) begin
                if(direction)begin
                    q<=q+4'b0001;
                end
                else begin
                    q<=q-4'b0001;
                end
            end
        end
    end
endmodule
