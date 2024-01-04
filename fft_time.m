function [psd,frequency] = fft_time(data)

sampling_frequency = 100 ;% サンプリング周波数を設定
N = length(data); % データの長さ

[psd,frequency] = pwelch(data,N,sampling_frequency);
figure
plot(psd);
xlabel('Frequency (Hz)');
ylabel('Power Spectrum');
title('Power Spectrum Plot');

figure
plot(frequency);
