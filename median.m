function z = median(data)

x = length(data);
% 0をNaNに変換
condition = (data==0);
data(condition) = NaN;
% 近傍の非欠損値の線形内挿 (数値、duration、datetime のデータ型のみ)
p=medfilt1(data,500); %本来は500
y = fillmissing(p,'linear','SamplePoints',1:x);

z=y;

figure
plot(z);
title('median completion')
xlabel('sample')
ylabel('pipil')
legend('orinal signal','Location','southeast')

end