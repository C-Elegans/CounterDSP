samples = csvread('../data/samples3.txt',1,0); % skip header
samplerate = 5000;
sampletime = 1/samplerate;
samples = samples-samples(1);
times = (1:length(samples)) * sampletime;
figure(1);
plot(times,samples);

period = 0.015;
ctimes = period:-sampletime:0;
corr = sin(ctimes*(1/period)*2*pi);
scale = sum(corr.^2);
figure(2);

fr = (0:length(times)-1)*samplerate/length(times);
plot(fr, abs(fft(samples)));
xlim([0,300]);
figure(3);

convolved = conv(samples,corr)/scale;
plot(convolved);