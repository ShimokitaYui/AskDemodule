`timescale 1ps / 1ps
module ASKDemod(
    input                   I_Clk   ,
    input                   I_Rst   ,
    input                   I_Clk_32,
    input   signed [ 7:0]   I_Din   ,
    output  signed [13:0]   O_Dout  ,
    output  signed [13:0]   O_Gate  ,
    output                  O_Data  ,
    output                  O_Sync   
);

(* keep = "true"*) reg signed [7:0] R_Abs_D = 8'd0;//输入信号绝对值
always @(posedge I_Clk) begin
    if(I_Rst) begin
        R_Abs_D <= 8'd0;
    end
    else begin
        if(I_Din[7]) begin
            R_Abs_D <= -I_Din;
        end
        else begin
            R_Abs_D <= I_Din;
        end
    end
end
reg R_Dv = 1'b1;
wire W_Dr;
wire W_Dv;
wire [23:0] W_Y;
lps lps_u (
  .aresetn              (!I_Rst     ),      // input wire aresetn
  .aclk                 (I_Clk      ),      // input wire aclk
  .s_axis_data_tvalid   (R_Dv       ),      // input wire s_axis_data_tvalid
  .s_axis_data_tready   (W_Dr       ),      // output wire s_axis_data_tready
  .s_axis_data_tdata    (R_Abs_D  ),      // input wire [7 : 0] s_axis_data_tdata
  .m_axis_data_tvalid   (W_Dv       ),      // output wire m_axis_data_tvalid
  .m_axis_data_tuser    (           ),      // output wire [0 : 0] m_axis_data_tuser
  .m_axis_data_tdata    (W_Y        )       // output wire [23 : 0] m_axis_data_tdata
);
assign O_Dout = W_Y[21:8];

wire signed [13:0] W_Mean;
AskGate AskGate_inst(
    .I_Clk(I_Clk),
    .I_Rst(I_Rst),
    
    .I_D(W_Y[21:8]),
    .O_D(W_Mean)
);

wire W_Demo;
wire signed [13:0] W_Demo_Data;
assign W_Demo_Data = W_Y[21:8];
assign W_Demo = (W_Demo_Data > W_Mean) ? 1'b1: 1'b0;
wire W_Sync;

BitSync BitSync_inst(
    .I_Rst   (I_Rst),
    .I_Clk   (I_Clk_32),
    .I_Din   (W_Demo),
    .O_Sync  (W_Sync) 
);

reg R_Dout;
always @(posedge W_Sync) begin
    if(I_Rst) begin
        R_Dout <= 1'b0;
    end
    else begin
        R_Dout <= W_Demo;
    end
end

assign O_Data = R_Dout;
assign O_Sync = W_Sync;
assign O_Gate = W_Mean;


endmodule
