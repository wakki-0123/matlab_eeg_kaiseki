function eeg_textfile_change()
file = 'ebato0120_full_data_data.txt';
% bdfbrowserを使用して、eegのテキストファイルを取得した後に脳波ファイルをeeglabに適用できるように直すプログラム
f0 = readmatrix(file);
f1 = f0(2:end,2:9);

filename = 'ebato_0120_full_data_0122.txt';
writematrix(f1,filename)


