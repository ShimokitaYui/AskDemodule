%产生2ASK,4ASK信号
%Len:码元长度
%IsPlot:是否绘图
%IsOutput:是否输出到文本文件中

function [ASK2,ASK2_filter,ASK4,ASK4_filter]=AskMod(Len,IsPlot,IsOutput)

if nargin < 1
    Len = 1000;
    IsPlot = 1;
    IsOutput = 1;
end;

Rb=1*10^6; %码元速率
Fs=8*Rb;   %采样频率
LenData=Len*Fs/Rb; %信号长度 一个码元采样8次 一共Len个码元
Fc=70*10^6; %载波频率 70MHz
Qn=8;       %量化位宽
a=0.8;      %成形滤波器滚降因子

%产生载波信号
t=0:1/Fs:Len/Rb;
carrier = cos(2*pi*Fc*t);
carrier = carrier(1:LenData);

%生成随机分布的二进制信号
code_2ask=randi([0,1],1,Len);
code_2ask_upsamp=rectpulse(code_2ask,Fs/Rb);
% Raised Cosine 滤波器的设计
code_2ask_filter = my_rcosflt(code_2ask_upsamp,8);

ASK2=carrier.*code_2ask_upsamp;
ASK2_filter=carrier.*code_2ask_filter(1:LenData);

ASK2_Spec=20*log10(abs(fft(ASK2,1024)));
ASK2_Spec=ASK2_Spec-max(ASK2_Spec);

ASK2_filter_Spec=20*log10(abs(fft(ASK2_filter,1024)));
ASK2_filter_Spec=ASK2_filter_Spec-max(ASK2_filter_Spec);

code_4ask=randi([0,3],1,Len);
code_4ask_upsamp=rectpulse(code_4ask,Fs/Rb);
code_4_filter=my_rcosflt(code_4ask_upsamp,8);

ASK4=carrier.*code_4ask_upsamp;
ASK4_filter=carrier.*code_4_filter(1:LenData);

ASK4_Spec=20*log10(abs(fft(ASK4,1024)));
ASK4_Spec=ASK4_Spec-max(ASK4_Spec);

ASK4_filter_Spec=20*log10(abs(fft(ASK4_filter,1024)));
ASK4_filter_Spec=ASK4_filter_Spec-max(ASK4_filter_Spec);


%绘图
if IsPlot==1 
    figure(1);x=0:1000;x=x/Fs*(10^6);
    subplot(221);plot(x,ASK2(100:1100));xlabel('时间(us)');ylabel('幅度(v)');
    title('未经成形滤波的2ASK时域波形');grid on;
    subplot(222);plot((0:1000),ASK2_filter(100:1100));;xlabel('时间(us)');ylabel('幅度(v)');
    title('成形滤波后的2ASK时域波形');grid on;
    subplot(223);plot((0:1000),ASK4(100:1100));;xlabel('时间(us)');ylabel('幅度(v)');
    title('未经成形滤波的4ASK时域波形');grid on;
    subplot(224);plot((0:1000),ASK4_filter(100:1100));;xlabel('时间(us)');ylabel('幅度(v)');
    title('成形滤波后的4ASK时域波形');grid on;

    figure(2);x=0:length(ASK2_Spec)-1;x=x/length(x)*Fs/10^6;
    subplot(221);plot(x,ASK2_Spec);xlabel('频率(MHz)');ylabel('幅度(dB)');
    title('未经成形滤波的2ASK频谱');grid on;
    subplot(222);plot(x,ASK2_filter_Spec);xlabel('频率(MHz)');ylabel('幅度(dB)');
    title('成形滤波后的2ASK频谱');grid on;
    subplot(223);plot(x,ASK4_Spec);xlabel('频率(MHz)');ylabel('幅度(dB)');
    title('未经成形滤波的4ASK频谱');grid on;
    subplot(224);plot(x,ASK4_filter_Spec);xlabel('频率(MHz)');ylabel('幅度(dB)');
    title('成形滤波后的4ASK频谱');grid on;
end;
    
if IsOutput == 1
    norm_Data=ASK2/max(abs(ASK2));
    Q_s=round(norm_Data*(2^(Qn-1)-1));
    fid=fopen('.\ASK2.txt','w');
    for i=1:length(Q_s)
        B_s=dec2bin(Q_s(i)+(Q_s(i)<0)*2^Qn,Qn);
        for j=1:Qn
            if B_s(j)=='1'
                tb=1;
            else
                tb=0;
            end
            fprintf(fid,'%d',tb);
        end
        fprintf(fid,'\r\n');
    end
    fprintf(fid,';');
    fclose(fid);

    norm_Data=ASK2_filter/max(abs(ASK2_filter));
    Q_s=round(norm_Data*(2^(Qn-1)-1));
    fid=fopen('.\ASK2_filter.txt','w');
    for i=1:length(Q_s)
        B_s=dec2bin(Q_s(i)+(Q_s(i)<0)*2^Qn,Qn);
        for j=1:Qn
            if B_s(j)=='1'
                tb=1;
            else
                tb=0;
            end
            fprintf(fid,'%d',tb);
        end
        fprintf(fid,'\r\n');
    end
    fprintf(fid,';');
    fclose(fid);

    norm_Data=ASK4/max(abs(ASK4));
    Q_s=round(norm_Data*(2^(Qn-1)-1));
    fid=fopen('.\ASK4.txt','w');
    for i=1:length(Q_s)
        B_s=dec2bin(Q_s(i)+(Q_s(i)<0)*2^Qn,Qn);
        for j=1:Qn
            if B_s(j)=='1'
                tb=1;
            else
                tb=0;
            end
            fprintf(fid,'%d',tb);
        end
        fprintf(fid,'\r\n');
    end
    fprintf(fid,';');
    fclose(fid);

    norm_Data=ASK4_filter/max(abs(ASK4_filter));
    Q_s=round(norm_Data*(2^(Qn-1)-1));
    fid=fopen('.\ASK4_filter.txt','w');
    for i=1:length(Q_s)
        B_s=dec2bin(Q_s(i)+(Q_s(i)<0)*2^Qn,Qn);
        for j=1:Qn
            if B_s(j)=='1'
                tb=1;
            else
                tb=0;
            end
            fprintf(fid,'%d',tb);
        end
        fprintf(fid,'\r\n');
    end
    fprintf(fid,';');
    fclose(fid);
end;