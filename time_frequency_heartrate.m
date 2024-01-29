function time_frequency_heartrate(heart_rate)

% 心拍数データに対して、時間周波数解析を行うプログラム

Fs = 1000; % サンプリング周波数
   
    % 時間周波数解析のパラメータ
    window = 2 * Fs; % ウィンドウサイズ（2秒）
    overlap = floor(window / 2); % オーバーラップサイズ
    nfft = 2^nextpow2(window); % FFTの点数

    % 時間周波数解析を実行
    [S, F, T] = spectrogram(heart_rate, window, overlap, nfft, Fs);

    % 結果のプロット
    figure
    imagesc(T, F, 10 * log10(abs(S)));
    axis xy;
    colormap('jet');
    colorbar;
    title("heart_rate_time_frequency");
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');
    ylim([0,0.3])

end