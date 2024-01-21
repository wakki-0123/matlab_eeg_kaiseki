function [heart_start,heart_end] = csv_heart(eegevent_start,eegevent_end,file1)

%addpath('C:\Users\iw200\OneDrive\ドキュメント\MATLAB\Examples\R2023b\matlab\EEG\eeglab2023.1')

%脳波の得るべきデータのスタートのサンプル数とゴールのサンプル数が分かれば秒数が出る

eeg_start = (eegevent_start - 126) / 125 + 1 ;% 秒数(start)
eeg_end = (eegevent_end - 126) / 125 + 1;  % 秒数(end)

% 脳波の経過秒数から心拍データの秒数と照らし合わせる

% disp(eeg_start);
% disp(eeg_end);




%一応この関数で，心拍データの取り出すべき時間の範囲が分かった．

%心拍のデータの読み込み
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%file1 = 'heart_RRI.csv'; %心拍のデータのパスを入れる

b = readmatrix(file1);
b1 = b(:,1);

l1 = length(b1);

% ある数字より小さいかつ最も近いデータを抜き出す
heart_end = Inf; % 初期値を無限大に設定
for i = 1:length(b1)
    if b1(i) < eeg_end && abs(eeg_end - b(i)) < abs(eeg_end - heart_end)
        heart_end = b1(i);
        end_index= i;

    end
end

heart_start = Inf;% 初期値を無限大に設定

% ある数字に一番近くて指定した数字より大きくないデータを抜き出す

for i = 1:length(b1)
    if b1(i) >= eeg_start && abs(eeg_start - b1(i)) < abs(eeg_start - heart_start)
        heart_start = b1(i);
        start_index = i;
    end
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %心拍データの取るべき時間
 % disp(heart_start);
 % disp(heart_end);



 %心拍データの抽出
time = b(start_index:1:end_index,1);
RRI = b(start_index:1:end_index,2);

 file = 'heart_RRI_complete_0120.csv';
  %csvに書き出し
 combinedata = [time,RRI];
 writematrix(combinedata,file); %ファイル名は任意

 disp(['心拍データのCSVファイルが保存されました: ' file]);
 %disp(file)





