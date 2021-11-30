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

fprintf('Co = \n\n');
disp(M);
      
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
disp('Obtencion de polinomio caracteristico de |sI - A|')
fprintf('******************************************************************\n\n')

syms s;

sIA = s*eye(size(A)) - A;
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
disp('Matriz de transformacion T')
fprintf('******************************************************************\n\n')

fprintf('T = M * W\n\n');
T = M * W;
disp(T);

fprintf('T^-1 =\n\n');
disp(inv(T));

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
disp(cofs_alfa);

disp('******************************************************************')
disp('Arreglo delta')
fprintf('******************************************************************\n\n')

delta = [];
for i=length(cofs_a):-1:2   
    delta = [delta cofs_alfa(i) - cofs_a(i)];
end

fprintf('delta =\n\n');
disp(delta);


disp('******************************************************************')
disp('Matriz de ganancias K  ->  K = delta * T^-1')
fprintf('******************************************************************\n\n')

K = delta * inv(T);
fprintf('K =\n\n');
disp(K);


