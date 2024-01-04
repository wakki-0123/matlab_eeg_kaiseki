function eeg_tyousei


% EEG構造体から削除したいチャンネルのインデックスを指定
channelToRemove = 1; % 例として1番目のチャンネルを削除

EEG_file = 'ebato2_1130_1207.set';
EEG = pop_loadset(EEG_file); % ファイル名は適切に変更してください(切り出したいデータのsetファイルを指定)

% pop_select関数を使用して指定したチャンネルを削除
EEG = pop_select(EEG, 'nochannel', channelToRemove);


file = 'ebato3_1130_1207.set';
% 更新されたEEG構造体を保存する場合は、必要に応じて以下のコードを使用
 pop_saveset(EEG, file);
