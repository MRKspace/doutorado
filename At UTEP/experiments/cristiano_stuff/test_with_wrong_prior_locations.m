clear all; close all; clc;

number_test_signals = 100;

N = 256; % signal length
eta = 16; % sparsity
ell = eta:5*eta; % numbers of measurements
tol = 1e-5;

c = [0 4 8 8 11 12 14]; % numbers of correct prior locations
w = [0 0 4 0  3  0  2]; % numbers of wrong prior locations

percentage_correct_reconstructions = zeros(length(ell), length(c));

total_number_tests = length(c) * number_test_signals * length(ell);
tests_performed = 0;

warning off;

for(k = 1:length(c))
	c_ = c(k);
	w_ = w(k);
	for(s = 1:number_test_signals)
		file_name = ['signal_' num2str(s)];
		load(file_name, 'x', 'X', 'support_X', 'invT');
		for(n = 1 : length(ell))
			ell_ = ell(n);
			file_name = ['measurement_matrix_' num2str(ell_) '_by_' num2str(N)];
			load(file_name, 'M');
			b = M * x;
			A = M * invT;
			Phim = setdiff(1:N, support_X);
			Phim = [support_X(1:c_) Phim(1:w_)];
		       	p = 0.1;
			[Xr, num_iterations, time_to_complete, initial_x] = ...
			minimize_p_norm_equality_constraint_prior_information...
			(p, A, b, Phim);
			xr = invT * Xr;
			if(norm(x-xr) <= tol)
				percentage_correct_reconstructions(n, k) = percentage_correct_reconstructions(n, k) + 1;
			end
			tests_performed = tests_performed + 1;
			if(tests_performed == 10 * round(tests_performed/10))
				disp(['Test ' num2str(tests_performed) ' of ' num2str(total_number_tests) ' already performed.']);
			end
		end
	end
end

percentage_correct_reconstructions = percentage_correct_reconstructions/number_test_signals * 100;

figure;
for(k = 1 : length(c))
	c_ = c(k);
	w_ = w(k);
	plot(ell, percentage_correct_reconstructions(:, k));
	hold on;
end

warning on;

xlabel('ell');
ylabel('Percentages of correct reconstructions');
legend(['c = ' num2str(c(1)) ', w = ' num2str(w(1))], ...
       ['c = ' num2str(c(2)) ', w = ' num2str(w(2))], ...
       ['c = ' num2str(c(3)) ', w = ' num2str(w(3))], ...
       ['c = ' num2str(c(4)) ', w = ' num2str(w(4))], ...
       ['c = ' num2str(c(5)) ', w = ' num2str(w(5))], ...
       ['c = ' num2str(c(6)) ', w = ' num2str(w(6))], ...
       ['c = ' num2str(c(7)) ', w = ' num2str(w(7))]);
