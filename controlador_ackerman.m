clc
clear

A = [-1 1 0; 0 -2 1; 0 0 -3];

B = [0; 0; 1];

polos = [complex(-2,4), complex(-2,-4) -10];

%% Inicio de script

n = size(A, 1);

if n ~= size(A, 2)
    disp('Tamanio incorrecto de matriz A');
    return
end

if size(B, 1) ~= n 
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
disp('Obtencion de matriz de controlabilidad (o martiz M)')
fprintf('******************************************************************\n\n')

M = [];

for i=0: n - 1
       
    M = [M A^i * B];
end

clear i;

fprintf('M = \n\n');
disp(M);

fprintf('M^-1 = \n\n');
disp(inv(M));
      
if length(A) - rank(M) == 0
    fprintf('El sistema es de estados completamente controlables\n\n');
else
    disp('Los vectores columna de la matriz de controlabilidad no son linealmente independientes');
    disp('---------------------------------------------------------');
    disp('El sistema NO es de estados completamente controlables');
    disp('---------------------------------------------------------');
    return
    
end

disp('******************************************************************')
disp('Polos deseados')
fprintf('******************************************************************\n\n')

polos = s*ones(size(polos)) - polos;
disp(polos)

pol_deseado = 1;

for i=1: length(polos)
    pol_deseado = pol_deseado * polos(i);
end

clear i

disp('******************************************************************')
disp('Polinomio caracteristico deseado')
fprintf('******************************************************************\n\n')

cofs_alfa = sym2poly(pol_deseado);
disp(pol_deseado);

fprintf('coeficientes = \n\n');
disp(cofs_alfa);

disp('******************************************************************')
disp('Calculo de phi(A)')
fprintf('******************************************************************\n\n')

fprintf('phi(A) %s = \n\n', poly2str(cofs_alfa, 'A'));
phi_A = polyvalm(cofs_alfa, A);
disp(phi_A);


disp('******************************************************************')
disp('Calculo de matriz K')
fprintf('******************************************************************\n\n')

aux = zeros(1, length(M));
aux(length(M)) = 1;

K = aux * inv(M) * phi_A;
fprintf('K = \n\n');
disp(K)


