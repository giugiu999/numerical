function compareJacobian()
% Q1: Are the results close enough to be useful?
%     Yes, the finite-difference approximation produces useful results when
%     an appropriate step size h is chosen (typically in the range 1e-5 to 1e-7).
%     In this range, the approximation closely matches the analytical Jacobian,
%     with relative errors on the order of 1e-6 to 1e-8, which is sufficient
%     for most practical applications.

% Q2: Why use finite-difference approximation instead of analytical derivative?
%     There are several key reasons:
%     1. Complexity: For complex systems, deriving analytical derivatives may be
%        mathematically challenging or time-consuming
%     2. Verification: Finite-difference provides a way to verify the correctness
%        of analytical Jacobian implementations
%     3. Development speed: During rapid prototyping, it can accelerate development
%        by avoiding derivative calculations
%     4. Black-box systems: When dealing with systems whose internal structure is
%        unknown or inaccessible, finite-difference may be the only option
%     5. Maintenance: Makes code more maintainable as the system evolves, since
%        derivative formulas don't need to be updated


test_cases = {
    % Name          l         theta
    'Case 1',      [1;1],    [pi/4; pi/4];   % Specified example in problem
    'Case 2',      [1;1],    [0; pi/2];      % Singular configuration
    'Case 3',      [1.5;0.8], [0.5; 1.2]     % Asymmetric links
};

% Test multiple step sizes (h values)
hs = [1e-1, 1e-3, 1e-5, 1e-7];  % Range of step sizes to evaluate

for i = 1:size(test_cases,1)
    name = test_cases{i,1};
    l = test_cases{i,2};
    theta = test_cases{i,3};
    
    fprintf('\n=== %s ===\n', name);
    fprintf('Link lengths: [%.2f; %.2f], Joint angles: [%.3f; %.3f] rad\n', ...
            l(1), l(2), theta(1), theta(2));
    
    % Compute analytical Jacobian
    [pos, J_ana] = evalRobot2D(l, theta);
    fprintf('End-effector position: [%.4f; %.4f]\n', pos(1), pos(2));
    fprintf('Analytical Jacobian:\n'); disp(J_ana);
    
    % Test finite-difference approximation with different step sizes
    for h = hs
        J_fd = fdJacob2D(l, theta, h);
        abs_err = norm(J_fd - J_ana, 'fro');  % Frobenius norm of error
        rel_err = abs_err / norm(J_ana, 'fro'); % Relative error
        
        fprintf('--- h = %.0e ---\n', h);
        fprintf('Finite-difference Jacobian:\n'); disp(J_fd);
        fprintf('Absolute error: %.2e, Relative error: %.2e\n', abs_err, rel_err);
    end
end
fprintf('\ntest done\n');
end