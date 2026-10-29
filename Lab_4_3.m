clc;
clear all
close all;
x4=[3,-2,4,-2,3];
E=sum(abs(x4).^2);
disp(E);
% stability
if(E<inf)
    disp('system is stable');
else
    disp('system is unstable');
end
