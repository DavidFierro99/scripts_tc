%% controlabilidad.m
% Dadas la matrices de estados A y B determina si es sistema es de estados
% completamente controlables

clc
clear

%% Campos editables por el ususario 
% Añadir en esta seccion los valores de las matrices A, B y C (se asume que
% D = 0)

A = [2 -1; 0 -3];

B = [1; 0];


%% Inicio de script

n = size(A, 1);

if n ~= size(A, 2)
    disp('Tamanio incorrecto de matriz A');
    return
end

if size(B, 1) ~= n || size(B, 2) ~= 1
    disp('Tamanio incorrecto de matriz B');
    return
end

syms s;

disp('******************************************************************')
disp('Variables de entrada')
fprintf('******************************************************************\n\n')

fprintf('A = \n\n');
disp(A);
fprintf('B = \n\n');
disp(B);

disp('******************************************************************')
disp('Obtencion de matriz de controlabilidad')
fprintf('******************************************************************\n\n')

Co = [];

for i=0: n - 1
    fprintf('A^%i * B = \n', i);
    disp(A^i * B);
    
    Co = [Co A^i * B];
end

clear i;

fprintf('Co = \n\n');
disp(Co);
    
disp('******************************************************************')
disp('Determinante de matriz de controlabilidad')
fprintf('******************************************************************\n\n')

disp(det(Co));

if det(Co) == 0
    disp('Los vectores columna de la matriz de controlabilidad no son linealmente independientes');
    disp('---------------------------------------------------------');
    disp('El sistema NO es de estados completamente controlables');
    disp('---------------------------------------------------------');
else
    disp('---------------------------------------------------------');
    disp('El sistema es de estados completamente controlables');
    disp('---------------------------------------------------------');
end
