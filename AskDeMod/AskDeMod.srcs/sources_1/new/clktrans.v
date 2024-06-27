`timescale 1ns / 1ps
module clktrans(
    input   I_Rst   ,
    input   I_Clk_32,
    output  O_Clk_D1,
    output  O_Clk_D2 
);
reg [1:0] R_c = 2'd0;
reg R_Clk_1, R_Clk_2;
always @(posedge I_Clk_32) begin
    if(I_Rst) begin
        R_c = 0;
        R_Clk_1 <= 1'b0;
        R_Clk_2 <= 1'b0;
    end
    else begin
        R_c = R_c+1'b1;
        if(R_c == 0) begin
            R_Clk_1 <= 1'b1;
            R_Clk_2 <= 1'b0;
        end
        else if(R_c == 2) begin
            R_Clk_1 <= 1'b0;
            R_Clk_2 <= 1'b1;
        end
        else begin
            R_Clk_1 <= 1'b0;
            R_Clk_2 <= 1'b0;
        end
    end
end
assign O_Clk_D1 = R_Clk_1;
assign O_Clk_D2 = R_Clk_2;
endmodule
