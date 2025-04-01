clear;
clc;
% sample data
t = [-1.0; -0.5; 0.0; 0.5; 1.0]; % t 
y = [ 1.0;  0.5; 0.0; 0.5; 2.0]; % object value
b=y;
% p(t) = x0 + x1*t + x2*t^2 + x3*(2*t^2))
A = [ones(size(t)),t,t.^2,(2*t.^2)];

% QR
[Q, R] = qr(A, 0);
disp('QR Factorization:');
disp('Q = '); disp(Q);
disp('R = '); disp(R);
%R*x = Q'*b using backSubst
y_qr = Q' * b;               

% Attempt back-substitution (may fail if R is rank-deficient)
try
    x_qr = backSubst(R, y_qr, size(R,1));  % Recursive back substitution
    disp('Least-Squares Solution x (QR) = ');
    disp(x_qr);
catch ME
    disp('Error: R is rank-deficient or singular, making backSubst unreliable.');
    disp('A better approach is to use SVD (which we will implement in the next part).');
end

[U, S, V] = svd(A, 0);  % Reduced SVD decomposition

% Print matrices
disp('SVD Factorization:');
disp('U = '); disp(U);
disp('S = '); disp(S);
disp('V = '); disp(V);
% Compute y_svd = U' * b
y_svd = U' * b;
% Solve S*z = y_svd using a pseudo-inverse approach
z = pseudoBackSubst(S, y_svd);

% Compute x = V * z
x_svd = V * z;

% Print solution
disp('Least-Squares Minimum-Norm Solution x (SVD) = ');
disp(x_svd);
%plot data
tplot = linspace(-1, 1, 100)';  % Smooth curve for plotting
p_svd = x_svd(1) + x_svd(2)*tplot + x_svd(3)*tplot.^2 + x_svd(4)*(2*tplot.^2);

figure; hold on;
plot(t, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2);  % Data points
plot(tplot, p_svd, 'g-', 'LineWidth', 2); 
legend('Data', 'Quadratic Fit (SVD)', 'Location', 'Best');
title('Least-Squares Quadratic Approximation (5x4) using SVD');
xlabel('t'); ylabel('y');
grid on;

% learnt from johnsonwu
function x = pseudoBackSubst(S, y)
    % Solve S*x = y using pseudo-inverse for singular values
    n = length(y);
    x = zeros(n,1);
    tol = 1e-10; % Tolerance for near-zero singular values
    for i = 1:n
        if abs(S(i,i)) > tol
            x(i) = y(i) / S(i,i); % Regular division
        else
            x(i) = 0; % Handle singular values by setting corresponding x component to zero
        end
    end
end
