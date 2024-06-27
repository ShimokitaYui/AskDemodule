function AskDeMode(IsPlot, IsOutput)

if nargin < 1
    IsPlot = 1;
    IsOutput = 1;
end

Rb = 1*10^6;
Fs = 8*10^6;
a = 0.8;

[ASK2,ASK2_filter,ASK4,ASK4_filter]=AskMod();
figure(4);
subplot(211);plot(20*log10(abs(fft(ASK2))));
subplot(212);plot(20*log10(abs(fft(ASK2_filter))));

ASK2=abs(ASK2);
ASK2_filter=abs(ASK2_filter);

ASK4=abs(ASK4);
ASK4_filter=abs(ASK4_filter);

figure(5);
subplot(211);plot(20*log10(abs(fft(ASK2))));
subplot(212);plot(20*log10(abs(fft(ASK2_filter))));

b=fir1(32,Rb*2/Fs);
d_ASK2=filter(b,1,ASK2);
d_ASK2_filter=filter(b,1,ASK2_filter);
d_ASK4=filter(b,1,ASK4);
d_ASK4_filter=filter(b,1,ASK4_filter);


%量化数据并写入文本文件中
if IsOutput==1
%     %量化滤波系数
    Qn=12;       %12比特量化
    q_b=round(b/max(abs(b))*(2^(Qn-1)-1));
    %将生成的滤波器系数数据写入FPGA所需的txt文件中
    %fid=fopen('.\lpf.txt','w');
    %fprintf(fid,'%12.12f\r\n',b);
    %fclose(fid);
    
    sumb=sum(abs(q_b))
end

FilterToCOE(b,'.\lpf.coe');

%绘图
if IsPlot==1 
    figure(1);x=0:200;x=x/Fs*(10^6);
    subplot(221);plot(x,ASK2(100:300));xlabel('时间(us)');ylabel('幅度(v)');
    title('整流后的2ASK时域波形');grid on;
    subplot(222);plot((0:200),ASK2_filter(100:300));;xlabel('时间(us)');ylabel('幅度(v)');
    title('整流后的2ASK(成形滤波)时域波形');grid on;
    subplot(223);plot((0:200),ASK4(100:300));;xlabel('时间(us)');ylabel('幅度(v)');
    title('整流后的4ASK时域波形');grid on;
    subplot(224);plot((0:200),ASK4_filter(100:300));;xlabel('时间(us)');ylabel('幅度(v)');
    title('整流后的4ASK(成形滤波)时域波形');grid on;

    figure(2);x=0:200;x=x/Fs*(10^6);
    subplot(221);plot(x,d_ASK2(100:300));xlabel('时间(us)');ylabel('幅度(v)');
    title('解调2ASK的基带时域波形');grid on;
    subplot(222);plot((0:200),d_ASK2_filter(100:300));;xlabel('时间(us)');ylabel('幅度(v)');
    title('解调2ASK(成形滤波)的基带时域波形');grid on;
    subplot(223);plot((0:200),d_ASK4(100:300));;xlabel('时间(us)');ylabel('幅度(v)');
    title('解调4ASK的基带时域波形');grid on;
    subplot(224);plot((0:200),d_ASK4_filter(100:300));;xlabel('时间(us)');ylabel('幅度(v)');
    title('解调4ASK(成形滤波)的基带时域波形');grid on;
    
    figure(3);
    freqz(q_b);
end


