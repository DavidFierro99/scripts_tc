%% estado2ft.m
% Convierte matrices de estado de un sistema SISO o MIMO a una
% funcion de transferencia o arreglo de funciones de transferencia
% mostrando el procedimiento en la consola
clc
clear

%% Campos editables por el ususario 
% Añadir en esta seccion los valores de las matrices A, B y C (se asume que
% D = 0)

A = [-2 1 ; -1 -4];

B = [1 0; -1 1];

C = [1 2; -1 1];

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
disp(adjoint(sIA))
disp('------------------------------------------------')
disp(det(sIA))

disp('******************************************************************')
disp('Y(s)/U(s) =  C * [sI-A]^-1 * B')
fprintf('******************************************************************\n\n')

C_sIA_inv = C*inv_sIA;
fprintf('C * [sI-A]^-1 =\n\n');
disp(C*adjoint(sIA))
disp('----------------------------------------------- * B')
disp(det(sIA))

disp('******************************************************************')
disp('Funcion de transferencia Y(s)/U(s)')
disp('o arreglo de funciones Q(s)')
fprintf('******************************************************************\n')

if size(C*adjoint(sIA)*B) == size(1)
    fprintf('\nY(s)/U(s) =\n\n');
else
    fprintf('\nQ(s) =\n\n');
end

disp(C*adjoint(sIA)*B)
disp('-----------------------------------------------')
disp(det(sIA))


