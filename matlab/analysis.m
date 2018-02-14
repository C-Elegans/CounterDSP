samples = csvread('../data/samples4.txt'); % skip header
samplerate = 5000;
sampletime = 1/samplerate;
samples = samples-samples(1);

samples = samples.';
times = (1:length(samples)) * sampletime;
samples = samples + pinknoise(length(samples)).*0.02;
figure(1);
plot(times,samples, 'LineWidth', 1);
set(gca, 'FontSize', 14);
title('Noisy input signal');

xlabel("Seconds", 'FontSize', 16);
ylabel("Volts", 'FontSize', 16);
xlim([0,0.1]);
print('plot1', '-dpng');
period = 0.012;
frequency = 1/period;
ctimes = 0:sampletime:period;
corr = sin(ctimes*frequency*2*pi);
corr = corr - 1/9*sin(ctimes*3*frequency*2*pi);
corr = corr + 1/25*sin(ctimes*5*frequency*2*pi);
%corr = horzcat(corr, zeros(1,1024-length(corr)));
scale = sum(corr.^2);
figure(2);

fr = (0:length(times)*2-1)*samplerate/length(times);
S = fft(horzcat(samples, zeros(1,512)));
%plot(fr, abs(S));
plot(ctimes, corr, 'LineWidth', 1);

set(gca, 'FontSize', 14);
title('Expected signal');

xlabel("Seconds", 'FontSize', 16);
ylabel("Volts", 'FontSize', 16);

print('plot2', '-dpng');
figure(3);

%convolved = ifft(fft(corr) .* S)/scale;
%plot(convolved);
out = xcorr(samples,corr/scale);
otimes = (1:length(out)) * sampletime;
plot(otimes, out, 'LineWidth', 1);
set(gca, 'FontSize', 14);
title('Convolved signal');

xlabel("Seconds", 'FontSize', 16);
ylabel("Units", 'FontSize', 16);

print('plot3', '-dpng');

figure(4);
hold on
plot(otimes, out.^2, 'LineWidth', 1);
plot(otimes, repmat(0.09^2,length(out)),'--', 'LineWidth', 1);
hold off
xlim([0,otimes(length(otimes))]);
legend('signal', 'threshold');
set(gca, 'FontSize', 14);
title('Convolved signal');

xlabel("Seconds", 'FontSize', 16);
ylabel("Units", 'FontSize', 16);

print('plot4', '-dpng');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Pink Noise Generation with MATLAB Implementation   %
%                                                      %
% Author: M.Sc. Eng. Hristo Zhivomirov        07/30/13 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y = pinknoise(N)

% function: y = pinknoise(N) 
% N - number of samples to be returned in a row vector
% y - a row vector of pink (flicker) noise samples

% The function generates a sequence of pink (flicker) noise samples. 
% In terms of power at a constant bandwidth, pink noise falls off at 3 dB/oct, i.e. 10 dB/dec. 

% difine the length of the vector and
% ensure that the M is even, this will simplify the processing
if rem(N, 2)
    M = N+1;
else
    M = N;
end

% generate white noise
x = randn(1, M);

% FFT
X = fft(x);

% prepare a vector with frequency indexes 
NumUniquePts = M/2 + 1;     % number of the unique fft points
n = 1:NumUniquePts;         % vector with frequency indexes 

% manipulate the left half of the spectrum so the PSD
% is proportional to the frequency by a factor of 1/f, 
% i.e. the amplitudes are proportional to 1/sqrt(f)
X = X(1:NumUniquePts);      
X = X./sqrt(n);

% prepare the right half of the spectrum - a conjugate copy of the left one,
% except the DC component and the Nyquist component - they are unique
% and reconstruct the whole spectrum
X = [X conj(X(end-1:-1:2))];

% IFFT
y = real(ifft(X));

% ensure that the length of y is N
y = y(1, 1:N);

% ensure unity standard deviation and zero mean value
y = y - mean(y);
y = y/std(y, 1);

end