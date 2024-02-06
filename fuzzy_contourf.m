function [y,y1] = fuzzy_contourf(thredshold,c,maxiter,m,factor,mf,rn,local,tau,file)

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
l = length(data);
l1 = length(data1);
l = l/100;
l1 = l1/100;

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IAAFTと元データのマルチスケールファジーエントロピー
input1 = y;

start_index = 1;
for 
    end_index()


%e1 = msentropy_kai(input1,m,r,factor);

%e = fuzzymsentropy(input,m,mf,rn,local,tau,factor)

e1 = fuzzymsentropy(input1,m,mf,rn,local,tau,factor);
% e2 = zeros(factor,c);
% [s,iter]=IAAFT(input1,c,maxiter);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input2 = y1;
%e1 = msentropy_kai(input1,m,r,factor);

%e = fuzzymsentropy(input,m,mf,rn,local,tau,factor)

e3 = fuzzymsentropy(input2,m,mf,rn,local,tau,factor);
% e4 = zeros(factor,c);
% [s1,iter1]=IAAFT(input2,c,maxiter);

% figure;
% plot(s);
% title('IAAFT')
% xlabel('sample')
% ylabel('pipil')
% legend('surrogate signal','Location','southeast')
% disp(size(s));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% サロゲートデータのマルチスケールファジーエントロピー
%input2 = s;
% for i = 1:c
% %input2 = input2(:,i);
% %e2(:,i) = msentropy_kai(input2(:,i),m,r,factor);
% e2(:,i) = fuzzymsentropy(input2(:,i),m,mf,rn,local,tau,factor);
% 
% end
% %転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
% e2 = e2';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% サロゲートデータのマルチスケールファジーエントロピー
%input3 = s1;
% for i = 1:c
% %input2 = input2(:,i);
% %e2(:,i) = msentropy_kai(input2(:,i),m,r,factor);
% e4(:,i) = fuzzymsentropy(input3(:,i),m,mf,rn,local,tau,factor);
% 
% end
% %転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
%e4 = e4';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% グラフの表示(マルチスケールファジーエントロピー)
% figure(3)
% plot(1/100:1/100:1/100*factor,e1,'r');
% hold on
% errorbar(1/100:1/100:1/100*factor,mean(e2),std(e2),'b');
% legend('ORG','IAAFT','Location','southeast');
% set(gca, 'XScale', 'log');
% hold off
% title('left');
% 
% xlabel('time scale[sec]');
% ylabel('sample entropy');


% グラフの表示(マルチスケールファジーエントロピー)
% figure(4)
% plot(1/100:1/100:1/100*factor,e3,'r');
% hold on
% errorbar(1/100:1/100:1/100*factor,mean(e4),std(e4),'b');
% legend('ORG','IAAFT','Location','southeast');
% set(gca, 'XScale', 'log');
% hold off
% title('right');
% 
% xlabel('time scale[sec]');
% ylabel('sample entropy');



figure(5)
contourf(e1)
title('left');

ylabel('time scale');
xlabel('time[sec]');

figure(6)
contourf(e3)
title('right');

ylabel('time scale');
xlabel('time[sec]');　