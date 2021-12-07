clc 
clear all
close all

Un = 230; %V
fn = 50; %Hz
nn = 1410; %o/min
P = 2; %broj pari polova
wn = nn*2*pi/60*P; %rad/s
Rs = 1.54; %oma
Rr = 2.55; %oma
ls = 0.0088; %H
lr = ls;
M = 207/1000; %H
wsn = 2*pi*fn; %rad/s
fsmin = 5; %Hz
wsmin = fsmin*2*pi; %rad/s
fsmax = 100; %Hz
wsmax = fsmax*2*pi; %rad/s

%% a)

N = 2000;
w = linspace(-wsn,3*wsn,N);
M1 = zeros(1,N);
M0 = zeros(1,N);

for i = 1:N
    M1(i) = fja1(wsn,P,Un,Rs,Rr,lr,ls,M,w(i));
end
Mp1 = max(M1);
Us0 = 0;
Mp0 = 0;

while (abs(Mp1 - Mp0)>0.01)
    Us0 = Us0 + 0.01;
    Us = Us0 + (Un - Us0)/wsn*wsmin;
    for i = 1:N
       M0(i) = fja1(wsmin,P,Us,Rs,Rr,lr,ls,M,w(i));
    end
    Mp0 = max(M0);
end

%% b)

f = 5:1:fn;
ws = f*2*pi;
Nk = 46;
Me = zeros(Nk,N);
Mp = zeros(1,Nk);
for k = 1:Nk
    Usk = Us0 + (Un - Us0)/wsn*ws(k);
    for i = 1:N
        Me(k,i) = fja1(ws(k),P,Usk,Rs,Rr,lr,ls,M,w(i));
    end
    Mp(k) = max(Me(k,:));
end

figure(1)
plot(f,Mp,'*')
xlabel('f [Hz]'); title('zavisnost prevalnog momenta od ucestanosti')
xlim([5 50]); grid on

%% c)

fc = 10:10:100;
wc = 2*pi*fc;
Nk = 10;
Me = zeros(Nk,N);

figure(2)
for k = 1:Nk
    if (fc(k)<50)
        Usk = Us0 + (Un - Us0)/wsn*wc(k);
    else
        Usk = Un;
    end
    for i = 1:N
        Me(k,i) = fja1(wc(k),P,Usk,Rs,Rr,lr,ls,M,w(i));
    end
    plot(w,Me(k,:));
    hold on;
end

legend('f = 10', 'f = 20', 'f = 30', 'f = 40', 'f = 50',...
    'f = 60', 'f = 70', 'f = 80', 'f = 90', 'f = 100',...
    'Location','Southeast');
xlabel('w [rad/s]'); ylabel('moment'); xlim([-wsn/3 3*wn])
title('staticke karaktarestike'); grid on




