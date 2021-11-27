% controlabilidad.m

clc
clear

%% Campos editables por el ususario 
% Añadir en esta seccion los valores de las matrices A, B y C (se asume que
% D = 0)

A = [-2 1 ; 0 -3];

B = [1; 0];


try size(A, 1)