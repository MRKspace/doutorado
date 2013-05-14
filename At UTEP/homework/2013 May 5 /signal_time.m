% Adapted from http://homepages.math.uic.edu/~jan/mcs320s07/matlec7.pdf

% sampling rate
dt = 1/2000;

% signal size (in seconds)
duration = 0.3;

% sampling range
t = 0:dt:duration;

% frequencies in Hz
f(1)  = 100; f_amp(1) = 1;
f(2)  = 20;  f_amp(2) = 1;
f(3)  = 10;  f_amp(3) = 1;
f(4)  = 4;   f_amp(4) = 1;

y = 0; % dummy
y = y + f_amp(1)*sin(2*pi*f(1)*t);    
y = y + f_amp(2)*sin(2*pi*f(2)*t);
% y = y + f_amp(3)*sin(2*pi*f(3)*t);
% y = y + f_amp(4)*sin(2*pi*f(4)*t);

plot(t,y,'b'); grid on % plot with grid

f_amp_max = max(max(y),abs(min(y)))*1.2;
axis([0 duration -f_amp_max f_amp_max]); % adjust scaling

title('Signal: Mix of Sinusoidal Functions')
xlabel('Time (s)'); % time expressed in seconds
ylabel('Amplitude'); % amplitude as function of time
