`timescale 1ns / 1ps
module controldivfreq(
    input I_Rst,
    input I_Clk_32,
    input I_Clk_D1,
    input I_Clk_D2,
    input I_Pd_bef,
    input I_Pd_aft,
    output O_Clk_i,
    output O_Clk_q
);
wire W_Gate_Open, W_Gate_Close, W_Clk_In;
assign W_Gate_Open = (~I_Pd_bef) & I_Clk_D1;
assign W_Gate_Close = (I_Pd_aft) & I_Clk_D2;

assign W_Clk_In = W_Gate_Open | W_Gate_Close;

reg R_Clki,R_Clkq;
reg [2:0] c;
always @(posedge I_Clk_32) begin
    if(I_Rst) begin
        c = 0;
        R_Clki <= 1'b0;
        R_Clkq <= 1'b0;
    end
    else begin
        if(W_Clk_In) 
            c = c + 3'b001;
        R_Clki <= ~c[2];
        R_Clkq <= c[2];
    end
end

assign O_Clk_i = R_Clki;
assign O_Clk_q = R_Clkq;

endmodule
