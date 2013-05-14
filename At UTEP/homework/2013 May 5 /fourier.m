% Adapted from http://homepages.math.uic.edu/~jan/mcs320s07/matlec7.pdf

Y = fft(y); % compute Fourier transform
n_f = size(y,2)/2; % 2nd half are complex conjugates
amp_spec = abs(Y)/n_f; % absolute value and normalize

f_max = max(f);
freq = (1:f_max)/(2*n_f*dt); % abscissa viewing window

plot(freq, amp_spec(1:f_max)); grid on % plot amplitude spectrum

xlabel('Frequency (Hz)'); % 1 Hertz = number of cycles/second
ylabel('Amplitude'); % amplitude as function of frequency
