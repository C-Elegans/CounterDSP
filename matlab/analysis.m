samples = csvread('../data/samples.txt',1,0); % skip header
samplerate = 5000;
sampletime = 1/samplerate;
samples = samples-samples(1);
times = (1:length(samples)) * sampletime;
figure(1);
plot(times,samples);

S = fft(samples)
figure(2);

plot(abs(S));
xlim([0,10]);