%% teorema_cayley_hamilton.m
% Script que comprueba una matriz A de acuerdo al teorema de
% cayley-hamilton

clc
clear

%% Campos editables por el ususario 
% Añadir en esta seccion los valores de las matrices A

A = [0 1; -2 -3];

syms s;

disp('******************************************************************')
disp('Variables de entrada')
fprintf('******************************************************************\n\n')

fprintf('A = \n\n');
disp(A);

disp('******************************************************************')
disp('Calculo  lambda * I - A')
fprintf('******************************************************************\n\n')

syms lambda;
disp(lambda * eye(size(A)) - A);

disp('******************************************************************')
disp('Calculo determinante lambdaI - A')
fprintf('******************************************************************\n\n')

p = poly(A);
disp(poly2str(p, 'lambda'));

disp('******************************************************************')
disp('Sustitucion lambda por matriz A')
fprintf('******************************************************************\n\n')

disp(polyvalm(p, A));