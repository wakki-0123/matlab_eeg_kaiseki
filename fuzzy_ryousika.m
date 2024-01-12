function fuzzy_ryousika(thredshold,c,maxiter,m,factor,mf,rn,local,tau,file,k)

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
% tau=1;%時間遅延は一つ次にする(sampleEnと同じ),

%file = 'after_pupil_diameter.csv';
%データの読み込み
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%file = 'before_pupil_diameter.csv'; %任意のファイルのパス
%file1 = 'after_pupil_diameter.csv'
data0 = readmatrix(file);%ファイルの読み込み
data = data0(:,2); %left diameter
%data = data0(1:26177,2); %left diameter cut 1-26177
data1 = data0(:,3); %right diameter
%data1 = data0(1:26177,3);%right diameter cut 1-26177


%前処理
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = data;
%y = medfilt1(data,thredshold,'omitnan','truncate');%メジアン補間(NaNの処理)
y = fillmissing(y,'linear');%線形補間
y = filloutliers(y,'linear','movmedian',thredshold);
% ここを変えよう1
y = y(200:10000);

% 量子化のビン数
num_bins = 30;

% 量子化の範囲
quantization_range = linspace(min(y), max(y), num_bins+1);
%quantization_range1 = linspace(min(y), 4, num_bins+1);


% 時系列データの量子化
quantized_data = discretize(y, quantization_range);
%quantized_data1 = discretize(y, quantization_range1);

originalrate = 100;
newrate = 30;
newrate1 = 60;
quantized_data = resample(quantized_data,newrate,originalrate);
quantized_data_1 = resample(quantized_data,newrate1,originalrate);


% 結果の表示

% figure
% plot(quantized_data);
% title('左目　量子化されたデータ データの最小値から最大値までを30等分');

% figure 
% plot(quantized_data1);
% title('左目　量子化されたデータ 4ミリまでを30等分')
y1 = data1;
%y = medfilt1(data,thredshold,'omitnan','truncate');%メジアン補間(NaNの処理)
y1 = fillmissing(y1,'linear');%線形補間
y1 = filloutliers(y1,'linear','movmedian',thredshold);

% ここを変えよう2
y1 = y1(200:3000);



% 量子化の範囲
quantization_range2 = linspace(min(y1), max(y1), num_bins+1);
%quantization_range3 = linspace(min(y), 4, num_bins+1);


% 時系列データの量子化
quantized_data2 = discretize(y1, quantization_range2);
%quantized_data3 = discretize(y1, quantization_range3);

quantized_data2 = resample(quantized_data2,newrate,originalrate);
quantized_data2_1 = resample(quantized_data2,newrate1,originalrate);
% 結果の表示
% 
% figure
% plot(quantized_data2);
% title('右目　量子化されたデータ データの最小値から最大値までを30等分');

% figure 
% plot(quantized_data3);
% title('右目　量子化されたデータ 4ミリまでを30等分')


%y = data; %元のデータを表示したいときはコメントを外す(欠損値だらけ)
% 前処理後の時系列データのplot
% figure(1);
% plot(y)
% 
% legend('ORG','Location','southeast');
% title('Left original pupil data');
% xlabel('time scale[sec]');
% ylabel('pupil diameter');
% 
% figure(2);
% plot(y1)
% 
% legend('ORG','Location','southeast');
% title('Right original pupil data');
% xlabel('time scale[sec]');
% ylabel('pupil diameter');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IAAFTと元データのマルチスケールファジーエントロピー
%input1 = y;
%e1 = msentropy_kai(input1,m,r,factor);

%e = fuzzymsentropy(input,m,mf,rn,local,tau,factor)

%e1 = fuzzymsentropy(input1,m,mf,rn,local,tau,factor);
% e:Left 30Hz, e1: Left 60Hz , e2 Right 30Hz, e3 Right 60Hz
e = fuzzymsentropy(quantized_data,m,mf,rn,local,tau,factor);
e1 = fuzzymsentropy(quantized_data_1,m,mf,rn,local,tau,factor);
e2 = fuzzymsentropy(quantized_data2,m,mf,rn,local,tau,factor);
e3 = fuzzymsentropy(quantized_data2_1,m,mf,rn,local,tau,factor);


e = e';
e1 = e1';
e2 = e2';
e3 = e3';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% e4 - e7: IAAFT後のマルチスケールファジーエントロピー

% IAAFTと元データのマルチスケールファジーエントロピー
input = quantized_data;

[s,iter]=IAAFT(input,c,maxiter);

% サロゲートデータのマルチスケールファジーエントロピー

for i = 1:c

e4(:,i) = fuzzymsentropy(s(:,i),m,mf,rn,local,tau,factor);

end
%転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
e4 = e4';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input1 = quantized_data_1;
[s1,iter1]=IAAFT(input1,c,maxiter);
% サロゲートデータのマルチスケールファジーエントロピー

for i = 1:c

e5(:,i) = fuzzymsentropy(s1(:,i),m,mf,rn,local,tau,factor);

end
%転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
e5 = e5';
%%%%%%%%%%%%%%%%%%%%%%%%%%
input2 = quantized_data2;
[s2,iter2]=IAAFT(input2,c,maxiter);
% サロゲートデータのマルチスケールファジーエントロピー

for i = 1:c

e6(:,i) = fuzzymsentropy(s2(:,i),m,mf,rn,local,tau,factor);

end
%転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
e6 = e6';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input3 = quantized_data2_1;
[s3,iter3]=IAAFT(input3,c,maxiter);
% サロゲートデータのマルチスケールファジーエントロピー

for i = 1:c

e7(:,i) = fuzzymsentropy(s3(:,i),m,mf,rn,local,tau,factor);

end
%転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
e7 = e7';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% num_epoch4 = size(e4, 1);
% num_epoch5 = size(e5, 1);
% num_epoch6 = size(e6, 1);
% num_epoch7 = size(e7, 1);




if(k==0)
b = 'before'; 
figure
subplot(2,4,1)
plot(quantized_data);
%title('左目　量子化されたデータ データの最小値から最大値までを30等分 30Hz');
title([b,'Left quantized data sample rate 30Hz'])

subplot(2,4,2)
plot(quantized_data_1);
%title('左目　量子化されたデータ データの最小値から最大値までを30等分 60Hz');
title([b,'Left quantized data sample rate 60Hz'])

subplot(2,4,3)
plot(quantized_data2);
%title('右目　量子化されたデータ データの最小値から最大値までを30等分 30Hz');
title([b,'Right quantized data sample rate 30Hz'])


subplot(2,4,4)
plot(quantized_data2_1);
%title('右目　量子化されたデータ データの最小値から最大値までを30等分 60Hz');
title([b,'Right quantized data sample rate 60Hz'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,5)

plot(1/100:1/100:1/100*factor,e,'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e4,1),std(e4),'b');
errorbar(1/100:1/100:1/100*factor,mean(e,1),std(e,1),'r');




legend('ORG', 'IAAFT', 'Location','southeast');

set(gca, 'XScale', 'log');

hold off
title([b,'Left fuzzy entropy sample rate 30Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,6)
plot(1/100:1/100:1/100*factor,e1,'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e5),std(e5),'b');
errorbar(1/100:1/100:1/100*factor,mean(e1,1),std(e1,1),'r');


legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title([b,'Left fuzzy entropy sample rate 60Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,7)
plot(1/100:1/100:1/100*factor,e2,'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e6),std(e6),'b');
errorbar(1/100:1/100:1/100*factor,mean(e2,1),std(e2,1),'r');


legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title([b,'Right fuzzy entropy sample rate 30Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,8)
plot(1/100:1/100:1/100*factor,e3,'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e7),std(e7),'b');
errorbar(1/100:1/100:1/100*factor,mean(e3,1),std(e3,1),'r');


legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title([b,'Right fuzzy entropy sample rate 60Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');



else
a = 'after'; 
figure
subplot(2,4,1)
plot(quantized_data);
%title('左目　量子化されたデータ データの最小値から最大値までを30等分 30Hz');
title([a,'Left quantized data sample rate 30Hz'])

subplot(2,4,2)
plot(quantized_data_1);
%title('左目　量子化されたデータ データの最小値から最大値までを30等分 60Hz');
title([a,'Left quantized data sample rate 60Hz'])

subplot(2,4,3)
plot(quantized_data2);
%title('右目　量子化されたデータ データの最小値から最大値までを30等分 30Hz');
title([a,'Right quantized data sample rate 30Hz'])


subplot(2,4,4)
plot(quantized_data2_1);
%title('右目　量子化されたデータ データの最小値から最大値までを30等分 60Hz');
title([a,'Right quantized data sample rate 60Hz'])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,5)
%plot(1/100:1/100:1/100*factor,e,'r');
errorbar(1/100:1/100:1/100*factor,mean(e,1),std(e,1),'g');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e4),std(e4),'b');
legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title([a,'Left fuzzy entropy sample rate 30Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,6)
%plot(1/100:1/100:1/100*factor,e1,'r');
errorbar(1/100:1/100:1/100*factor,mean(e1,1),std(e1,1),'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e5),std(e5),'b');
legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title([a,'Left fuzzy entropy sample rate 60Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,7)
%plot(1/100:1/100:1/100*factor,e2,'r');
errorbar(1/100:1/100:1/100*factor,mean(e2,1),std(e2,1),'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e6),std(e6),'b');
legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title([a,'Right fuzzy entropy sample rate 30Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,4,8)
%plot(1/100:1/100:1/100*factor,e3,'r');
errorbar(1/100:1/100:1/100*factor,mean(e3,1),std(e3,1),'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e7),std(e7),'b');
legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title([a,'Right fuzzy entropy sample rate 60Hz']);

xlabel('time scale[sec]');
ylabel('fuzzy entropy');
end