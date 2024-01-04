function fuzzy_power(thredshold,c,maxiter,m,factor,mf,rn,local,tau)

file1 = 'before_pupil_diameter.csv';
file2 = 'after_pupil_diameter.csv';
[ybl,ybr] = fuzzy_wakita(thredshold,c,maxiter,m,factor,mf,rn,local,tau,file1);% 施術前のデータ
[yal,yar] = fuzzy_wakita(thredshold,c,maxiter,m,factor,mf,rn,local,tau,file2);% 施術後のデータ

power_pupil_before_after(ybl,yal,0)% 左目
power_pupil_before_after(ybr,yar,1)% 右目



    
%今回やった数字
%fuzzy_power(200,10,500,2,2000,'Exponential',[0.2 2],0,1)


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
% tau=1;%時間遅延は一つ次にする(sampleEnと同じ)

%data = data0(1:26177,2); %left diameter cut
%data1 = data0(1:26177,3);%right diameter cut
