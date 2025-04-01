function [eigenvalue, eigenvector] = inverse_iteration(A, max_iter)
    n = size(A, 1);
    v = rand(n, 1);
    v = v / norm(v);
    shift = 0; 
    
    [L, U, P] = lu(A - shift * eye(n));
    
    for k = 1:max_iter
        v = U \ (L \ (P * v));
        v = v / norm(v);
        
        if k > 1 && 1 - abs(v_prev' * v) < 1e-8
            break;
        end
        v_prev = v;
    end
    
    eigenvalue = (v' * A * v) / (v' * v);
    eigenvector = v;
end