%% controlabilidad.m
% Dadas la matrices de estados A y B determina si es sistema es de estados
% completamente controlables. Estas matrices pueden ser de una o multiples
% entradas.

clc
clear

%% Campos editables por el ususario 
% Añadir en esta seccion los valores de las matrices A, B y C (se asume que
% D = 0)

A = [2 0 0; 0 2 0; 0 3 1];

C = [1 0 0; 0 1 0];


%% Inicio de script

n = size(A, 1);

if n ~= size(A, 2)
    disp('Tamanio incorrecto de matriz A');
    return
end

if size(C, 2) ~= n 
    disp('Tamanio incorrecto de matriz B');
    return
end

syms s;

disp('******************************************************************')
disp('Variables de entrada')
fprintf('******************************************************************\n\n')

fprintf('A = \n\n');
disp(A);
fprintf('C = \n\n');
disp(C);

disp('******************************************************************')
disp('Obtencion de transpuestas')
fprintf('******************************************************************\n\n')

fprintf('At = \n\n');
At = transpose(A);
disp(At);

fprintf('Ct = \n\n');
Ct = transpose(C);
disp(Ct);

disp('******************************************************************')
disp('Obtencion de matriz de observabilidad')
fprintf('******************************************************************\n\n')

Ob = [];

for i=0: n - 1
    fprintf('(A^t)^%i * C^t = \n', i);
    disp(transpose(A)^i * Ct);
    
    Ob = [Ob transpose(A)^i * Ct];
end

clear i;

fprintf('Ob = \n\n');
disp(Ob);
    

if size(C, 1) == 1 
    
    disp('******************************************************************')
    disp('Determinante de matriz de Observabilidad')
    fprintf('******************************************************************\n\n')

    disp(det(Ob));
    
else
    disp('******************************************************************')
    disp('Rango de matriz de controlabilidad')
    fprintf('******************************************************************\n\n')
    
    disp(rank(Ob));
    
end
    
if length(A) - rank(Ob) == 0
    disp('---------------------------------------------------------');
    disp('El sistema es de estados completamente observables');
    disp('---------------------------------------------------------');
else
    disp('Los vectores columna de la matriz de observabilidad no son linealmente independientes');
    disp('---------------------------------------------------------');
    disp('El sistema NO es de estados completamente observables');
    disp('---------------------------------------------------------');
    
end