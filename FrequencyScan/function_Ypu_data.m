function [f, Y_dq0, Y_dq, Y_dq1, Y_dq2, Y_PN, Y_PN_noRC] = function_Ypu_data(T, fig_no, c1)
% Y_dq0: original data, per unitized
% Y_dq: get rid of RC filter at 13.2 kV
% Y_dq1 :get rid of Xfm, viewed at PCC bus.
% Y_dq2: get rid of C filter, viewd at PCC bus. 
f=T(:,1);

Sbase=1e6;Vbase2=13.2e3;
Zbase2=Vbase2^2/Sbase;
Ybase2 = 1/Zbase2;
w0 = 2*pi*60;

C1 =444e-6;
L1 = 46e-6;
r1 =1e-3;

Sbase = 1e6; % 1 MW 
Vbase1 = 400; % 400 V
w0 =2*pi*60; 
Zbase1 = Vbase1^2/Sbase;
Ybase1 = 1/Zbase1; 

X1 = w0*L1/Zbase1; %0.1084
R1 = r1/Zbase1; 
L1 = X1/w0; 
B1 = C1*w0/Ybase1*3; %0.0268*3
C1 = B1/w0; 



Mag_Ydd=T(:,2);
Pha_Ydd=T(:,3);
Mag_Ydq=T(:,4);
Pha_Ydq=T(:,5);
Mag_Yqd=T(:,6);
Pha_Yqd=T(:,7);
Mag_Yqq=T(:,8);
Pha_Yqq=T(:,9);

Ydd = 10.^(Mag_Ydd/20).*exp(1i*Pha_Ydd*pi/180); 
Ydq = 10.^(Mag_Ydq/20).*exp(1i*Pha_Ydq*pi/180); 
Yqd = 10.^(Mag_Yqd/20).*exp(1i*Pha_Yqd*pi/180); 
Yqq = 10.^(Mag_Yqq/20).*exp(1i*Pha_Yqq*pi/180); 

for k=1:length(f)
    Y_dq0(:,:,k) = [Ydd(k), Ydq(k); Yqd(k), Yqq(k)]*Zbase2;
end

w0=2*pi*60;R=15;C=6.39e-6;
for k=1:length(f); 
    s = 1i*2*pi*f(k); % jw  
    temp = 1/2*[1, 1i; 1, -1i]*[Ydd(k), Ydq(k); Yqd(k), Yqq(k)]*[1,1; -1i, 1i];
   
    Z_RC =[R+1/(C*(s+1i*w0)), 0; 0, R+1/(C*(s-1i*w0))];
    Y_RC = inv(Z_RC);
    Y_RC_dq = 1/2*[1, 1; -1i, 1i]*Y_RC*[1,1i; 1, -1];

    Y_dq(:,:,k) = ([Ydd(k), Ydq(k); Yqd(k), Yqq(k)]-Y_RC_dq)*Zbase2; 
    
    temp1 = temp-Y_RC;
    Y_PN(:,:,k) = temp*Zbase2; 
    Y_PN_noRC(:,:,k) =(temp-Y_RC)*Zbase2;
end


Rg = 0.02; Xg = 0.0721; Lg = Xg/w0; 
for k=1:length(f)
   s =1i*2*pi*f(k); 
   temp = Y_dq(:,:,k);
   Zxfm =[Rg+s*Lg, -Xg; Xg, Rg+s*Lg];
   Y_c =[C1*s, -B1; B1, C1*s];
   Y_dq1(:,:,k) = inv(inv(temp)-Zxfm); 
   Y_dq2(:,:,k) = inv(inv(temp)-Zxfm)-Y_c; 
end


Mag_Ydd=T(:,2)-20*log10(Ybase2);
Pha_Ydd=T(:,3);
Mag_Ydq=T(:,4)-20*log10(Ybase2);
Pha_Ydq=T(:,5);
Mag_Yqd=T(:,6)-20*log10(Ybase2);
Pha_Yqd=T(:,7);
Mag_Yqq=T(:,8)-20*log10(Ybase2);
Pha_Yqq=T(:,9);
% Pha_Ydd = phase_wrapping(Pha_Ydd);
% Pha_Ydq = phase_wrapping(Pha_Ydq);
% Pha_Yqd = phase_wrapping(Pha_Yqd);
% Pha_Yqq = phase_wrapping(Pha_Yqq);




%figure(101)

%k = 1:2 first Y(1,1)
%k = 3:4, Y(1,2) 
%    5:6, Y(2,1)
%    7,8, Y(2,2)
%Y(i, j) 
%index of T: 
% N-1 =[2*(i-1)+2*(j-1)+1, 2*(i-1)+2*(j-1)+2], 
%subplot(4,2,

figure(fig_no)
c2 = strcat(c1,'.');
subplot(4,2,1)
semilogx(f,Mag_Ydd,c2);
hold on; semilogx(f,Mag_Ydd,c1);
grid on
%ylim([-80, -20]);
ylabel('Mag (dB)');
xlim([0.1,1000]);
subplot(4,2,3)
semilogx(f,Pha_Ydd,c2);
grid on;
hold on; semilogx(f,Pha_Ydd,c1);
ylabel('Phase (degree)');
%xlabel('Frequency (Hz)')
%suptitle('Y_{dd}')
xlim([0.1,1000]);
ylim([-200,200]);
%figure(102)
subplot(4,2,2)
semilogx(f,Mag_Ydq,c2);
grid on
hold on; semilogx(f,Mag_Ydq,c1);
%ylabel('Mag (dB)');
xlim([0.1,1000]);
%ylim([-80, -20]);
subplot(4,2, 4)
semilogx(f,Pha_Ydq,c2);
grid on;
hold on; semilogx(f,Pha_Ydq,c1);
ylabel('Phase (degree)');
ylim([-200,200]);


%xlabel('Frequency (Hz)')
xlim([0.1,1000]);
%suptitle('Y_{dq}')

%figure(103)
subplot(4,2, 5)
semilogx(f,Mag_Yqd,c2);
grid on
hold on; semilogx(f,Mag_Yqd,c1);
%ylim([-80, -20]);
xlim([0.1,1000]);
ylabel('Mag (dB)');
%ylim([-80, -20]);

subplot(4, 2, 7)
semilogx(f,Pha_Yqd,c2);
grid on;
hold on; semilogx(f,Pha_Yqd,c1);
ylim([-200,200]);
xlim([0.1,1000]);
ylabel('Phase (degree)');
xlabel('Frequency (Hz)')
%suptitle('Y_{qd}')

%figure(104)
subplot(4, 2, 6);
semilogx(f,Mag_Yqq,c2);
grid on;
hold on; semilogx(f,Mag_Yqq,c1);
xlim([0.1,1000]);
%ylim([-80, -20]);
%ylabel('Mag (dB)');
subplot(4, 2, 8)
semilogx(f,Pha_Yqq,c2);
grid on;
hold on; semilogx(f,Pha_Yqq,c1);
xlim([0.1,1000]);
ylim([-200,200]);
%ylabel('Phase (degree)');
xlabel('Frequency (Hz)')
%suptitle('Y_{qq}')