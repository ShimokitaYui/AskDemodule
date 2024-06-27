module AskGate(
    input I_Clk,
    input I_Rst,
    
    input signed [13:0] I_D,
    output signed [13:0] O_D
);

reg [13:0] R_Shift[255:0];
integer i,j;

always @(posedge I_Clk) begin
    if(I_Rst) begin
        for(i=0;i<=255;i=i+1)
            R_Shift[i]=14'd0;
    end
    else begin
        for(j=0;j<=254;j=j+1)
            R_Shift[j+1]<=R_Shift[j];
        R_Shift[0]<=I_D;
    end
end

reg signed [21:0] R_Sum;
always @(posedge I_Clk) begin
    if(I_Rst) begin
        R_Sum <= 22'd0;
    end
    else begin
        R_Sum <= R_Sum + {{8{I_D[13]}},I_D} - {{8{R_Shift[255][13]}},R_Shift[255]};
    end
end

assign O_D = R_Sum[21:8];

endmodule 
