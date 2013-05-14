clear all; close all; clc;

% Number of measurements for reconstruction
m = 50

% Amount of noise added to signal
noise_factor = .4;

% signal
subplot(2,4,1,'replace')
% signal_time;
signal_fourier;

subplot(2,4,5,'replace')
fourier;

% recover
subplot(2,4,2,'replace')
temp = y;
l1_recover;

subplot(2,4,6,'replace')
y = xp;
fourier;
y = temp;

%  signal + noise
subplot(2,4,3,'replace')
noise;

subplot(2,4,7,'replace')
fourier;

% recover + noise
subplot(2,4,4,'replace')
temp = y;
l1_recover;

subplot(2,4,8,'replace')
y = xp;
fourier;
y = temp;

maximize;