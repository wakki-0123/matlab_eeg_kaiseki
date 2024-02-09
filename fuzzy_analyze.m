function [y,y1] = fuzzy_analyze(thredshold,m,factor,mf,rn,local,tau)

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

% sampling rate
Fs = 100;
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% d = 1;
% 
% for i=1:Fs:ly
% 
%     y_left(d) = y(i:i+100);
% 
%     y_left_cut_length = d;
%     d = d + 1;
% end
% t = 1;
% for j=1:fs:ly1
% 
%     y_right(t) = y1(j:j+100);
% 
%     y_right_cut_length = t;
%     t = t + 1;
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% d = 1;
% y_left = cell(1, ceil(ly/Fs));
% for i = 1:Fs:ly
%     y_left{d} = y(i:i+100);
%     d = d + 1;
% end
% 
% t = 1;
% y_right = cell(1, ceil(ly1/Fs));
% for j = 1:Fs:ly1
%     y_right{t} = y1(j:j+100);
%     t = t + 1;
% end
d = 1;
% for 内のFsの値を変えることで窓の大きさを変えられる(ここでは100 プログラムの上で定義している)
y_left = cell(1, ceil(ly/Fs));
for i = 1:Fs:ly-Fs
    y_left{d} = y(i:i+Fs-1);
    d = d + 1;
end

t = 1;
y_right = cell(1, ceil(ly1/Fs));
for j = 1:Fs:ly1-Fs
    y_right{t} = y1(j:j+Fs-1);
    t = t + 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for s=1:y_left_cut_length
% % fuzzy entropy(Left)
% e_left(s) = fuzzymsentropy(y_left(s),m,mf,rn,local,tau,factor);
% end
% 
% for s=1:y_right_cut_length
% % fuzzy entropy(right)
% e_right(s) = fuzzymsentropy(y_right(s),m,mf,rn,local,tau,factor);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
e_left = cell(1, length(y_left));
e_right = cell(1, length(y_right));

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%
% あってるやつ
figure
contourf(e_left_numeric_combined,100)

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
legend('fuzzy entropy','gray start','fear start','Location','southeast');
title('Left pupil fuzzy entropy');
xlabel('time');
ylabel('time scale');
xlim([256 259])
ylim([15 25])
colorbar;


figure
contourf(e_right_numeric_combined,100)
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
legend('fuzzy entropy','gray start','fear start','Location','southeast');
title('right pupil fuzzy entropy');
xlabel('time [s]');
ylabel('time scale')
xlim([256 259])
ylim([15 25])
colorbar;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% これで、e_left と e_right の各要素が個別の数値配列として取り出されます
% e_left_numeric_combined と e_right_numeric_combined は数値配列になります
%%%%%%%%%%%%%%%%%%%%%%%%
% e_left_numeric_combined を contourf でプロット

% % % X軸の時間の配列を作成
% time_y = (0:(ly-1)) / Fs; % yのデータポイントの時間配列
% time_y1 = (0:(ly1-1)) / Fs; % y1のデータポイントの時間配列
% 
% % e_left_numeric_combined を contourf でプロット
% figure;
% contourf(time_y, 1:size(e_left_numeric_combined, 1), e_left_numeric_combined);
% title('Combined Left Pupil Data');
% xlabel('Time [s]');
% ylabel('Time Scale');
% 
% % e_right_numeric_combined を contourf でプロット
% figure;
% contourf(time_y1, 1:size(e_right_numeric_combined, 1), e_right_numeric_combined);
% title('Combined Right Pupil Data');
% xlabel('Time [s]');
% ylabel('Time Scale');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% timex1 = 1:(ly/Fs);
% timex2 = 1:(ly1/Fs);
% 
% figure;
% contourf(timex1,e_left_numeric_combined);
% title('Combined Left Pupil Data');
% xlabel('Time');
% ylabel('Time Scale');
% 
% % e_right_numeric_combined を contourf でプロット
% figure;
% contourf(timex2,e_right_numeric_combined);
% title('Combined Right Pupil Data');
% xlabel('Time');
% ylabel('Time Scale');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Convert cell array elements to numerical array

% 
% 
% % Plot
% figure
% for s = 1:length(e_left_numeric)
%     subplot(1, length(e_left_numeric), s)
%     contourf(e_left_numeric{s})
%     title(['Left pupil data, scale ', num2str(s)])
%     xlabel('time')
%     ylabel('time scale')
% end
% 
% figure
% for s = 1:length(e_right_numeric)
%     subplot(1, length(e_right_numeric), s)
%     contourf(e_right_numeric{s})
%     title(['Right pupil data, scale ', num2str(s)])
%     xlabel('time')
%     ylabel('time scale')
% end

% max_length = max(cellfun(@numel, e_left));  % 左側のセル配列の要素の最大サイズを取得
% e_left_numeric = cellfun(@(x) padarray(x, [0, max_length - numel(x)], NaN, 'post'), e_left, 'UniformOutput', false);
% 
% max_length = max(cellfun(@numel, e_right));  % 右側のセル配列の要素の最大サイズを取得
% e_right_numeric = cellfun(@(x) padarray(x, [0, max_length - numel(x)], NaN, 'post'), e_right, 'UniformOutput', false);
% % Convert cell array elements to numerical array and remove NaN values
% e_left_numeric = cellfun(@(x) x(~isnan(x)), e_left_numeric, 'UniformOutput', false);
% e_right_numeric = cellfun(@(x) x(~isnan(x)), e_right_numeric, 'UniformOutput', false);

%size(e_left_numeric)
% Plot
% figure
% for s = 1:length(e_left_numeric)
%     subplot(1, length(e_left_numeric), s)
%     contourf(e_left_numeric{s})
%     title(['Left pupil data, scale ', num2str(s)])
%     xlabel('time')
%     ylabel('time scale')
% end
% 
% figure
% for s = 1:length(e_right_numeric)
%     subplot(1, length(e_right_numeric), s)
%     contourf(e_right_numeric{s})
%     title(['Right pupil data, scale ', num2str(s)])
%     xlabel('time')
%     ylabel('time scale')
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure
% contourf(e_left)
% title('Left pupil data');
% xlabel('time');
% ylabel('time scale');
% 
% figure
% contourf(e_right)
% title('right pupil data');
% xlabel('time');
% ylabel('time scale')

