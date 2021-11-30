clc
clear -except A B C

A = [-1 1 0; 0 -2 1; 0 0 -3];

B = [0; 0; 1];

C = [1 2 0];

polos = [-6 -6 -6];

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
disp('Obtencion de transpuestas')
fprintf('******************************************************************\n\n')

fprintf('At = \n\n');
At = transpose(A);
disp(At);

fprintf('Ct = \n\n');
Ct = transpose(C);
disp(Ct);

disp('******************************************************************')
disp('Obtencion de matriz de observabilidad (o martiz N)')
fprintf('******************************************************************\n\n')

N = [];

for i=0: n - 1
    fprintf('(A^t)^%i * C^t = \n', i);
    disp(transpose(A)^i * Ct);
    
    N = [N transpose(A)^i * Ct];
end

clear i;

fprintf('N = \n\n');
disp(N);
    
fprintf('Rango N = \n\n');
disp(rank(N));
    
if length(A) - rank(N) == 0
    disp('El sistema es de estados completamente observables');
else
    disp('---------------------------------------------------------');
    disp('El sistema NO es de estados completamente observables');
    disp('---------------------------------------------------------');
    return
end

disp('******************************************************************')
disp('Polos deseados')
fprintf('******************************************************************\n\n')

syms s;

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
disp('Calculo de matriz Ke')
fprintf('******************************************************************\n\n')

aux = zeros(length(N), 1);
aux(length(N)) = 1;

Ke = phi_A * inv(transpose(N)) * aux;
fprintf('Ke = \n\n');
disp(Ke)


