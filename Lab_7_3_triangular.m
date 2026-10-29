clc;
clear all;
close all;

T = 2*pi;
W0 = (2*pi)/T;
t = linspace(1,4*pi,1000);
N = 10;

tg_wave = zeros(1,length(t));

grid on;
figure(1)
for n = 1:N
    if mod(n,2) == 1
        tg_wave = tg_wave + ((8/(pi^2))*(((-1)^((n-1)/2))*(sin(n*W0*t)/(n^2))));
        hold on;
        plot(t,tg_wave);
    end
end

figure(2)
plot(t,tg_wave);
grid on;