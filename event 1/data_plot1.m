clear
clc

format long

%% save Excel to .mat file
% data1 = xlsread('220214_0630-1015_decimated_External');
% save data_1015 data1

%%
load data_1015

% time
tout = data1(:,1)/1000; %unit change from msec to sec

%% Plant A, B, C, D: voltage&current phasor, 3 phase
for n = 1:1:length(tout)
    % plant A
    va_A(n) = data1(n,2)*exp(1i*data1(n,3)*pi/180);
    vb_A(n) = data1(n,4)*exp(1i*data1(n,5)*pi/180);
    vc_A(n) = data1(n,6)*exp(1i*data1(n,7)*pi/180);
    
    ia_A(n) = data1(n,8)*exp(1i*data1(n,9)*pi/180);
    ib_A(n) = data1(n,10)*exp(1i*data1(n,11)*pi/180);
    ic_A(n) = data1(n,12)*exp(1i*data1(n,13)*pi/180);
    
    % plant B
    va_B(n) = data1(n,14)*exp(1i*data1(n,15)*pi/180);
    vb_B(n) = data1(n,16)*exp(1i*data1(n,17)*pi/180);
    vc_B(n) = data1(n,18)*exp(1i*data1(n,19)*pi/180);
    
    ia_B(n) = data1(n,20)*exp(1i*data1(n,21)*pi/180);
    ib_B(n) = data1(n,22)*exp(1i*data1(n,23)*pi/180);
    ic_B(n) = data1(n,24)*exp(1i*data1(n,25)*pi/180);
    
    % plant C
    va_C(n) = data1(n,26)*exp(1i*data1(n,27)*pi/180);
    vb_C(n) = data1(n,28)*exp(1i*data1(n,29)*pi/180);
    vc_C(n) = data1(n,30)*exp(1i*data1(n,31)*pi/180);
    
    ia_C(n) = data1(n,32)*exp(1i*data1(n,33)*pi/180);
    ib_C(n) = data1(n,34)*exp(1i*data1(n,35)*pi/180);
    ic_C(n) = data1(n,36)*exp(1i*data1(n,37)*pi/180);
    
    % plant D
    va_D(n) = data1(n,38)*exp(1i*data1(n,39)*pi/180);
    vb_D(n) = data1(n,40)*exp(1i*data1(n,41)*pi/180);
    vc_D(n) = data1(n,42)*exp(1i*data1(n,43)*pi/180);
    
    ia_D(n) = data1(n,44)*exp(1i*data1(n,45)*pi/180);
    ib_D(n) = data1(n,46)*exp(1i*data1(n,47)*pi/180);
    ic_D(n) = data1(n,48)*exp(1i*data1(n,49)*pi/180);
    
    % plant ABCD PQ
    % S = va*conj(ia)+vb*conj(ib)+vc*conj(ic)
    % P = real(S)/10^6 in MW
    % Q = imag(S)/10^6 in MVAR
    P_A(n) = data1(n,52); Q_A(n) = data1(n,53);
    P_B(n) = data1(n,54); Q_B(n) = data1(n,55);
    P_C(n) = data1(n,56); Q_C(n) = data1(n,57);
    P_D(n) = data1(n,58); Q_D(n) = data1(n,59);
    
    % plant ABCD V
    Vpcc(n) = data1(n,61); %average(Vmag_A+Vmag_B+Vmag_C)*sqrt(3)/1000 in kV
end

%% negative sequence components
a = 1*exp(1i*120*pi/180);
Vn_A = 1/3*(va_A+a^2*vb_A+a*vc_A);
Vn_B = 1/3*(va_B+a^2*vb_B+a*vc_B);
Vn_C = 1/3*(va_C+a^2*vb_C+a*vc_C);
Vn_D = 1/3*(va_D+a^2*vb_D+a*vc_D);

In_A = 1/3*(ia_A+a^2*ib_A+a*ic_A);
In_B = 1/3*(ia_B+a^2*ib_B+a*ic_B);
In_C = 1/3*(ia_C+a^2*ib_C+a*ic_C);
In_D = 1/3*(ia_D+a^2*ib_D+a*ic_D);

%% plotting
% same figure as data sheet
figure('Name','All plants PQ')
all_PQ = [P_A; Q_A; P_B; Q_B; P_C; Q_C; P_D; Q_D];
plot(tout, all_PQ); grid on;
legend('Plant A P','Plant A Q','Plant B P','Plant B Q','Plant C P','Plant C Q','Plant D P','Plant D Q');
xlabel('Time (s)');
ylabel('P & Q  (MW & MVAR)');

xrange = [4000 5600];
% Plant A PQ plot
figure('Name','Plant A PQ')
subplot(2,1,1)
plot(tout, P_A); grid on;
legend('Plant A P');
ylabel('P (MW)');
% ylim([-150 500]);
xlim(xrange);

subplot(2,1,2)
plot(tout, Q_A); grid on;
legend('Plant A Q');
ylabel('Q (MVAR)');
xlabel('Time (s)');
xlim(xrange);
% ylim([-150 500]);

% Plant B PQ plot
figure('Name','Plant B PQ')
subplot(2,1,1)
plot(tout, P_B); grid on;
legend('Plant B P');
ylabel('P (MW)');
xlim(xrange);
% ylim([-150 500]);

subplot(2,1,2)
plot(tout, Q_B); grid on;
legend('Plant B Q');
ylabel('Q (MVAR)');
xlabel('Time (s)');
xlim(xrange);
% ylim([-150 500]);

% Plant C PQ plot
figure('Name','Plant C PQ')
subplot(2,1,1)
plot(tout, P_C); grid on;
legend('Plant C P');
ylabel('P (MW)');
xlim(xrange);
% ylim([-150 500]);

subplot(2,1,2)
plot(tout, Q_C); grid on;
legend('Plant C Q');
ylabel('Q (MVAR)');
xlabel('Time (s)');
xlim(xrange);
% ylim([-150 500]);

% Plant D PQ plot
figure('Name','Plant D PQ')
subplot(2,1,1)
plot(tout, P_D); grid on;
legend('Plant D P');
ylabel('P (MW)');
xlim(xrange);
% ylim([-150 500]);

subplot(2,1,2)
plot(tout, Q_D); grid on;
legend('Plant D Q');
ylabel('Q (MVAR)');
xlabel('Time (s)');
xlim(xrange);
% ylim([-150 500]);

% PCC bus voltage
figure('Name','PCC bus voltage')
plot(tout, Vpcc); grid on; hold on;
plot(tout, abs(Vn_A)*sqrt(3)/1000,'r--');
legend('Vpcc LL RMS from data','V_A^- from calculaion');
ylabel('Vpcc (kV)');
xlim(xrange);
xlabel('Time (s)');

% plant current
figure('Name','Plant current magnitude')
subplot(4,1,1)
plot(tout, abs(In_A)); grid on;
legend('Plant A I_A^-');
xlim(xrange);
ylabel('I^- (A)');

subplot(4,1,2)
plot(tout, abs(In_B)); grid on;
legend('Plant B I_B^-');
ylabel('I^- (A)');
xlim(xrange);

subplot(4,1,3)
plot(tout, abs(In_C)); grid on;
legend('Plant C I_C^-');
ylabel('I^- (A)');
xlim(xrange);

subplot(4,1,4)
plot(tout, abs(In_D));grid on;
legend('Plant D I_D^-');
ylabel('I^- (A)');
xlabel('Time (s)');
xlim(xrange);

%%
xrange = [4500 5000];
figure('Name','PQ 7000-10000 s')
subplot(2,1,1)
plot(tout, P_A); grid on; hold on;
plot(tout, P_B); plot(tout, P_C); plot(tout, P_D);
legend('P_A','P_B','P_C','P_D','Orientation','horizontal');
xlim(xrange);
ylabel('P (MW)');

subplot(2,1,2)
plot(tout, Q_A); grid on; hold on;
plot(tout, Q_B); plot(tout, Q_C); plot(tout, Q_D);
legend('Q_A','Q_B','Q_C','Q_D','Orientation','horizontal');
xlim(xrange);
ylabel('Q (MVAR)');
xlabel('Time (s)');

%%
figure('Name','PCC bus voltage')
plot(tout, Vpcc); grid on;
% plot(tout, abs(Vn_A)*sqrt(3)/1000,'r--');
legend('Vpcc LL RMS');
ylabel('Vpcc (kV)');
xlim(xrange);
xlabel('Time (s)');

%%
figure('Name','Imag 7000-10000 s')
plot(tout, abs(In_A)); grid on; hold on;
plot(tout, abs(In_B)); plot(tout, abs(In_C)); plot(tout, abs(In_D));
legend('I_A','I_B','I_C','I_D','Orientation','horizontal');
xlim(xrange);
ylabel('I (A)');


