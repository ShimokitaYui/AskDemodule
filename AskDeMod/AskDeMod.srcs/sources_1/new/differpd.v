`timescale 1ns / 1ps
module differpd(
    input I_Rst,
    input I_Clk_32,
    input I_Din,
    input I_Clk_i,
    input I_Clk_q,
    output O_Pd_bef,
    output O_Pd_aft
);
reg R_Din_D, R_Din_Edge;
reg R_Pd_bef, R_Pd_aft;

always @(posedge I_Clk_32) begin
    if(I_Rst) begin
        R_Din_D <= 1'b0;
        R_Din_Edge <= 1'b0;
        R_Pd_bef <= 1'b0;
        R_Pd_aft <= 1'b0;
    end
    else begin
        R_Din_D <= I_Din;
        R_Din_Edge <= (R_Din_D ^ I_Din);//检测跳变边缘
        R_Pd_bef <= (R_Din_Edge & I_Clk_i);
        R_Pd_aft <= (R_Din_Edge & I_Clk_q);
    end
end

assign O_Pd_aft = R_Pd_aft;
assign O_Pd_bef = R_Pd_bef;

endmodule
