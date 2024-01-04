function[e,e1]=mse_next(original_input,c0,maxiter0,m0,r0,factor0)

% inputは入力信号
% c is the number of surrogates.
% maxiter is the maximum number of iterations allowed.
% m: match point(s)
% r: matching tolerance
% factor: number of scale factor
% 入力例　c=1,maxiter=50,m=1,r=0.2,factor=50

x=original_input;
%メジアン保管
z=median(x); %zはIAAFTしない信号


z1=z;       %z1はIAAFTする信号
c=c0;
maxiter=maxiter0;

%%IAAFT
[s,iter]=IAAFT(z1,c,maxiter);

input=z;
input1=s;
m=m0;
r=r0;
factor=factor0;

e = msentropy_kai(input,m,r,factor);
input1=input1';
x=size(input1);

disp(x);
for j=1:c
e1(j)=msentropy_kai(input1(j),m,r,factor);

end
  
 e1=mean(e1); 

seiki=1.96;
%標準誤差
for i=1:1:factor
    meanMSE(i)=mean(e);
    meanMSE1(i)=mean(e1);
stdMSE(i)= std(e);
stdMSE1(i)= std(e1);
hyoujyungosa(i)=stdMSE(i)/sqrt(factor);
hyoujyungosa1(i)=stdMSE1(i)/sqrt(factor);
ci(i)=seiki * hyoujyungosa(i);
ci1(i)=seiki * hyoujyungosa1(i);
end



e=e';
e1=e1';
 
  
figure;

 %privious--------
%errorbar(1:i,e,ci);
%-----------------

plot((1:i)*0.01,e,"g");

set(gca,'Xscale','log');


hold on

%privious
%errorbar(1:i,e1,ci1);
%-------------------
errorbar((1:i)*0.01,e1,ci1,"r");
set(gca,'Xscale','log');
title('multiscale entropy')

xlabel('scale factor')
ylabel('sample entropy')

% 凡例に線を表示
legend('orinal signal', 'surrogate signal', 'Location', 'southeast');

grid on;
hold off


disp(e);
disp(e1);

end