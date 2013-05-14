
y = y + noise_factor*randn(size(t));     % Sinusoids plus noise
plot(t,y,'b'); grid on % plot with grid

f_amp_max = max(max(y),abs(min(y)))*1.2;
axis([0 duration -f_amp_max f_amp_max]); % adjust scaling

title('Signal Corrupted with Zero-Mean Random Noise');
xlabel('Time (s)'); % time expressed in seconds
ylabel('Amplitude'); % amplitude as function of time
