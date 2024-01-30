function time_frequency_EEG

% 脳波データに対して、時間周波数解析を行うプログラム

Fs = 125; % サンプリング周波数
ch = ["F3" "F4" "C3" "C4" "P3" "P4" "Po3" "Po4"];

for i = 1:8 % 8つの電極に対して繰り返し

    % 読み込みたい脳波データ
    file_name = "ebato_0120_full_data_0122.txt";
    EEG_data = readmatrix(file_name); % ファイルのデータ読み込み
    
    % 電極ごとのデータを抽出
    Ch_data = EEG_data(:, i);
    Ch_data = zscore(Ch_data);
    
    % バンドパスフィルタの設定
    low_cutoff_frequency = 0.001; % バンドパスフィルタの下側カットオフ周波数（例: 10 Hz）
    high_cutoff_frequency = 30; % バンドパスフィルタの上側カットオフ周波数（例: 30 Hz）
    order = 4; % フィルタの次数

    % バンドパスフィルタを作成
    d = designfilt('bandpassfir', 'FilterOrder', order, 'CutoffFrequency1', low_cutoff_frequency, 'CutoffFrequency2', high_cutoff_frequency, 'SampleRate', Fs);
    
    % バンドパスフィルタをかける
    Ch_data_filtered = filter(d, Ch_data);

    % 時間周波数解析のパラメータ
    window = 2 * Fs; % ウィンドウサイズ（2秒）
    overlap = floor(window / 2); % オーバーラップサイズ
    nfft = 2^nextpow2(window); % FFTの点数

    % 時間周波数解析を実行
    [S, F, T] = spectrogram(Ch_data_filtered, window, overlap, nfft, Fs);

    % 結果のプロット
    subplot(4, 2, i);
    imagesc(T, F, 10 * log10(abs(S)));
    axis xy;
    colormap('jet');
    colorbar;
    title(char(ch(i)));
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function time_frequency_EEG
% 
% % 脳波データに対して、時間周波数解析を行うプログラム
% 
% Fs = 125; % サンプリング周波数
% ch = ["F3" "F4" "C3" "C4" "P3" "P4" "Po3" "Po4"];
% 
% for i = 1:8 % 8つの電極に対して繰り返し
% 
%     % 読み込みたい脳波データ
%     file_name = "ebato_0120_full_data_0122.txt";
%     EEG_data = readmatrix(file_name); % ファイルのデータ読み込み
% 
%     % 電極ごとのデータを抽出
%     Ch_data = EEG_data(:, i);
%     Ch_data = zscore(Ch_data);
% 
%     % ローパスフィルタの設定
%     cutoff_frequency = 45; % ローパスフィルタのカットオフ周波数（例: 45 Hz）
%     order = 4; % フィルタの次数
% 
%     % バターワースローパスフィルタを作成
%     d = designfilt('lowpassfir', 'FilterOrder', order, 'CutoffFrequency', cutoff_frequency, 'SampleRate', Fs);
% 
%     % ローパスフィルタをかける
%     Ch_data_filtered = filter(d, Ch_data);
% 
%     % 時間周波数解析のパラメータ
%     window = 2 * Fs; % ウィンドウサイズ（2秒）
%     overlap = floor(window / 2); % オーバーラップサイズ
%     nfft = 2^nextpow2(window); % FFTの点数
% 
%     % 時間周波数解析を実行
%     [S, F, T] = spectrogram(Ch_data_filtered, window, overlap, nfft, Fs);
% 
%     % 結果のプロット
%     subplot(4, 2, i);
%     imagesc(T, F, 10 * log10(abs(S)));
%     axis xy;
%     colormap('jet');
%     colorbar;
%     title(char(ch(i)));
%     xlabel('Time [s]');
%     ylabel('Frequency [Hz]');
% 
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function time_frequency_EEG
% 
% % 脳波データに対して、時間周波数解析を行うプログラム
% 
% Fs = 125; % サンプリング周波数
% ch = ["F3" "F4" "C3" "C4" "P3" "P4" "Po3" "Po4"];
% 
% for i = 1:8 % 8つの電極に対して繰り返し
% 
%     % 読み込みたい脳波データ
%     file_name = "ebato_0120_full_data_0122.txt";
%     EEG_data = readmatrix(file_name); % ファイルのデータ読み込み
% 
%     % 電極ごとのデータを抽出
%     Ch_data = EEG_data(:, i);
%     Ch_data = zscore(Ch_data);
% 
%     % 時間周波数解析のパラメータ
%     window = 2 * Fs; % ウィンドウサイズ（2秒）
%     overlap = floor(window / 2); % オーバーラップサイズ
%     nfft = 2^nextpow2(window); % FFTの点数
% 
%     % 時間周波数解析を実行
%     [S, F, T] = spectrogram(Ch_data, window, overlap, nfft, Fs);
% 
%     % 結果のプロット
%     subplot(4, 2, i);
%     imagesc(T, F, 10 * log10(abs(S)));
%     axis xy;
%     colormap('jet');
%     colorbar;
%     title(char(ch(i)));
%     xlabel('Time [s]');
%     ylabel('Frequency [Hz]');
% 
% end
