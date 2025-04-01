function [eigenvalue, eigenvector] = normalized_power_iteration(A, max_iter)
    n = size(A, 1);
    v = rand(n, 1); 
    v = v / norm(v);

    for k = 1:max_iter
        v_new = A * v;
        v_new = v_new / norm(v_new);
        
        if 1 - abs(v' * v_new) < 1e-8
            break;
        end
        
        v = v_new;
    end

    eigenvalue = (v' * A * v) / (v' * v); 
    eigenvector = v;
end