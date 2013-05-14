% http://www.matrixlab-examples.com/gaussian-distribution.html

% We produce 500 random numbers between -100 and 100, with mean m = 0 and standard deviation s = 30. The code is: 
a = -100; b = 100;
x = a + (b-a) * rand(1, 500);
m = (a + b)/2;
s = 30; 

% Then, we plot this information using our bell curve: 
f = gauss_distribution(x, m, s);
plot(x,f,'.')
grid on
title('Bell Curve')
xlabel('Randomly produced numbers')
ylabel('Gauss Distribution') 