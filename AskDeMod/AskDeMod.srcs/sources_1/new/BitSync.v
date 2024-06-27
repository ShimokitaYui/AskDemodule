`timescale 1ps / 1ps
module BitSync(
    input I_Rst,
    input I_Clk, //32MHz
    input I_Din,
    output O_Sync
);

wire clk_d1, clk_d2;
clktrans clktrans_inst(
    .I_Rst(I_Rst),
    .I_Clk_32(I_Clk), 
    .O_Clk_D1(clk_d1),
    .O_Clk_D2(clk_d2)
);

wire W_Clk_i, W_Clk_q, W_Pd_bef, W_Pd_aft;
differpd differpd_inst(
    .I_Rst(I_Rst),
    .I_Clk_32(I_Clk),
    .I_Din(I_Din),
    .I_Clk_i(W_Clk_i),
    .I_Clk_q(W_Clk_q),
    .O_Pd_bef(W_Pd_bef),
    .O_Pd_aft(W_Pd_aft)
);
wire W_Pd_before, W_Pd_after;

monostable monostable_before(
    .I_Rst      (I_Rst),
    .I_Clk_32   (I_Clk),
    .I_Din      (W_Pd_bef),
    .O_Dout     (W_Pd_before) 
);

monostable monostable_after(
    .I_Rst      (I_Rst),
    .I_Clk_32   (I_Clk),
    .I_Din      (W_Pd_aft),
    .O_Dout     (W_Pd_after) 
);

controldivfreq controldivfreq_inst(
    .I_Rst      (I_Rst),
    .I_Clk_32   (I_Clk),
    .I_Clk_D1   (clk_d1),
    .I_Clk_D2   (clk_d2),
    .I_Pd_bef   (W_Pd_before),
    .I_Pd_aft   (W_Pd_after),
    .O_Clk_i    (W_Clk_i),
    .O_Clk_q    (W_Clk_q) 
);
assign O_Sync = W_Clk_i;
endmodule
