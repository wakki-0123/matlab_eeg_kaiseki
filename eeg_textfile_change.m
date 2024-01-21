function eeg_textfile_change()
file = 'ebato_0120_data.txt'
% bdfbrowserを使用して、eegのテキストファイルを取得した後に脳波ファイルをeeglabに適用できるように直すプログラム
f0 = readmatrix(file);
f1 = f0(2:end,2:9);

filename = 'ebato_0120_data_1837.txt';
writematrix(f1,filename)


