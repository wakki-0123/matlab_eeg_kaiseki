function p = power_spectol(data)


sampling_frequency = 100 ;% サンプリング周波数を設定

fft_result=fft(data);
plot(fft_result);
N = length(data); % データの長さ
power_spectrum = abs(fft_result).^2/N;
p=power_spectrum;


frequency_axis = (0:N-1) * (sampling_frequency / N);

figure
plot(frequency_axis, power_spectrum);
xlabel('Frequency (Hz)');
ylabel('Power Spectrum');
title('Power Spectrum Plot');


