% Define the true polynomial coefficients(e.g., p(x) = 2x^3 - 3x^2 + x - 5)
coeffs = [2, -3, 1, -5];

% Define the data points
x_data = [-1, 0, 1, 2];
y_data = polyval(coeffs, x_data);

% Determine the degree of the polynomial
degree = length(coeffs) - 1;

% Below, x is defined as a "symbolic variable" that allows you to work with it directly as a polynomial
% If this gives you an error "syms requires Symbolic Math Toolbox", simply
% click on the underlined link and press "install"
syms x;
% we can use our coefficients directly to evaluate the polynomial
true_poly = 0;
for i = 0:degree
    true_poly = true_poly + coeffs(i + 1) * x^(degree-i);
end

% Print the polynomial
fprintf('True polynomial:\n');
pretty(simplify(true_poly));

% These numbers are given as an EXAMPLE.

% For full marks, your code must work for any polynomial of any degree.
% You can assume you will always have exactly as many unique data points as needed for the system to have a unique solution.

% For 50% marks, your solution must work for any degree 3 polynomial with 4 unique data points.

% No marks will be given if your solution works only for the example polynomial (hard coded).
% Make sure to test with other constants!


% Monomial basis (5 marks total)
fprintf('Monomial basis:\n');

% Set up the linear system
A_monomial = zeros(length(x_data), degree + 1);
for i = 1:length(x_data)
    for j = 0:degree
        A_monomial(i, degree - j + 1) = x_data(i)^j;
    end
end

fprintf('A matrix:\n');
disp(A_monomial);

% Solve the linear system
b = y_data';
monomial_coeffs = A_monomial \ b;

fprintf('Coefficients:\n');
disp(monomial_coeffs);

% we can use our coefficients directly to evaluate the polynomial
monomial_poly = 0;
for i = 0:degree
    monomial_poly = monomial_poly + monomial_coeffs(i + 1) * x^(degree - i);
end

% Print the monomial basis polynomial
fprintf('Monomial basis polynomial:\n');
pretty(monomial_poly);


% Lagrange basis (10 marks total)
fprintf('Lagrange basis:\n');

% Set up the Lagrange polynomial
lagrange_poly = 0;
n = length(x_data);

for i = 1:n
    L = 1;
    for j = 1:n
        if j ~= i
            L = L * (x - x_data(j)) / (x_data(i) - x_data(j));
        end
    end
    lagrange_poly = lagrange_poly + y_data(i) * L;
end

% Print the Lagrange basis polynomial
fprintf('Unsimplified polynomial:\n');
pretty(lagrange_poly);
fprintf('Simplified polynomial:\n');
pretty(simplify(lagrange_poly));




% Newton basis (10 marks total)
fprintf('Newton basis:\n');

% Similar to the Monomial basis, we create a matrix of coefficients derived from the data points
A_newton = zeros(n, n);
for i = 1:n
    A_newton(i, 1) = 1;
    for j = 2:i
        A_newton(i, j) = prod(x_data(i) - x_data(1:j-1));
    end
end

fprintf('A matrix:\n');
disp(A_newton);

% The linear system has the same solution b as the Monomial basis
temp_coeffs = A_newton \ b;

fprintf('Coefficients:\n');
disp(temp_coeffs);

% Like Lagrange interpolation, you will create the unsimplified polynomial from the coefficients, and let MatLab simplify it.
newton_poly = temp_coeffs(1);
term = 1;
for i = 2:n
    term = term * (x - x_data(i - 1));
    newton_poly = newton_poly + temp_coeffs(i) * term;
end

% Print the Newton basis polynomial
fprintf('Newton basis polynomial:\n');
pretty(newton_poly);
fprintf('Newton simplified:\n');
pretty(simplify(newton_poly));