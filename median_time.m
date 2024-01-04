function z = median_time(B)

%メジアン保管
 x=B;
 figure;
N=length(x);
N1=0.01*N;
 p=medfilt1(x,220);
 z=p;
 plot(z,N1);
 title('median completion')
xlabel('sample')
ylabel('pipil')
legend('orinal signal','Location','southeast')