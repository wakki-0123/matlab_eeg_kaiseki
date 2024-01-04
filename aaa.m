function z = aaa(B)

%メジアン保管
 x=B;
 figure;

 p=medfilt1(x,220);
 z=p;
 plot(z);
 title('median completion')
xlabel('sample')
ylabel('pipil')
legend('orinal signal','Location','southeast')
