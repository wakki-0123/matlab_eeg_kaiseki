function [y,y1] = fuzzy_wakita(thredshold,c,maxiter,m,factor,mf,rn,local,tau,file)

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IAAFTと元データのマルチスケールファジーエントロピー
input1 = y;
%e1 = msentropy_kai(input1,m,r,factor);

%e = fuzzymsentropy(input,m,mf,rn,local,tau,factor)

e1 = fuzzymsentropy(input1,m,mf,rn,local,tau,factor);
e2 = zeros(factor,c);
[s,iter]=IAAFT(input1,c,maxiter);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input2 = y1;
%e1 = msentropy_kai(input1,m,r,factor);

%e = fuzzymsentropy(input,m,mf,rn,local,tau,factor)

e3 = fuzzymsentropy(input2,m,mf,rn,local,tau,factor);
e4 = zeros(factor,c);
[s1,iter1]=IAAFT(input2,c,maxiter);

% figure;
% plot(s);
% title('IAAFT')
% xlabel('sample')
% ylabel('pipil')
% legend('surrogate signal','Location','southeast')
% disp(size(s));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% サロゲートデータのマルチスケールファジーエントロピー
input2 = s;
for i = 1:c
%input2 = input2(:,i);
%e2(:,i) = msentropy_kai(input2(:,i),m,r,factor);
e2(:,i) = fuzzymsentropy(input2(:,i),m,mf,rn,local,tau,factor);

end
%転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
e2 = e2';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% サロゲートデータのマルチスケールファジーエントロピー
input3 = s1;
for i = 1:c
%input2 = input2(:,i);
%e2(:,i) = msentropy_kai(input2(:,i),m,r,factor);
e4(:,i) = fuzzymsentropy(input3(:,i),m,mf,rn,local,tau,factor);

end
%転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
e4 = e4';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% グラフの表示(マルチスケールファジーエントロピー)
figure(3)
plot(1/100:1/100:1/100*factor,e1,'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e2),std(e2),'b');
legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title('left');

xlabel('time scale[sec]');
ylabel('sample entropy');


% グラフの表示(マルチスケールファジーエントロピー)
figure(4)
plot(1/100:1/100:1/100*factor,e3,'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e4),std(e4),'b');
legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title('right');

xlabel('time scale[sec]');
ylabel('sample entropy');

% savedir = 'C:\Users\iw200\Documents\MATLAB\eeg\eeg_kaiseki';
% for i=1:4
%     fig_handle = figure(i);
%     saveas(fig_handle,fullfile(savedir,['figure_' num2str(i) '.png']));
% end


%パワー解析も入れてみた
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%パワースペクトル解析とスムージングに関してのプログラム

% s_day = importdata("day.txt");
% s_name = importdata("subject_name.txt");
% s_epoch = importdata("epoch.txt");
% Fs = 100; %サンプリング周波数
% number = 1;
% epoch = 1;
%ch = ["F3" "F4" "C3" "C4" "P3" "P4" "Po3" "Po4"];
% p = zeros(1,29);
% ave_psdx = zeros(epoch,29);
% ave_f = zeros(epoch,29);
% psdx_matrix = zeros(number,number,epoch,29);
% freq_matrix = zeros(number,number,epoch,29);
%
% freq = zeros(1,29);


%for i = 2:1:9

 



% 最初の信号
    
    % eye_left_diameter = y; % 前処理後の瞳孔の左の時系列データ

    
    


    %Nx = length(eye_left_diameter); %データの行数

    % Ch_data = eye_left_diameter(:,1); 
    % Ch_data = zscore(Ch_data); 
    % nsc = floor(Nx);
    % nov = floor(nsc/2);
    % nff = max(256,2^nextpow2(nsc));
    % [psdx,f] = pwelch(Ch_data,[],[],[0.0001:0.0001:0.04],Fs);
    % psdx = smoothdata(psdx);%smoothing

    %もう一つの信号
    %eye_right_diameter = y1;% 前処理後の瞳孔の右の時系列データ
    
    %Nx1 = length(eye_right_diameter); %データの行数
    % Ch_data1 = eye_right_diameter(:,1);
    % Ch_data1 = zscore(Ch_data1);
    % nsc1 = floor(Nx1);
    % nov1 = floor(nsc1/2);
    % nff1 = max(256,2^nextpow2(nsc1));
    % [psdx1,f1] = pwelch(Ch_data1,[],[],[0.0001:0.0001:0.04],Fs);
    % psdx1 = smoothdata(psdx1);%smoothing
    % 
    % freq1 = f1;
    % p1 = psdx1;
    % freq = f;
    % p = psdx;


% plot start

   
%     figure
%     plot(freq,10*log10(p),'r')
%     hold on
%     plot(freq1,10*log10(p1),'g')
% 
% 
%     legend({'eye_left','eye_right'},'Location','southwestoutside')
% 
%     title('left right powerspectol')
%     xlabel('Frequency[Hz]')
%     ylabel('Power[dB]')
% 
% 
% end




