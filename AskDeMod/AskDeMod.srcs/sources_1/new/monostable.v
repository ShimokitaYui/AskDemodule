`timescale 1ns / 1ps
module monostable(
    input I_Rst,
    input I_Clk_32,
    input I_Din,
    output O_Dout
); //产生持续4个I_Clk_32时钟周期的高

reg [1:0] R_c;
reg R_s,R_Dtem;
always @(posedge I_Clk_32) begin
    if(I_Rst) begin
        R_c = 0;
        R_s = 0;
        R_Dtem <= 1'b0;
    end
    else begin
        if(I_Din) begin
            R_s = 1'b1;
            R_Dtem <= 1'b1;
        end
        if(R_s) begin
            R_Dtem <= 1'b1;
            if(R_c < 3) 
                R_c = R_c + 2'b01;
            else
                R_s = 1'b0;
        end
        else begin
            R_c = 0;
            R_Dtem <= 1'b0;
        end
    end
end

assign O_Dout = R_Dtem;

endmodule
