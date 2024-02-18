function [y,y1] = fuzzy_window_slide(thredshold,m,factor,mf,rn,local,tau)

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


Fs = 100;
epoch_length = 1000;
%データの読み込み
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath 'C:\Users\iw200\Documents\MATLAB\eeg\eeglab2023.1' % 読み込みファイルの場所
file = 'complete_pupil_ebato0128.csv'; %任意のファイルのパス
%file1 = 'after_pupil_diameter.csv'
data0 = readmatrix(file);%ファイルの読み込み

data = data0(:,2); %left diameter

data1 = data0(:,3);%right diameter


%前処理
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = data;
%y = medfilt1(data,thredshold,'omitnan','truncate');%メジアン補間(NaNの処理)
y = fillmissing(y,'linear');%線形補間
y = filloutliers(y,'linear','movmedian',thredshold);

ly = length(y);


y1 = data1;
%y = medfilt1(data,thredshold,'omitnan','truncate');%メジアン補間(NaNの処理)
y1 = fillmissing(y1,'linear');%線形補間
y1 = filloutliers(y1,'linear','movmedian',thredshold);

ly1 = length(y1);


file1 = 'time_log0128.csv';
data000 = readmatrix(file1);
l = length(data000);
%y = data; %元のデータを表示したいときはコメントを外す(欠損値だらけ)
% 前処理後の時系列データのplot

x_axis_samples = (1:length(y)) / Fs; % FsHzのサンプリングレートを前提としています
x_axis_samples1 = (1:length(y1)) / Fs; % FsHzのサンプリングレートを前提としています

figure;
plot(x_axis_samples,y)
hold on
for k = 2:2:l-1
    % 縦線の描画（赤）
    %xValue = data000(k) * 100; % 縦線を描画するxの値
    xValue = data000(k);

    xline(xValue, 'r', 'LineWidth', 1); % xValueの位置に縦線を描画
    % 縦線の描画（緑）
    %xValue1 = data000(k + 1) * 100; % 縦線を描画するxの値
    xValue1 = data000(k+1);
    xline(xValue1, 'g', 'LineWidth', 1);
end


legend('ORG','gray start','fear start','Location','southeast');
title('Left original pupil data');
xlabel('time scale[s]');
ylabel('pupil diameter');

figure;
plot(x_axis_samples1,y1)
hold on
for k = 2:2:l-1
    % 縦線の描画（赤）
    xValue3 = data000(k); % 縦線を描画するxの値
    xline(xValue3, 'r', 'LineWidth', 1); % xValueの位置に縦線を描画
    % 縦線の描画（緑）
    xValue4 = data000(k + 1); % 縦線を描画するxの値
    xline(xValue4, 'g', 'LineWidth', 1);
end

legend('ORG','gray start','fear start','Location','southeast');
title('Right original pupil data');
xlabel('time scale[s]');
ylabel('pupil diameter');



d = 1;
% for 内のepoch_lengthを変えることで窓の大きさを変えられる(ここでは100 プログラムの上で定義している)
y_left = cell(1, ceil(ly/epoch_length));
for i = 1:100:ly-epoch_length
    y_left{d} = y(i:i+epoch_length-1);
    d = d + 1;
end

t = 1;
y_right = cell(1, ceil(ly1/epoch_length));
for j = 1:100:ly1-epoch_length
    y_right{t} = y1(j:j+epoch_length-1);
    t = t + 1;
end

e_left = cell(1, length(y_left));
e_right = cell(1, length(y_right));
disp(length(e_right))

for s = 1:(length(y_left)-1)
    % fuzzy entropy(Left)
    e_left{s} = fuzzymsentropy(y_left{s}, m, mf, rn, local, tau, factor);
end

for s = 1:(length(y_right)-1)
    % fuzzy entropy(right)
    e_right{s} = fuzzymsentropy(y_right{s}, m, mf, rn, local, tau, factor);
end


e_left_combined = cell2mat(e_left);
e_right_combined = cell2mat(e_right);


% e_left_combined と e_right_combined は 1x10 の行列になります
% これらを展開したい場合、reshape を使用して適切なサイズに変形します

% 適切なサイズに変形するために、e_left と e_right のサイズを取得します
num_elements = numel(e_left{1}); % 1つの要素のサイズを取得

% サイズを取得したら、reshape を使用して適切なサイズに変形します
e_left_numeric_combined = reshape(e_left_combined, num_elements, []);
e_right_numeric_combined = reshape(e_right_combined, num_elements, []);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure
contourf(e_left_numeric_combined, 100)


legend('fuzzy entropy','Location','southeast');
title('left pupil fuzzy entropy');
xlabel('time [s]');
ylabel('time scale')
xlim([200 400])
colorbar;



% Plot the contourf with the scaled x-axis
figure
contourf(e_right_numeric_combined, 100)


legend('fuzzy entropy','Location','southeast');
title('Right pupil fuzzy entropy');
xlabel('time [s]');
ylabel('time scale')
xlim([200 400])
colorbar;

