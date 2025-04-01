clc; clear;
% exmple 2.13
A = [1,2,2;4,4,2;4,6,4];
b = [3;6;10];

[L, U] = myLU(A);
disp('L:');
disp(L);
disp('U:');
disp(U);

% 3. LU
disp('Check if A = L * U:');
disp(L * U);

U_e = [1,2,2;0,-4,-6;0,0,-1];
L_e = [1,0,0;4,1,0;4,0.5,1];
t1 = isequal(U, U_e);
t2 = isequal(L, L_e);

% 4. fwd
y = fwdSubst(L, b, 1);
disp('y:');
disp(y);
y_e = [3;-6;1];
t3 = isequal(y, y_e);

% 5. back
x = backSubst(U, y, 3);
disp('x:');
disp(x);

b_e = [-1;3;-1];
t4 = isequal(x, b_e);

if t1&&t2&&t3&&t4
    disp("example 2.13 pass.");
else
    disp("error.");
end

% own example
A = [2, 4, 3; 6, 8, 5; 2, 4, 5];
b = [13; 31; 25];

[L, U] = myLU(A);
disp('L:');
disp(L);
disp('U:');
disp(U);

% 2. Verify A = L * U
disp('Check if A = L * U:');
disp(L * U);

% Expected L and U matrices
U_e = [2, 4, 3; 0, -4, -4; 0, 0, 2];
L_e = [1, 0, 0; 3, 1, 0; 1, 0, 1];
t1 = isequal(U, U_e);
t2 = isequal(L, L_e);

% 3. Forward substitution Ly=b
y = fwdSubst(L, b, 1);
disp('y:');
disp(y);

y_e = [13; -8; 12];
t3 = isequal(y, y_e);

% 4. Backward substitution Ux=y
x = backSubst(U, y, 3);
disp('x:');
disp(x);

x_e = [5.5;-4;6];
t4 = isequal(x, x_e);

% 5. Final check
if t1 && t2 && t3 && t4
    disp("own example pass.");
else
    disp("error.");
end
