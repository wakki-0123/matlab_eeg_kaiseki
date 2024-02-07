function [y,y1] = fuzzy_time_frequency(thredshold,file)

% 瞳孔処理専用のプログラム
% 元データの前処理とIAAFT、そしてファジーエントロピーを用いたマルチスケールファジーエントロピー解析

%前処理
%thredhold: filloutlinersにおける窓の大きさ

%IAAFT
% c: 元のデータに対して，位相をシャッフルしたデータの個数
% maxiter：データに対して，位相をシャッフルする回数


%fuzzymse(マルチスケールファジーエントロピー)
% m=2; %次元
% factor=3000;
% mf='Exponential';%指数関数(生体系はこれを使っていることが多い)
% rn=[0.2 2];%
% local=0;%global similarity
% tau=1;%時間遅延は一つ次にする(sampleEnと同じ),'


%データの読み込み
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%file = 'before_pupil_diameter.csv'; %任意のファイルのパス
%file1 = 'after_pupil_diameter.csv'
data0 = readmatrix(file);%ファイルの読み込み
%data = data0(:,2); %left diameter
data = data0(:,2); %left diameter cut
%data = data0(:,3); %right diameter
data1 = data0(:,3);%right diameter cut


%前処理
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = data;
%y = medfilt1(data,thredshold,'omitnan','truncate');%メジアン補間(NaNの処理)
y = fillmissing(y,'linear');%線形補間
y = filloutliers(y,'linear','movmedian',thredshold);


y1 = data1;
%y = medfilt1(data,thredshold,'omitnan','truncate');%メジアン補間(NaNの処理)
y1 = fillmissing(y1,'linear');%線形補間
y1 = filloutliers(y1,'linear','movmedian',thredshold);


%y = data; %元のデータを表示したいときはコメントを外す(欠損値だらけ)
% 前処理後の時系列データのplot
figure(1);
plot(y)

legend('ORG','Location','southeast');
title('Left original pupil data');
xlabel('time scale[sec]');
ylabel('pupil diameter');

figure(2);
plot(y1)

legend('ORG','Location','southeast');
title('Right original pupil data');
xlabel('time scale[sec]');
ylabel('pupil diameter');


Fs = 100; % サンプリング周波数
   
    % 時間周波数解析のパラメータ
    window = 2 * Fs; % ウィンドウサイズ（2秒）
    overlap = floor(window / 2); % オーバーラップサイズ
    nfft = 2^nextpow2(window); % FFTの点数

    % 時間周波数解析を実行
    [S, F, T] = spectrogram(y, window, overlap, nfft, Fs);

    [S1, F1, T1] = spectrogram(y1, window, overlap, nfft, Fs);



    % 結果のプロット
    figure
    imagesc(T, F, 10 * log10(abs(S)));
    axis xy;
    colormap('jet');
    colorbar;
    title("pupil_time_frequency");
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');
    ylim([0,1])


     figure
    imagesc(T1, F1, 10 * log10(abs(S1)));
    axis xy;
    colormap('jet');
    colorbar;
    title("pupil_time_frequency");
    xlabel('Time [s]');
    ylabel('Frequency [Hz]');
    ylim([0,1])
end