function [p,p1]=plot111(e,e1,factor)
i=factor;
p=e;
p1=e1;
plot(1:i,p);
hold on
plot(1:i,p1);
hold off
disp(p);
disp(p1);