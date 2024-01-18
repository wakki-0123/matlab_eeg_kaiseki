function file =  eeg_ica(EEG_file,ch1,file)


% EEG_file　ICA実行後のsetファイル
% EEGLABを開始
eeglab;


%ICA実行後のsetファイル
EEG_file = pop_loadset(EEG_file); % ファイル名は適切に変更してください

EEG_file = pop_subcomp(EEG_file,[ch1],0); %　8chから除くチャンネルを決める．(分類して，図を確認することでわかる)chを除いている．

%出力先のファイル
%file = 'yasuda1_ica_kekka.set';

% 切り出したデータの保存
pop_saveset(EEG_file, file); % 保存するファイル名は適切に変更してください(任意指定)

 disp(['ICA後の脳波データのCSVファイルが保存されました: ' file]);


