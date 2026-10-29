clc;
clear all;
close all;
t = 0:0.01:12.56;

W = -2*pi : 0.01 : 2*pi;
p = input("Enter the value of p: ");
a = input("Enter the value of a: ");
T = input("Enter the value of T: ");
X_t = p.^t;
X_t2 = exp(a.*t);
X_t3 = 1*(abs(t)<=T/2);
figure
plot (t,X_t);
xlabel("Magnitude");
ylabel("time");
title("exponential (a)");
figure
plot (t,X_t2);
xlabel("Magnitude");
ylabel("time");
title("exponential (e)");
figure
plot (t,X_t3);
xlabel("Magnitude");
ylabel("time");
title("Rectangular pulse");
X_W = zeros(size(W));
X_W2 = zeros(size(W));
X_W3 = zeros(size(W));
for k = 1: length(W)
    X_W(k) = trapz(t,X_t.*exp(-1i*W(k).*t));
end
for k = 1: length(W)
    X_W2(k) = trapz(t,X_t2.*exp(-1i*W(k).*t));
end
for k = 1: length(W)
    X_W3(k) = trapz(t,X_t3.*exp(-1i*W(k).*t));
end
figure
subplot(1,2,1);
plot (t,abs(X_W));
title("FT of exponential(a) Magnitude");
subplot(1,2,2);
plot (t, angle(X_W));
title("FT of exponential(a) Phase");
figure
subplot(1,2,1);
plot (t,abs(X_W2));
title("FT of exponential(e) Magnitude");
subplot(1,2,2);
plot (t, angle(X_W2));
title("FT of exponential(e) Phase");
figure
subplot(1,2,1);
plot (t,abs(X_W3));
title("FT of rectangular pulse Magnitude");
subplot(1,2,2);
plot (t, angle(X_W3));
title("FT of rectangular pulse Phase");
