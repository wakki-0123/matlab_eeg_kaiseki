function RRI_to_heartrate
Fs = 1000;
file = 'heart_RRI_complete_0120_30-224s.csv';
data = readmatrix(file);
originaltime = data(:, 1);
originalRRI = data(:, 2);
newSamplingRate = 2; % リサンプリング後のサンプリングレート

% 1. 異常値の検出と修正（例えば、3標準偏差以上の値を外れ値と見なす）
mean_RRI = mean(originalRRI);
std_RRI = std(originalRRI);
outliers = abs(originalRRI - mean_RRI) > 3 * std_RRI;
cleanedRRI = originalRRI(~outliers);
cleanedtime = originaltime(~outliers);

% 時間の修正
total_sec = (cleanedtime - cleanedtime(1)) * 60;

% 新しい時間軸の生成
new_times = min(total_sec):1/newSamplingRate:max(total_sec);
newTime_1 = transpose(new_times);

% RRIデータをリサンプリング
resampledRRI = interp1(total_sec, cleanedRRI, newTime_1, 'linear', 'extrap');

% 心拍数
heart_rate = (60./resampledRRI)*Fs;

% リサンプリング後のデータを新しいテーブルに保存
resampledTable = table(newTime_1, resampledRRI, heart_rate, 'VariableNames', {'Time', 'RRI','HR'});

% 新しいCSVファイルに保存
writetable(resampledTable, 'resampled_data.csv', 'Delimiter', ',');

% 結果の表示
fprintf('平均値: %.4f\n', mean_RRI);
fprintf('標準偏差: %.4f\n', std_RRI);

% グラフの描画
figure;
subplot(2,1,1);
plot(originaltime, originalRRI,'r', 'DisplayName', 'Original RRI');
xlabel('Time (s)');
ylabel('R-R Interval');
title('Original RRI');
legend;

subplot(2,1,2);
plot(newTime_1, resampledRRI, 'b', 'DisplayName', 'Resampled RRI');
xlabel('Time (s)');
ylabel('R-R Interval');
title('Resampled RRI');
legend;

% 心拍数のグラフの描画
figure;
plot(newTime_1, heart_rate, 'g', 'DisplayName', 'Heart Rate (BPM)');
xlabel('Time (s)');
ylabel('Heart Rate (BPM)');
title('Heart Rate');
legend;

% グリッドを表示
grid on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% heart_rateのパワー解析
    Nx = length(heart_rate); %データの行数
    %Ch_data = heart_rate(:,i); %電極ごとのデータを抽出
    Ch_data = zscore(heart_rate); 
    nsc = floor(Nx);
    nov = floor(nsc/2);
    nff = max(256,2^nextpow2(nsc));
    [psdx,f] = pwelch(Ch_data,hamming(nsc),nov,[0.004:0.001:0.5],Fs);
    freq = f;
    p = psdx;


    figure

    plot(freq,10*log10(p),'r')

     title('heartrate power')
    xlabel('Frequency[Hz]')
    ylabel('Power[dB]')

