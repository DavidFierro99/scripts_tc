%% matriz_exponencial_homogeneo.m
% Calcula el e^At de una matriz de estados, cuando U != 0

clc
clear

%% Campos editables por el ususario 
% Añadir en esta seccion los valores de las matrices A, B C X0 y U

A = [-1 2; -1 -4];

B = [1; 1];

C = [1 2];

X0 = [-1; 1];

% Funcion de entrada, generalmente se evalua con un escalon igual a 1
U = 1;


%% Inicio de script

syms s;

disp('******************************************************************')
disp('Variables de entrada')
fprintf('******************************************************************\n\n')

fprintf('A = \n\n');
disp(A);
fprintf('B = \n\n');
disp(B);
fprintf('C = \n\n');
disp(C);
fprintf('X0 = \n\n');
disp(X0);
fprintf('U = \n\n');
disp(U);

disp('******************************************************************')
disp('Calculo s*I - A (sIA)')
fprintf('******************************************************************\n\n')

sIA = s*eye(size(A)) - A;
disp(sIA);

disp('******************************************************************')
disp('Determinante s*I - A')
fprintf('******************************************************************\n\n')

det_sIA = det(sIA);
disp(det_sIA);

disp('******************************************************************')
disp('calculo cof(s*I - A)')
fprintf('******************************************************************\n\n')

disp(transpose(adjoint(sIA)));

disp('******************************************************************')
disp('Inverso matriz [sI-A]')
disp('[sI-A]^-1 = cof(sI-A)^T')
disp('            ------------')
disp('               |sI-A|')
fprintf('******************************************************************\n\n')

inv_sIA = adjoint(sIA)/det(sIA);
disp(inv_sIA);

disp('******************************************************************')
disp('Matriz exponencial  e^At = L^-1(s*I - A)^-1')
fprintf('******************************************************************\n\n')

e_At = ilaplace(inv_sIA);
disp(e_At);

    
disp('******************************************************************')
disp('Calculo e^At * X(0)')
fprintf('******************************************************************\n\n')

eAtX0 = e_At*X0;
disp(eAtX0);
 
disp('******************************************************************')
disp('Sustitucion e^A(t - tao)')
fprintf('******************************************************************\n\n')

syms t tao;
T = t -tao;
eAt_Tao = subs(e_At, t, T);

disp(eAt_Tao);

disp('******************************************************************')
disp('Calculo e^A(t - tao) * B * U')
fprintf('******************************************************************\n\n')

eBU = eAt_Tao * B * U;
disp(eBU);

disp('******************************************************************')
disp('Integral(e^A(t - tao) * B * U) t1 = t, t2 = 0')
fprintf('******************************************************************\n\n')

int_eBU = int(eBU, tao, 0, t);
disp(int_eBU);

disp('******************************************************************')
disp('Calculo X(t) = e^At * X(0) + integral(e^A(t - tao) * B * U)dtao')
fprintf('******************************************************************\n\n')

Xt = eAtX0 + int_eBU;
disp(Xt);

disp('******************************************************************')
disp('Ecuacion de salida Y(t) = C * X(t)')
fprintf('******************************************************************\n\n')

Y = C * Xt;
disp(Y);
