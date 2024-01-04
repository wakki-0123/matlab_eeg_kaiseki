
function suurogate_linear(thredshold,c,maxiter,m,r,factor)

% c: 元のデータに対して，位相をシャッフルしたデータの個数
% maxiter：データに対して，位相をシャッフルする回数
% m: match point(s)
% r: matching tolerance
% factor: number of scale factor


%fuzzymse
% m=2; %次元
% factor=3000;
% mf='Exponential';%指数関数(生体系はこれを使っていることが多い)
% rn=[0.2 2];%
% local=0;%global similarity
% tau=1;%時間遅延は一つ次にする(sampleEnと同じ)
%addpath('C:\Users\iw200\OneDrive\ドキュメント\MATLAB\Examples\R2023b\matlab\pupil_data_analyze');

%データの読み込み
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file = 'before_pupil_data.csv'; %任意のファイルのパス
data0 = readmatrix(file);%ファイルの読み込み
data = data0(:,2); %left diameter どっちを取るかによって，コメント化すること！
%data = data0(:,3); %right diameter


%前処理
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%一時的にｙをコメント化している
y = medfilt1(data,thredshold,'omitnan');%メジアン補間


y = fillmissing(y,'linear');%線形補間，NaNの処理
%y = data;


figure;
plot(y)

legend('ORG','Location','southeast');
title('original pupil data');
xlabel('time scale[sec]');
ylabel('pupil diameter');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IAAFT
input1 = y;
e1 = msentropy_kai(input1,m,r,factor);
e2 = zeros(factor,c);
[s,iter]=IAAFT(input1,c,maxiter);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MSE
input2 = s;
for i = 1:c
%input2 = input2(:,i);
e2(:,i) = msentropy_kai(input2(:,i),m,r,factor);
end
%転置行列(1000,10)→(10,1000) (factor,c)→(c,factor)
e2 = e2';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% グラフの表示(MSE)
figure
plot(1/100:1/100:1/100*factor,e1,'r');
hold on
errorbar(1/100:1/100:1/100*factor,mean(e2),std(e2),'b');
legend('ORG','IAAFT','Location','southeast');
set(gca, 'XScale', 'log');
hold off
title('left');
%title('right');
xlabel('time scale[sec]');
ylabel('sample entropy');



end




