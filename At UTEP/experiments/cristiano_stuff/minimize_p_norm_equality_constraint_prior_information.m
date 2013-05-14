function [x, num_iterations, time_to_complete, initial_x] = ...
minimize_p_norm_equality_constraint_prior_information...
(p, A, b, Phim, tol_symmlq, N, initial_mu, final_mu, factor_mu, ...
 x0, tol, tau, max_inner_iterations);

% |--- Instructions ---|-------------------------{{{
%
% [x, num_iterations, time_to_complete, initial_x] = ...
% minimize_p_norm_equality_constraint_prior_information...
% (p, A, b, Phim, tol_symmlq, N, initial_mu, final_mu, factor_mu, ...
%  x0, tol, tau, max_inner_iterations);
%
% Tries to solve the optimization problem 
%                  min ||x_{k not in Phim}||_p
%                  subject to A x = b,
% using weighted normal equations.
%
% The input Phim specifies which positions of x, if  any, are known to
% be nonzero (Phim must be a vector containing index from 1 to N, with
% N the length of x). If omitted (empty set), the optimization problem
% to be solved becomes
%                  min ||x||_p
%                  subject to A x = b.
% 
% Matrix A can  be specified directly (in which case  the internal linear
% system  is  solved  also  directly)  or  indirectly  via  two  external
% functions. In the last case, the input A should be [], and two external
% functions Sy.m  and Ahermitian.m are then  to be provided by  the user.
% The first  function, Sy.m, must  compute, for  each input vector  y and
% parameter vector q, the result of
%                  S y = A diag(q) A' y.
% The second function, Ahermitian, must compute, for each input vector y,
% the result of
%                  A' y.
% Also, in the  case of the indirect specification of  A, when the actual
% input is [],  the input N is  mandatory and must give the  length of x;
% otherwise, it is optional, as it can be inferred easily from A.

% The  input  tol_symmlq  defines  the tolerance  used  in  the  indirect
% solution to the inner system. This input is only relevant when A is not
% specified, so the functions Sy and  Ahermitian are used in the indirect
% solution. The standard value for tol_symmlq is
%                  tol_symmlq = 1e-3.
% 
% The  input  x0  specifies  the   initial  point  for  the  iterative
% procedure.  This  input   is  optional,  and  if   omitted  will  be
% automatically chosen by  the algorithm. An empty vector  can also be
% provided to force the automatic computation of the initial point, in
% case  the  user wants  to  specifies  the remaining  inputs  without
% specifying x0.
%
% The  inputs  initial_mu,  tau,  final_mu,  and  factor_mu  specify  the
% regularization  parameters  to  be  used when  defining  the  weighting
% matrix,  for  the  inverses  of   components  of  x  in  the  positions
% not  belonging  to  Phim  and  for the  positions  specified  in  Phim,
% respectively.  If mu  and r  are not  specified, the  following default
% values are used:
%                  initial_mu = 1,
%                  tau = 1e-1,
%                  final_mu = 1e-8,
%                  factor_mu = 0.10.
%
% The  input  tol  specifies  the  tolerance  that  define  the  stopping
% condition for the employed inner  iterative procedure. If the change in
% the norm-2 of  x from on iteration  to the next is less  than tol, then
% the stopping condition is satisfied and  no more iterations are run. If
% tol is not specified, the following default value is used:
%                  tol = 1e-2.
%
% The max_inner_iterations,  specifies the  maximum number  of iterations
% allowed in  the inner loop. If  not specified by the  user, the default
% value is used:
%                  max_inner_iterations = 30.
%
% ========================================
% = Cristiano Jacques Miosso             =
% = Last Modification: February 01, 2010 =
% ========================================

% Attention:
% 
% In  my experiments,  when using  the indirect  method I  found it  very
% important  to  try and  empirically  adjust  (to the  application)  the
% following parameters: initial_mu, final_mu, factor_mu, tol_symmlq.
%-}}}

% |=== Main function ===|==========================={{{
global EQUALITY_CONSTRAINT_MATRIX;
global LAST_Y;
LAST_Y = [];
tic;

% |--- Analysis of the inputs and config. ---|---{{{
if nargin < 13 | length(max_inner_iterations) == 0
	max_inner_iterations = 30;
end

if nargin < 12 | length(tau) == 0
	tau = 1e-1;
end

if nargin < 11 | length(tol) == 0
	tol = 1e-2;
end

if nargin < 10 | length(x0) == 0
	x0 = [];
end

if nargin < 9 | length(factor_mu) == 0
	factor_mu = 0.1;
end

if nargin < 8 | length(final_mu) == 0
	final_mu = 1e-8;
end

if nargin < 7 | length(initial_mu) == 0
	initial_mu = 1;
end

if (nargin < 6) | (length(N) == 0)
	N = size(A, 2);
end

if nargin < 5 | length(tol_symmlq) == 0
	tol_symmlq = 1e-3;
end

if nargin < 4
	Phim = [];
end

EQUALITY_CONSTRAINT_MATRIX = A;
%-}}}

% |--- Prepare for iterations ---|---------------{{{
Phim_ = Phim;
Phim_ = unique(Phim_);

starting_time = toc;
q = ones(N,1);
q(Phim_) = q(Phim_)/tau;

if(length(x0) == 0) % Compute here an appropriate initial point.
	y = solve_linear_system(q, b, tol_symmlq);
	xp = q.*(Ahermit_(y));
else
	xp = x0;
end
initial_x = xp;
num_iterations = 0;
mu = initial_mu;
%-}}}

% |--- Iterations ---|---------------------------{{{
stage = 1;
while (mu >= final_mu)
	stop = 0;
	inner_iterations = 0;
	textoutput(['Starting stage ' num2str(stage)]);
	while(~stop)
		x_regularization = abs(xp) + mu;
		q = x_regularization.^(2-p);
		q(Phim_) = q(Phim_)/tau;
		y = solve_linear_system(q, b, tol_symmlq);
		x = q.*(Ahermit_(y));
		inner_iterations = inner_iterations + 1;
		num_iterations = num_iterations + 1;
		stop = ((inner_iterations == max_inner_iterations)|...
		(norm(x - xp) / (1 + norm(xp)) < tol * sqrt(mu)));
		xp = x;
		textoutput(['Inner iteration ' num2str(inner_iterations) ' concluded.']);
	end
	mu = mu * factor_mu;
	stage = stage + 1;
	textoutput('=========================================================');
end
time_to_complete = toc - starting_time;
%-}}}
%======}}}

% |--- solve_linear_system ---|-------------------{{{
function y = solve_linear_system(q, b, tol_symmlq);
global EQUALITY_CONSTRAINT_MATRIX;
global Q_VECTOR
global LAST_Y
A = EQUALITY_CONSTRAINT_MATRIX;
Q_VECTOR = q;
if(size(A,1) == 0)
	maxiter = 1e6;
	[y, flag] = symmlq('Sy', b, tol_symmlq, maxiter, [], [], LAST_Y);
	LAST_Y = y;
else
	Sys = A * diag(q) * A';
	y = Sys \ b;
end
%-}}}

% |--- Ahermit_ ---|-----------------------------{{{
function z = Ahermit_(y);
global EQUALITY_CONSTRAINT_MATRIX;
A = EQUALITY_CONSTRAINT_MATRIX;
if(size(A,1) == 0)
	z = Ahermitian(y);
else
	z = A' * y;
end
%-}}}
