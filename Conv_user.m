function y = Conv_user(x,h)
l1 = length(x);
l2 = length(h);
l3 = l1+l2-1;
x1 = [x, zeros(1,l2)];
h1 = [h, zeros(1,l1)];
y = [zeros(1,l3)];
for n = 1:l3 
    sum = 0;
    for k = 1:n
        sum = sum + x1(k)*h1(n - k + 1);
    end
    y(n) = sum;
end
end