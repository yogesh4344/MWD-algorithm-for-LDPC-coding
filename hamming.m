clc;
clear all;
close all;

snrd = 3;
a = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
g = [1 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0];
ta = 2*a - 1;

n = 10^(-snrd/20)*randn(1,16);

r1 = ta + n;
r = real(r1)>0;
%r = [1 1 0 0 1 1 0 1 1 1 1 1 1 1 1 1];
w = r;

while 1
    
    w = mod(w+g,2);
    g = transpose(circshift(transpose(g),1));
    if sum(w>0) <= 3
        break
    end
    
end
