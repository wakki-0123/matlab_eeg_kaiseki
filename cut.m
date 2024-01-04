function z = cut(data)
data(120001:123350,:) = [];
z=data;
figure 
plot(z)
end