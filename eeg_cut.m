function eeg_cut(eegevent_start,eegevent_end,EEG_file, EEG_file_complete)

eeg_start_time = (eegevent_start - 126) / 125 + 1 ;% 秒数(start)
eeg_end_time = (eegevent_end - 126) / 125 + 1;  % 秒数(end)

disp('切り取るべき脳波データの区間　秒数')
disp(eeg_start_time)
disp(eeg_end_time)

eeg_start_sample = eeg_start_time * 125;
eeg_end_sample = eeg_end_time * 125;

disp('切り取るべき脳波データの区間　サンプル数')
disp(eeg_start_sample)
disp(eeg_end_sample)


%この関数ではEEGデータの指定された範囲の切り出し，イベントの設定，ノイズ除去を行う，
% また，イベントデータに関しては手動で得ることで，次のcsv_jikken.mに生かそう

%addpath('C:\Users\iw200\Documents\MATLAB\eeg\eeglab2023.1')
eeglab;
% EEGデータの読み込み
%EEG_file = pop_loadset('ccc1.set'); % ファイル名は適切に変更してください(切り出したいデータのsetファイルを指定)
EEG_file = pop_loadset(EEG_file); % ファイル名は適切に変更してください(切り出したいデータのsetファイルを指定)

% データの切り出し サンプル数でやっている
EEG_file = pop_select(EEG_file, 'point', [eeg_start_sample eeg_end_sample]); % 切り出したい時間範囲を指定してください

%EEG_file_complete = 'meeting_1206.set';

% 切り出したデータの保存
pop_saveset(EEG_file, EEG_file_complete); % 保存するファイル名は適切に変更してください(任意指定)

 disp(['脳波データのsetファイルが保存されました: ' EEG_file_complete]);
 %disp(file)