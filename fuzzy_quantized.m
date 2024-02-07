function fuzzy_quantized(thredshold,c,maxiter,m,factor,mf,rn,local,tau)
% k ==0 施術前のデータ、k == 1 施術後のデータ
% ここでは、サンプル数200から1200の区間を取り出している。ただし、サンプリングレートは100Hz すなわち10秒間のデータ
file = 'before_pupil_diameter.csv';
%file1 = 'after_pupil_diameter.csv';

fuzzy_ryousika(thredshold,c,maxiter,m,factor,mf,rn,local,tau,file,0);
%fuzzy_ryousika(thredshold,c,maxiter,m,factor,mf,rn,local,tau,file1,1);