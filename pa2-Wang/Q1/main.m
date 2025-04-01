A = [2 1 0; 1 3 1; 0 1 2];  
save('A.mat', 'A');         
load A.mat;

max_iter = 1000;

% Get the student output
[eigenvalue_npi, eigenvector_npi] = normalized_power_iteration(A, max_iter);
[eigenvalue_ii, eigenvector_ii] = inverse_iteration(A, max_iter);
[eigenvalues_qr, eigenvectors_qr] = qr_iteration(A, max_iter);

% Ger MATLAB's output
[eigenvectors_matlab, eigenvalues_matlab] = eig(A);

% normalize Eigenvectors, since they may be scaled by a constant
eigenvector_npi = eigenvector_npi / norm(eigenvector_npi);
eigenvector_ii = eigenvector_ii / norm(eigenvector_ii);
for i = 1:size(eigenvectors_qr, 2)
    eigenvectors_qr(:,i) = eigenvectors_qr(:,i) / norm(eigenvectors_qr(:,i));
end
for i = 1:size(eigenvectors_matlab, 2)
    eigenvectors_matlab(:,i) = eigenvectors_matlab(:,i) / norm(eigenvectors_matlab(:,i));
end

% Print
fprintf('MATLAB calculated eigenvalues: \n');
disp(diag(eigenvalues_matlab));

fprintf('My normalized power iteration eigenvalue: \n    %f\n', eigenvalue_npi);
fprintf('My inverse iteration eigenvalue: \n    %f\n', eigenvalue_ii);
fprintf('My QR iteration eigenvalues: \n');
disp(eigenvalues_qr);



fprintf('MATLAB calculated eigenvectors: \n');
disp(eigenvectors_matlab);

fprintf('My normalized power iteration eigenvector: \n');
disp(eigenvector_npi);
fprintf('My inverse iteration eigenvector: \n');
disp(eigenvector_ii);
fprintf('My QR iteration eigenvectors: \n');
disp(eigenvectors_qr);

