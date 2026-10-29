clc;
clear all;
close all;

T = 2*pi;
W0 = (2*pi)/T;
t = linspace(1,4*pi,1000);
N = 10;

sq_wave = zeros(1,length(t));
grid on;
figure(1)
for n = 1:N
    if mod(n,2) == 1
    sq_wave = sq_wave + ((4/pi)*(sin(n*W0*t)/n));
    hold on;
    plot(t,sq_wave);
    end
end

figure(4)
plot(t,sq_wave);
grid on;

