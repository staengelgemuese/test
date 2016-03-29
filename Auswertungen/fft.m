test = dlmread('CLRE100.dat', '',1,0);


% data = fscanf(test, '%f');
a1 = find(test(:,1) >= 90);
t1 = test(a1,1);
cl = test(a1,2);

mean(cl)
max(cl)
min(cl)

n = length(cl)
dt = mean(t1(2:end,1)-t1(1:end-1,1))
fs = 1/dt;
[pxx,f] = periodogram(cl-mean(cl),[],[],fs);
mean(f)
mean(f)*dt