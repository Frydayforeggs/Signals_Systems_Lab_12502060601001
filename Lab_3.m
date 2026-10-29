t=-2*pi:0.01:2*pi; 
x1=2*sin(2*pi*1*t);
subplot(3,2,1);
plot(t,x1);
xlabel("time");
ylabel("amplitude");
title("sine wave");
x2=sin(pi*t)./(pi*t);
subplot(3,2,2);
plot(t,x2);
xlabel("time");
ylabel("amplitude");
title("sinc function");
x3=sawtooth(t,1);
subplot(3,2,3);
plot(t,x3);
xlabel("time");
ylabel("amplitude");
title("Sawtooth function");
fs = 10000;
t2 = -1:1/fs:1;
x4 = tripuls(t2,20e-3);
x5 = rectpuls(t2,20e-3);
subplot(3,2,4);
plot(t2,x4);
axis([-0.1 0.1 -0.2 1.2])
xlabel('Time (sec)')
ylabel('Amplitude')
title('Triangular Aperiodic Pulse')
subplot(3,2,5);
plot(t2,x5);
axis([-0.1 0.1 -0.2 1.2])
xlabel('Time (sec)')
ylabel('Amplitude')
title('Rectangular Aperiodic Pulse')
t3=0:0.001:1;
x6= exp(-0.5*t3);
subplot(3,2,6);
plot(t3,x6);
xlabel("Time");
ylabel("Amplitude");
title("Exponential");
