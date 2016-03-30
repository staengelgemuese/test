test = dlmread('re200dg2cpd60cl.dat', '',1,0);
test2 = dlmread('re100dg2cpd60cd.dat', '',1,0);
t= test(:,1);
c = test(:,2);
plot(t,c)

a1 = find(test(:,1) >= 110);
t1 = test(a1,1);
cl = test(a1,2);
cd = test2(a1,2);

Fs = 1;
T = 1/Fs;            % Sampling frequency           % Sampling period
L = length(cl)-1;             % Length of signal
t = (0:L-1)*T;
Y = fft(cl);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
% plot(f,P1)
f1 = f(find(P1 == max(P1)));
dt = 60/L;

strouhal = f1/dt

cl_mean=mean(cl)
cl_max=max(cl)-mean(cl);
cl_min=min(cl)-mean(cl);
clabwe = (cl_max-cl_min)/2


cd_mean = mean(cd)
cd_abweichungoben = max(cd)-cd_mean;
cd_abweichungunten = min(cd)-cd_mean;
abweichung = (cd_abweichungoben - cd_abweichungunten)/2



% n = length(cl)
% dt = mean(t1(2:end,1)-t1(1:end-1,1))
% fs = 1/dt;
% [pxx,f] = periodogram(cl-mean(cl),[],[],fs);
% mean(f)
% mean(f)*dt
% 
% % plot(t1,cl)
% plot(f,pxx)
% 0.1056/dt
% [ClYD1MP4,ClID1MP4]=max(abs(fft(cl-cl_mean)));
% ClfreqD1MP4=0:fs/length(ClyD1MP4):Fs/2;
% Clfreq(1,1)=ClfreqD1MP4(ClID1MP4);