clc;
clear all;
close all;

snrd = 0:10;

a = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
a = kron(ones(10^6,1),a);
g = [1 1 1 0 1 0 0 0 1 0 0 0 0 0 0 0];
ta = 2*a - 1;

for m = 1:length(snrd)
n = 10^(-snrd(m)/20)*randn(10^6,16);
r1 = ta + n;
r = r1 > 0;
w = r;
g1 = kron(ones(10^6,1),g);

for i = 1:10^6
    j = 0;
while j~=16   
    w(i,1:16) = mod(w(i,1:16)+g1(i,1:16),2);
    g1(i,1:16) = transpose(circshift(transpose(g1(i,1:16)),1));
    if sum(w(i,1:16)>0) <= 3
        break
    end   
    j = j+1;
end
end

K = mod(w+r,2);
K1 = abs(K-a);
K2 = sum(K1);
K3l(m) = sum(K2);
end
semilogy(snrd,K3l/(16*10^6));
xlabel('snr(dB)')
ylabel('BER')
title('BER vs SNR for LDPC code (16,8)')


snrd = 0:10;

a = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
a = kron(ones(10^6,1),a);
g = [1 1 1 0 1 0 0 0 1 0 0 0 0 0 0];
ta = 2*a - 1;

for m = 1:length(snrd)
n = 10^(-snrd(m)/20)*randn(10^6,15);
r1 = ta + n;
r = r1 > 0;
w = r;
g1 = kron(ones(10^6,1),g);

for i = 1:10^6
    j = 0;
while j~=15   
    w(i,1:15) = mod(w(i,1:15)+g1(i,1:15),2);
    g1(i,1:15) = transpose(circshift(transpose(g1(i,1:15)),1));
    if sum(w(i,1:15)>0) <= 3
        break
    end   
    j = j+1;
end
end

K = mod(w+r,2);
K1 = abs(K-a);
K2 = sum(K1);
K3b(m) = sum(K2);
end
figure;
semilogy(snrd,K3b/(15*10^6));
xlabel('snr(dB)')
ylabel('BER')
title('BER vs SNR for BCH code (15,7)')


snrd = 0:10;

a = [1 1 1 1 1 1 1];
a = kron(ones(10^6,1),a);
g = [1 1 1 0 0 0 0];
ta = 2*a - 1;

for m = 1:length(snrd)
n = 10^(-snrd(m)/20)*randn(10^6,7);
r1 = ta + n;
r = r1 > 0;
w = r;
g1 = kron(ones(10^6,1),g);

for i = 1:10^6
    j = 0;
while j~=7   
    w(i,1:7) = mod(w(i,1:7)+g1(i,1:7),2);
    g1(i,1:7) = transpose(circshift(transpose(g1(i,1:7)),1));
    if sum(w(i,1:7)>0) <= 1
        break
    end   
    j = j+1;
end
end

K = mod(w+r,2);
K1 = abs(K-a);
K2 = sum(K1);
K3h(m) = sum(K2);
end
figure;
semilogy(snrd,K3h/(7*10^6));
xlabel('snr(dB)')
ylabel('BER')
title('BER vs SNR for Hammimg code (7,4)')

figure;
semilogy(snrd,K3l/(16*10^6));
hold on;
semilogy(snrd,K3b/(15*10^6));
hold on;
semilogy(snrd,K3h/(7*10^6));
xlabel('snr(dB)')
ylabel('BER')
title('BER vs SNR')
legend('LDPC (16,8)','BCH (15,7)','Hamming (7,4)');