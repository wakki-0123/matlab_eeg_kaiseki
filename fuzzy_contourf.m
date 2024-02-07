function [y, y1] = fuzzy_contourf(threshold, c, maxiter, m, factor, mf, rn, local, tau)

% ...（関数ヘッダーや他のコード）
%データの読み込み
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath 'C:\Users\iw200\Documents\MATLAB\eeg\eeglab2023.1' % 読み込みファイルの場所
file = 'complete_pupil_ebato0128.csv'; %任意のファイルのパス
%file1 = 'after_pupil_diameter.csv'
data0 = readmatrix(file);%ファイルの読み込み

data = data0(:,2); %left diameter

data1 = data0(:,3);%right diameter

% データの前処理
y = data;
y = fillmissing(y, 'linear');
y = filloutliers(y, 'linear', 'movmedian', threshold);

ly = length(y);
y1 = data1;
y1 = fillmissing(y1, 'linear');
y1 = filloutliers(y1, 'linear', 'movmedian', threshold);
ly1 = length(y1);

fs = 100;

% 切り取られたセグメントを格納するためのセル配列を作成
y_cut = cell(1, round(ly/fs));
y_cut1 = cell(1, round(ly1/fs));

for i = 1:round(ly/fs):ly
    index(i) = i;
    y_cut{i} = y(1:index(i));
end

% ...（y1およびy_cut1に対する同様の前処理）
for i = 1:round(ly1/fs):ly1
    index1(i) = i;
    y_cut1{i} = y(1:index1(i));
end

% IAAFTおよびマルチスケールファジーエントロピー
for i = 1:round(ly/fs):ly
    e2(:,i) = fuzzymsentropy(y_cut{i}, m, mf, rn, local, tau, factor);
end

% ...（e4に対する同様のループ）

for i = 1:round(ly1/fs):ly1
    e4(:,i) = fuzzymsentropy(y_cut1{i}, m, mf, rn, local, tau, factor);
end

% コンタープロット
figure
contourf(1:ly,1:c,e2);

figure
contourf(1:ly1,1:c,e4);


end
