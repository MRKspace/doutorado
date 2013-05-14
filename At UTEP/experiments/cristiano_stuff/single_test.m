clear all; close all; clc;

% Create a random signal
N = 256; % signal length
eta = 16; % sparsity
ell = eta:5*eta; % numbers of measurements
T = randn(N, N); % random transformation signal
invT = inv(T);
support_X = randperm(N);
support_X = support_X(1:eta);
X = zeros(N, 1);
X(support_X) = randn(eta, 1);
x = invT * X;

% Take the measurements
ell = 60;
M = randn(ell, N); % measurement matrix
b = M * x;

% Reconstruct with prior information (wrong and correct locations)
c = 8; % correct locations
w = 6; % wrong locations
Phim = setdiff(1:N, support_X); % all possible wrong locations
Phim = [support_X(1:c) Phim(1:w)]; % c correct and w wrong locations
p = 0.1;
A = M * invT;
[Xr, num_iterations, time_to_complete, initial_x] = ...
minimize_p_norm_equality_constraint_prior_information...
(p, A, b, Phim);
xr = invT * Xr;

figure;
plot(x); hold on; plot(xr, 'r');
legend('Original signal', 'Reconstructed signal')

figure;
plot(xr - x);
title('Reconstruction error');
