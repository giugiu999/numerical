function [pos, J] = evalRobot2D(l, theta)
    pos = 0;
    J = 0;
    theta1 = theta(1);
    theta2 = theta(2);
    l1 = l(1);
    l2 = l(2);

    x = l1 * cos(theta1) + l2 * cos(theta1 + theta2);
    y = l1 * sin(theta1) + l2 * sin(theta1 + theta2);
    pos = [x; y];

    % Analytic Jacobian
    dx_dtheta1 = -l1 * sin(theta1) - l2 * sin(theta1 + theta2);
    dx_dtheta2 = -l2 * sin(theta1 + theta2);
    dy_dtheta1 =  l1 * cos(theta1) + l2 * cos(theta1 + theta2);
    dy_dtheta2 =  l2 * cos(theta1 + theta2);

    J = [dx_dtheta1, dx_dtheta2;
         dy_dtheta1, dy_dtheta2];
end
