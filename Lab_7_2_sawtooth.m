clc;
clear all;
close all;

T = 2*pi;
W0 = (2*pi)/T;
t = linspace(1,4*pi,1000);
N = 10;

st_wave = zeros(1,length(t));


grid on;
figure(1)
for n = 1:N
    st_wave = st_wave + ((2/pi)*(((-1)^(n+1))*(sin(n*W0*t)/n)));
    hold on;
    plot(t,st_wave);
end
figure(2)
plot(t,st_wave);
grid on;