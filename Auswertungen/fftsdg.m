test = dlmread('re100dg3cpd60cl.dat', '',1,0);
%test2 = dlmread('re100dg1cpd40cd.dat', '',1,0);
t= test(:,1);
c = test(:,2);


a1 = find(test(:,1) >= 90); %filtert alle Werte ab t>= 90 raus
t1 = test(a1,1);    %Zeit
cl = test(a1,2);    %Auftrieb
%cd = test2(a1,2);

figure
plot(t,c)
xlabel('Time', 'FontSize', 12)
ylabel('C_L', 'FontSize', 12)
hold off
figure
plot(t1,cl)
xlabel('Time', 'FontSize', 12)
ylabel('C_L', 'FontSize', 12)
hold off
figure 
plot(t1,cd)
xlabel('Time', 'FontSize', 12)
ylabel('C_D', 'FontSize', 12)
hold off

T=150; % im Bereich 90-150s -> 60
Fs = 1/T;
%T = 1/Fs;           
L = length(cl)-1;     %Zeitschrittvektor ist eins kürzer als Auftriebsvektor
t = (0:L)*T;
Y = fft(cl);


P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
[M,I] = max(P1)
f1=f(I);
f = Fs*(0:(L/2))/L;
f1 = f(I);
dt = mean(t1(2:end,1)-t1(1:end-1,1)); %Zeitschritt 
strouhal = f1/dt*T %bezieht Frequenz auf physikalische Zeit

% cl_mean=mean(cl)
% cl_max=max(cl)-mean(cl);
% cl_min=min(cl)-mean(cl);
% clabwe = (cl_max-cl_min)/2
% 
% 
% cd_mean = mean(cd)
% cd_abweichungoben = max(cd)-cd_mean;
% cd_abweichungunten = min(cd)-cd_mean;
% abweichung = (cd_abweichungoben - cd_abweichungunten)/2


