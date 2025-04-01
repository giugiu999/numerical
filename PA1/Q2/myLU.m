% myLU.m 文件
function [L, U] = myLU(A)
    [n, ~] = size(A);
    L = eye(n); 
    U = A;     
    
    for k = 1:n-1
        [M_k, L_k] = elimMat(U, k);
        U = M_k * U;              
        L = L * L_k;
    end
end
