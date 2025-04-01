% function [M_k, L_k] = elimMat(A, k)to compute elimination matrix
function [M_k, L_k] = elimMat(A, k)
[n, ~] = size(A);
M_k = eye(n);
L_k = eye(n);
%compute from k+1 to n
m = A(k+1:n, k)/A(k, k);
M_k(k+1:n, k) = -m;
L_k(k+1:n, k) = m;
end


