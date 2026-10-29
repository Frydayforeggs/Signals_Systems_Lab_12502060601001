clc;
clear all; close all;
x1 = [4, 6, 3, 2, zeros(1,10)];
k = input ("Enter delay:"); x11 = [zeros(1,k), x1];
y11 = exp(x11); % y(n,k); 
y12o = exp (x1);
y12 = [ zeros(1,k), y12o];
subplot(2,2,1); 
stem(x1); 
ylabel("x1");
title("Padded 0 input"); 
subplot(2,2,2); 
stem(x11); 
ylabel("x11"); 
title("delayed input"); 
subplot(2,2,3); 
stem(y11);
xlabel("x11")
ylabel("y11");
title("delayed input and then output"); 
subplot(2,2,4);
stem(y12); 
xlabel("x11")
ylabel("y12"); 
title("delayed output");
tolerance=0.0001;
if(abs(y11-y12)<=tolerance)
then
disp('the system is time invariant');
else
disp('the system is time variant');
end