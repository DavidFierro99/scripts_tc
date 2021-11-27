%% matriz_exponencial_homogeneo.m
% Calcula el e^At de una matriz de estados, solo cuando U = 0

clc
clear

%% Campos editables por el ususario 
% Añadir en esta seccion los valores de las matrices A

A = [-1 2; -1 -4];

% Inserte "SI" para que calcule X(t), inserte "NO" para que se detenga una
% vez encontrado e^At
Hay_condiciones_iniciales = 'SI';

X0 = [-1; 1];


%% Inicio de script

syms s;

disp('******************************************************************')
disp('Variables de entrada')
fprintf('******************************************************************\n\n')

fprintf('A = \n\n');
disp(A);

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

if Hay_condiciones_iniciales == 'SI'
    
    disp('******************************************************************')
    disp('Calculo X(t) = e^At * X(0)')
    fprintf('******************************************************************\n\n')
    
    Xt = e_At*X0;
    disp(Xt);
end
