clc;
clear all; close all;
x1 = [1,4,3,6];
x2 = [9,8,7,7];
a = input('Enter a:');
b = input ('Enter b:'); 
y1 = exp (a*x1);
y2 = exp (b*x2); 
y11 = y1 + y2;
y12 = exp (a*x1 + b*x2); 
subplot(2,3,1); 
stem(x1);
ylabel("Value of X1"); 
title("Input 1"); 
grid(); 
subplot(2,3,2); 
stem(x2); 
ylabel("Value of X2"); 
title("Input 2"); 
grid(); 
subplot(2,3,3); 
stem(y11); 
xlabel("Input")
ylabel("Value of y11"); 
title("Y11");
grid(); 
subplot(2,3,4); 
stem(y12); 
xlabel("Input")
ylabel("Value of y12"); 
title("Y12");
grid();
y13 = y11 - y12;
subplot(2,3,5); 
stem(y13); 
xlabel("Input");
ylabel("Y13");
title("Y13");
if (abs(y11-y12)<= 0.0001)
    then

    disp("System is linear"); else
    display("System is non-linear"); end;
