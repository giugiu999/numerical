function [eigenvalues, eigenvectors] = qr_iteration(A, max_iter)
    n = size(A, 1);
    V = eye(n); 
    
    for k = 1:max_iter
        [Q, R] = qr(A);
        A = R * Q;
        V = V * Q; 
    end
    
    eigenvalues = diag(A);
    eigenvectors = V;
end