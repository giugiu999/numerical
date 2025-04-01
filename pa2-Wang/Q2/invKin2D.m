function theta = invKin2D(l, theta0, pos, n, mode)
    theta = theta0;
    tol = 1e-3; 
    
    if mode == 1
        % Newton's Method
        for i = 1:n
            [current_pos, J] = evalRobot2D(l, theta);
            error = pos - current_pos;

            if norm(error) < tol
                break;
            end

            delta = pinv(J) * error; 
            theta = theta + delta;
        end

    elseif mode == 0
        % Broyden's Method
        [current_pos, J] = evalRobot2D(l, theta);
        error = pos - current_pos;

        for i = 1:n
            if norm(error) < tol
                break;
            end

            delta = pinv(J) * error;
            theta_new = theta + delta;

            [new_pos, ~] = evalRobot2D(l, theta_new);
            error_new = pos - new_pos;

            y = error_new - error;
            delta_vec = delta(:); 
            
            if norm(delta_vec) > 1e-6  
                J = J + ((y - J * delta_vec) * delta_vec') / (delta_vec' * delta_vec);
            end

            theta = theta_new;
            error = error_new;
        end

    else
        fprintf("Error");
    end
end
