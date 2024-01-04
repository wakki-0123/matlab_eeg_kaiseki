% Function for calculating multiscale entropy
% input: signal
% m: match point(s)
% r: matching tolerance
% factor: number of scale factor
% sampenc is available at http://people.ece.cornell.edu/land/PROJECTS/Complexity/sampenc.m

function [e,e1] = msentropy(input,input1,m,r,factor)
 y=input; %original
 y1=input1; %surrogate
 y=y-mean(y);
 y=y/std(y);
 y1=y1-mean(y1);
 y1=y1/std(y1);



%---------元--------------
 for i=1:1:factor
   s=coarsegraining(y,i);
   s1=coarsegraining(y1,i);
    sampe=sampenc(s,m+1,r);
   sampe1=sampenc(s1,m+1,r);
    e(i)=sampe(m+1);   
   e1(i)=sampe1(m+1);
   
 end
 %信頼度95%
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




