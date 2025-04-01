t = [-1.0, -0.5, 0.0, 0.5, 1.0]';  
y = [1.0, 0.5, 0.0, 0.5, 2.0]';  
%A: qr()
A = [t.^2, t, ones(size(t))];   
[Q, R] = qr(A, 0);  

% Print Q,R
disp('Matrix Q:');  
disp(Q);  
disp('Matrix R:');  
disp(R);  

% Step B:backSubst
function x = backSubst(U, y)  
    n = length(y);  
    x = zeros(n, 1);  
    for k = n:-1:1  
        x(k) = (y(k) - U(k, k+1:n) * x(k+1:n)) / U(k, k);  
    end  
end 
b = y;  
rhs = Q' * b;
x = backSubst(R, rhs);  

% Print x
disp("x:");  
disp(x);   

% Step C:plot data points and quadratic function  
scatter(t, y, 'filled'); hold on;  
t_fit = linspace(min(t), max(t), 100);  
y_fit = x(1) * t_fit.^2 + x(2) * t_fit + x(3);  
plot(t_fit, y_fit, 'r-', 'LineWidth', 2);  
xlabel('t'); ylabel('y');  
title('Quadratic Fit Using QR Factorization');  
legend('Data Points', 'Quadratic Fit');  
hold off;  


%SVD
t = [-1.0, -0.5, 0.0, 0.5, 1.0]';
y = [1.0, 0.5, 0.0, 0.5, 2.0]';
A = [t.^2, t, ones(size(t))];

[U, S, V] = svd(A, 'econ');
disp('Matrix U:');
disp(U);
disp('Matrix S:');
disp(S);
disp('Matrix V:');
disp(V);

% Step E: SVD components
y_svd = U' * b;

% Use backSubst to solve S * z = y_svd
z = backSubst(S, y_svd);

% Compute x = V * z
x_svd = V * z;

% Print solution
disp('x_svd: ');
disp(x_svd);

% it's not efficient to use backcbct here, since s is diagonal, we can use
% y_svd = U' * b;
% z = y_svd ./ diag(S);  
% x_svd = V * z;
% instead

%plot data
scatter(t, y, 'filled'); hold on;
t_fit = linspace(min(t), max(t), 100);
y_fit = x(1) * t_fit.^2 + x(2) * t_fit + x(3);
plot(t_fit, y_fit, 'b-', 'LineWidth', 2);
xlabel('t'); ylabel('y');
title('Quadratic Fit Using SVD');
legend('Data Points', 'Quadratic Fit');
hold off;

