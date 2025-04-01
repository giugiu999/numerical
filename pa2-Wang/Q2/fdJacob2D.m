function J = fdJacob2D(l, theta, h)
    J = 0;
    theta1 = theta + [h; 0];
    theta2 = theta - [h; 0];
    col1 = (evalRobot2D(l, theta1) - evalRobot2D(l, theta2)) / (2*h);

    theta3 = theta + [0; h];
    theta4 = theta - [0; h];
    col2 = (evalRobot2D(l, theta3) - evalRobot2D(l, theta4)) / (2*h);

    J = [col1, col2];
end