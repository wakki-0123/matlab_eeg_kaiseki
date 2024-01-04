% Function for calculating multiscale entropy
% input: signal
% m: match point(s)
% r: matching tolerance% factor: number of scale factor
% sampenc is available at http://people.ece.cornell.edu/land/PROJECTS/Complexity/sampenc.m

function [e,e1] = msentropy1(input,input1,m,r,factor)

y=input;
y1=input1;
y=y-mean(y);
y=y/std(y);
y1=y1-mean(y1);
y1=y1/std(y1);

for i=1:1:factor
   s(i)=coarsegraining(y,i);
   s1(i)=coarsegraining(y1,i);

   %s=imresize(y,i);
   sampe=sampenc(s(i),m+1,r);
   sampe1=sampenc(s1(i),m+1,r);


   e(i)=sampe(m+1);   
   e1(i)=sampe1(m+1);
end
  %e=e';
  %e1=e1';
  
e=e';
e1=e1';
disp(e);
disp(e1);
figure
plot(1:i,e,'r') 
hold on
plot(1:i,e1,'b')
hold off


end



