samples = csvread('../data/samples6.txt',1,0); % skip header
samplerate = 5000;
sampletime = 1/samplerate;
samples = samples-samples(1);
samples = samples.';
times = (1:length(samples)) * sampletime;
figure(1);
plot(times,samples);

period = 0.012;
ctimes = 0:sampletime:period;
corr = sin(ctimes*(1/period)*2*pi);
corr = horzcat(corr, zeros(1,1024-length(corr)));
scale = sum(corr.^2);
figure(2);

fr = (0:length(times)*2+1)*samplerate/length(times);
S = fft(horzcat(samples, zeros(1,513)));
plot(fr, abs(S));
xlim([0,300]);
figure(3);

convolved = ifft(fft(corr) .* S)/scale;
plot(convolved);