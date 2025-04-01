tic
for i = 1:1000
    t(i) = 2 * i;
    y(i) = sin(t(i));
end
toc

tic
t=2*(1:1000);
y=sin(t);
toc

clear;
clc;
%comparison:
%The vectorized(0.000676) is significantly faster than the
%for-loop(0.001961)