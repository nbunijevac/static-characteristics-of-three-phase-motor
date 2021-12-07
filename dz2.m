clc 
clear all
close all 

N = 2000;
Pn = 3000; %kW
Un = 220; %V
In = 6.3; %A
fn = 50; %Hz
nn = 1398; %o/min
P = 2; %broj pari polova
wn = nn*2*pi/60*P; %rad/s
Rs = 1.54; %oma
Rr = 2.55; %oma
ls = 8.758/1000; %H
lr = ls;
M = 207/1000; %H
wsn = 2*pi*fn; %rad/s

%% iscrtavanje staticke karakteristike motora za nominalne 
%  uslove napajanja

ws = wsn;
%nominalna radna tacka
w1 = wn;
[M1,I1] = fja1(ws,P,Un,Rs,Rr,lr,ls,M,w1);
w = linspace(0,2*wsn,N);
Me = zeros(1,N);
Is = zeros(1,N);


for i = 1:N
    [Me(i),Is(i)] = fja1(ws,P,Un,Rs,Rr,lr,ls,M,w(i));
end

Mp = max(Me);
wp = w(find(Me==Mp));

figure(1)
    plot(w,Me); 
    xlabel('w [rad/s]'); ylabel('me [Nm]')
    hold on
    plot(w1,M1,'r*')
    hold on
    plot(0,Me(1),'b*')
    hold on
    plot(wp,Mp,'g*')
    hold on
    textString = sprintf('%f', Me(1));
    text(-70, 48, textString, 'FontSize', 7);
    hold off
    grid on
    xlim([0 2*wsn]);
    legend('staticka karakteristika',...
        'nominalna radna tacka',...
        'pocetni moment',...
        'tacka sa prevalnim momentom')
    title('staticka karakteristika motora sa znacajnim tackama')
    
%% iscrtavanje zavisnosti edektivne vrednosti struje statora od brzine

Is_eff = abs(Is)/sqrt(2);
Is_eff0 = Is_eff(1);
figure(2)
    plot(w,Is_eff);
    hold on;
    plot(w1,abs(I1)/sqrt(2),'r*');
    hold on;
    plot(0,Is_eff0,'b*')
     hold on
    textString = sprintf('%f', Is_eff0);
    text(-70, 23, textString, 'FontSize', 7);
    hold off
    grid on; legend('Iseff','Isnom','polazna struja')
    xlim([0 2*wsn]);
    xlabel('w [rad/s]'); ylabel('Is [A]')
    title('staticka zavisnost efektivne vrednosti struje statora od brzine')

 %% iscrtavanje kruznog dijagrama
 Is_r = real(Is);
 Is_i = imag(Is);
 
 figure(3)
    plot(Is_i,Is_r);
    title('kruzni dijagram')
    xlabel('imaginarni deo Is'); ylabel('realni deo Is')
    grid on
 
 %% poseban deo - 17 mod 3 = 2
 
 Us1 = 0.75*Un;
 Us2 = 0.5*Un;
 M1 = zeros(1,N);
 M2 = zeros(1,N);
 
 for i = 1:N
     M1(i) = fja1(wsn,P,Us1,Rs,Rr,lr,ls,M,w(i));
     M2(i) = fja1(wsn,P,Us2,Rs,Rr,lr,ls,M,w(i));
 end
 
 figure(4)
    plot(w,Me);
    hold on
    plot(w,M1);
    hold on
    plot(w,M2);
    hold off
    grid on
    xlim([0 2*wsn]);
    xlabel('w [rad/s]'); ylabel('me [Nm]')
    legend('Us = Usn','Us = 0.75*Usn','Us = 0.5*Usn')
    title('familija karakteristika')
    