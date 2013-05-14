x = y';  % necessary to keep notation

n = length(x);
A = get_A_random(n,m);
b = A*x;

% Solve using CVX.
Psi = conj(dftmtx(n))/n;
% Psi = inv(dftmtx(n));
cvx_begin
  variable xp(n) complex;
  minimize(norm(xp,1));
  subject to
    A*Psi*xp == b;
cvx_end

% recovered signal in time domain
xp = real(Psi*xp)';
x = x';

plot(t,x,'b');
hold;
plot(t,(x-xp),'r'); grid on;

axis([0 duration -f_amp_max f_amp_max]); % adjust scaling
legend('Original','Recovered');

% SER
SER = 10*log10(norm(x)/norm(x-xp))
