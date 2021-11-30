clc
clear -except A B C

A = [0 20.6; 1 0];

B = [0; 1];

C = [0 1];

polos = [-10 -10];

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
disp('Obtencion de polinomio caracteristico de |sI - A^t|')
fprintf('******************************************************************\n\n')

syms s;

sIA = s*eye(size(A)) - transpose(A);
disp(sIA);

fprintf('|sI - A| = \n\n');
det_sIA = det(sIA);
disp(det_sIA);

disp('******************************************************************')
disp('Obtencion matriz W')
fprintf('******************************************************************\n\n')

cofs_a =sym2poly(det_sIA);

W = zeros(size(sIA));

for i=1: length(sIA)-1
    
    for j=1: length(sIA)-1
        elemento = length(cofs_a) - j - i + 1;
        W(j ,i) = cofs_a(elemento);
    end
    fila = j - i + 2;
    W(fila , i) = 1;
    
end
W(1, length(sIA)) = 1;

clear i j fila elemento

fprintf('W = \n\n');
disp(W);

disp('******************************************************************')
disp('Matriz de transformacion Q')
fprintf('******************************************************************\n\n')

fprintf('Q = W * N^t\n\n');
Q = inv(W * transpose(N));
disp(Q);

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
disp('Coeficientes del polinomio caracteristico deseado')
fprintf('******************************************************************\n\n')

cofs_alfa = sym2poly(pol_deseado);
disp(pol_deseado);

fprintf('coeficientes = \n\n');
disp(cofs_alfa);

disp('******************************************************************')
disp('Arreglo delta')
fprintf('******************************************************************\n\n')

delta = [];
for i=length(cofs_a):-1:2   
    delta = [delta cofs_alfa(i) - cofs_a(i)];
end

delta = transpose(delta);
fprintf('delta =\n\n');
disp(delta);


disp('******************************************************************')
disp('Matriz de ganancias Ke  ->  Ke = Q * delta')
fprintf('******************************************************************\n\n')

Ke = Q * delta;
fprintf('Ke =\n\n');
disp(Ke);


