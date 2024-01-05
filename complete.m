function complete(eegevent_start_sample,eegevent_end_sample)

% complete.mがあるファイルパス
%addpath('C:\Users\iw200\OneDrive\ドキュメント\MATLAB\Examples\R2023b\matlab\pupil_data_analyze')

% このプログラムでは，切り取る脳波データのサンプル数の範囲を引数に指定し，入力ファイルと出力ファイルをプログラム内で記載すれば，データの切り出しを自動で行うことが可能である．
% ただし，脳波データについては，手動でICAをかける必要がある．またここでのファイル指定方法は，カレントディレクトリでの指定方法である．

% ASRを行った場合，test_data_load.m にてイベントデータを元に，元のEEG信号の時系列データのサンプル数を出しているファイルを作成した．
% よってtest_data_load.mにおいて作成されたcsvファイルの一番右の列を見ればよい

% 追記　ICAが実装できそうなので，test_data_load.mは使用しない可能性が高い．その場合は切り取る区間を脳波データのサンプル数で表現し，引数に入れてあげればよい．
% EX　complete(125,1250)．サンプリング周波数が125Hzなので，ここでは1秒から10秒間のデータを抜き出すことを表している．
% ただし心拍データの刻み幅が，脳波データと瞳孔データよりも大きいため，実際に得れるデータは心拍データのタイムスタンプに依存している．

%eegevent_start_sample: 取るべきデータのスタートのサンプル数
%eegevent_end_sample: 取るべきデータのエンドのサンプル数

% ファイルについては，このプログラムがあるディレクトリに入れておくこと．
% 瞳孔データのgzファイルを展開
addpath 'C:\Users\iw200\Documents\MATLAB\eeg\eeglab2023.1'
gzFilePath = 'gazedata.gz'; 
gz_expand(gzFilePath);


% 心拍データ1(元データ)のパス
file_path_heart1 = 'before.csv';

% 心拍のデータ2(経過時間とRRI)の出力先　任意指定
file_path_pupil1 = 'heart_RRI1.csv'; 


% ICA後の脳波ファイルを指定
file_path_eeg = 'ebato1.set';

% chを除いた後の脳波データファイル
file_eeg1 = 'eeg_ica1.set';

% eeglabがあるファイルパス
%addpath('C:\Users\iw200\Documents\MATLAB\eeg\eeg\functions')

% 整理された脳波の時系列データの入ったsetfile
% chは除きたいチャンネルの場所(複数指定可能)
 ch1 = [5,6];
 file = eeg_ica(file_path_eeg,ch1,file_eeg1);
 EEG_file = file;
% 瞳孔データのロード (pathは得られた瞳孔データのファイルパス)

file_path_pupil2 = pupil_data_load;

% 心拍データ2のロード
file_path_heart2 = header_without(file_path_heart1,file_path_pupil1);

% 切り出した瞳孔データの出力先(任意指定)
complete_pupil_file = 'complete_pupil_file1.csv';


% 脳波データの切り出し(任意のファイル名)
 EEG_file_complete = 'finish.set';
%%%%%%%%%%%%%%%%%%%%%%%%%%

% ここからは，脳波データのサンプル数に依存

% 心拍データの切り出し
[heart_start,heart_end] = csv_heart(eegevent_start_sample,eegevent_end_sample,file_path_heart2);
% 瞳孔データの切り出し
csv_pupil_to_heart(heart_start,heart_end,file_path_pupil2,complete_pupil_file);

% 脳波のデータの切り出し
eeg_cut(eegevent_start_sample,eegevent_end_sample,EEG_file);

% 心拍の時間を脳波のサンプル数に戻す
eeg_start = heart_start * 125;
eeg_end = heart_end * 125;



eeg_cut(eeg_start,eeg_end,EEG_file,EEG_file_complete);
disp(eeg_start);
disp(eeg_end);
    



