function FilterToCOE(filt, filename)

fid = fopen(filename, 'w'); % 打开COE文件以写入模式
fprintf(fid, 'radix=10;\n'); % 设置进制为十进制
fprintf(fid, 'coefdata=\n'); % 写入系数向量
for i = 1:length(filt)
    fprintf(fid, '%12.12f,\n', filt(i)); % 逐个写入系数，以逗号分隔
end
fclose(fid); % 关闭文件
end