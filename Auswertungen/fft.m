test = dlmread('re100dg1cpd40cl.dat', '',1,0);

t= test(:,1);
c = test(:,2);
plot(t,c)
% data = fscanf(test, '%f');
a1 = find(test(:,1) >= 90);
t1 = test(a1,1);
cl = test(a1,2);

T = 60;
Fs = 1/T;            % Sampling frequency           % Sampling period
L = length(cl);             % Length of signal
t = (0:L-1)*T;
Y = fft(cl);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1)

% cl_mean=mean(cl)
% cl_max=max(cl)
% cl_min=min(cl)
% 
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