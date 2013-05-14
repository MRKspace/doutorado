clear all; close all; clc;

t = pi/4;
A = [cos(t), -sin(t) ; sin(t), cos(t)];
% A = [1, -1 ; 1, 1];
% A = [1, 1 ; 1, 1];
% A = [1, -2 ; 3, 1];
% A = [2, 1 ; 1.5, 2];
% A = [2, 1 ; 1.5, .85];
% A = [2, 1 ; 1, 2];
% A = [1.1, 2 ; 3, 1];

min_point = -10;
max_point = 10;
num_points = 11;
scale_factor = 1.3;

% Red: original
% Blue: transformed

x = linspace(min_point, max_point, num_points);

pos = 1;
for i=1:num_points
    for j=1:num_points
        X(pos,:)=[x(i),x(j)];
        pos = pos + 1;
    end
end

Y_ = A*X';
Y = Y_';
scatter(X(:,1),X(:,2),'.r');
hold;
scatter(Y(:,1),Y(:,2),'.b');

x_min = min(min(Y(:,1)),min(X(:,1)));
x_max = max(max(Y(:,1)),min(X(:,1)));
y_min = min(min(Y(:,2)),min(X(:,2)));
y_max = max(max(Y(:,2)),min(X(:,2)));

axis_min = min(x_min, y_min)*scale_factor;
axis_max = max(x_max, y_max)*scale_factor;

axis([axis_min axis_max axis_min axis_max]);

% axis_top = max(abs(axis_min), abs(axis_max))*scale_factor;
% axis([-axis_top axis_top -axis_top axis_top]);

A
[x,l]=eig(A)
[x_i,l_i]=eig(inv(A))
 
