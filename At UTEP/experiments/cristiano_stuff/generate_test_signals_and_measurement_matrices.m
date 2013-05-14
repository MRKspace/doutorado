clear all; close all; clc;

number_test_signals = 100;

N = 256; % signal length
eta = 16; % sparsity
ell = eta:5*eta; % numbers of measurements

% Random transformation matrix (in this test, without orthogonalization)
T = randn(N, N);
invT = inv(T);

% Measurement matrices
for(k = 1:length(ell))
	ell_ = ell(k);
	M = randn(ell_, N);
	file_name = ['measurement_matrix_' num2str(ell_) '_by_' num2str(N)];
	save(file_name, 'M');
	disp(['Measurement matrix' num2str(k) ' of ' num2str(length(ell)) ' generated.']);
end

for(k = 1 : number_test_signals)
	support_X = randperm(N);
	support_X = support_X(1:eta);
	X = zeros(N, 1);
	X(support_X) = randn(eta, 1);
	x = invT * X;
	file_name = ['signal_' num2str(k)];
	save(file_name, 'x', 'X', 'support_X', 'T', 'invT')
	disp(['Test signal' num2str(k) ' of ' num2str(number_test_signals) ' generated.']);
end

