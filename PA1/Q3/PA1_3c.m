% learnt from johnsonwu
% Sample dataset
t = [-1.0; -0.5; 0.0; 0.5; 1.0];  % Time values
y = [ 1.0;  0.5; 0.0; 0.5; 2.0]; 
b=y;

A = [ t.^4,  t.^3,  t.^2,  t,  ones(size(t)) ];% degree 4 5by5

% QR
[Q, R] = qr(A, 0);
disp('QR Factorization:');
disp('Q = '); disp(Q);
disp('R = '); disp(R);
%backsbst
y_qr = Q' * b;  % Compute Q^T * b
x_qr = backSubst(R, y_qr, size(R,1));  % R*x = y_qr through backSubst

disp('Interpolation Coefficients x (QR) = ');
disp(x_qr);

% plot
tplot = linspace(-1, 1, 100)';  % Smooth curve for plotting
p_interp = x_qr(1)*tplot.^4 + x_qr(2)*tplot.^3 + x_qr(3)*tplot.^2 + x_qr(4)*tplot + x_qr(5);

figure; hold on;
plot(t, y, 'ro', 'MarkerSize', 8, 'LineWidth', 2);  % Data points
plot(tplot, p_interp, 'b-', 'LineWidth', 2);  % Interpolating polynomial
legend('Data', 'Interpolant (QR)', 'Location', 'Best');
title('Interpolation using QR Factorization');
xlabel('t'); ylabel('y');
grid on;

% SVD
[U, S, V] = svd(A);% A is square

% Print matrices
disp('SVD Factorization:');
disp('U = '); disp(U);
disp('S = '); disp(S);
disp('V = '); disp(V);

% Compute y_svd = U' * b
y_svd = U' * b;

% Solve S*z = y_svd using modified back-substitution (pseudo-inverse)
z = backSubst(S, y_svd, size(S,1));

% Compute x = V * z
x_svd = V * z;

% Print solution
disp('Interpolation Coefficients x (SVD) = ');
disp(x_svd);