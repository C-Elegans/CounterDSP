% Program for generating n-length FFT's twiddle factor
% By: Denny Hermawanto
% Puslit Metrologi LIPI, INDONESIA
% Copyright 2015

%fft_length = input('Enter FFT length:');
fft_length = 1024;
%file = 1;
file = fopen('twid.c', 'w');
%file = fopen(input('Enter output file:'),'w');


for mm = 0:1:(fft_length-1)
    theta = (-2*pi*mm*1/fft_length);

%   Twiddle factor equation
%   twiddle = exp(1i*theta);

%   Euler equation for complex exponential 
%   e^(j*theta) = cos(theta) + j(sin(theta)) 
    
    twiddle(mm+1) = cos(theta) + (1i*(sin(theta)));

    real_twiddle = real(twiddle);
    real_twiddle = real_twiddle';
    im_twiddle = imag(twiddle);
    im_twiddle = im_twiddle';
end
fprintf(file, "#include <dsp.h>\n");
fprintf(file, "const fractcomplex twiddleFactors[]\n");
fprintf(file, "__attribute__ ((space(auto_psv), aligned (%d*2)))= {", fft_length);
for i = 1:length(real_twiddle)/2
    if mod(i,4) == 1
        fprintf(file,"\n");
    end
    fprintf(file,"%04x,",floattofrac(real_twiddle(i)));
    fprintf(file,"%04x,",floattofrac(im_twiddle(i)));
end
fprintf(file,"};\n");
if file>2
    fclose(file);
end
function f = floattofrac(twid)
    if twid == 1
        twid_scale = 2^15-1;
    else
        twid_scale = twid*(2^15);
    end
    
    f = bitand(int32(round(twid_scale)),65535);
end
