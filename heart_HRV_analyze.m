function heart_HRV_analyze
% HRVを表示するプログラム
file = 'heart_HRV_complete_ebato0128.csv';
data = readmatrix(file);
data1 = data(:,1);
data3 = data(:,3);

figure
plot(data1,data3,'r');
title('HRV')
xlabel('sec[s]')
ylabel('LF/HF')
end