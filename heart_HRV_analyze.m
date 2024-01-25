function heart_HRV_analyze
% HRVを表示するプログラム
file = 'heart_HRV_complete_0120_full.csv';
data = readmatrix(file);
data1 = data(:,1);
data3 = data(:,3);

figure
plot(data1,data3,'r');
title('HRV')
xlabel('sec[s]')
ylabel('LF/HF')
end