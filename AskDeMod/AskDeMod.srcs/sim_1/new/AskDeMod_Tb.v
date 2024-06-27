`timescale 1ns / 1ps
module AskDeMod_Tb();

reg R_Clk = 1'b0;
reg R_Rst = 1'b1;
reg R_Clk_32 = 1'b0;
initial begin
    R_Clk = 1'b1;
    R_Clk_32 = 1'b1;
    R_Rst = 1'b1;

    #110 R_Rst = 1'b0;
end

always #60 R_Clk = ~R_Clk;
always #15 R_Clk_32 = ~R_Clk_32;
reg signed [7:0] R_Data;
reg [7:0] R_Stimulus[1:8000];
integer Pattern;
initial begin
    $readmemb("data_filepath",R_Stimulus);
    Pattern=0;
    repeat(8000)
        begin
            Pattern = Pattern + 1;
            R_Data = R_Stimulus[Pattern];
            #120;
        end
end
wire signed [13:0] W_D;
wire signed [13:0] W_Gate;
wire W_Data;
wire W_Sync;
ASKDemod ASKDemod(
    .I_Clk   (R_Clk),
    .I_Rst   (R_Rst),
    .I_Clk_32(R_Clk_32),
    .I_Din   (R_Data),
    .O_Dout  (W_D),
    .O_Gate  (W_Gate),
    .O_Data  (W_Data),
    .O_Sync  (W_Sync) 
);



endmodule
