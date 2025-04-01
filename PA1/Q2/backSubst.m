function x = backSubst(U,y,k)
    % Ux = y
    [~, n] = size(U);
    if ~exist('k', 'var')
        k = n;
    end

    x = zeros(n, 1);
    for i = k:-1:1
        s = U(i, i+1:n) * x(i+1:n);
        if U(i, i) == 0
        end
        x(i) = (y(i)-s)/U(i, i);
    end
end
