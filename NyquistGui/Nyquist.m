clc; close all; clear;

syms s w jw;

% si el Numerador es solo un número ej. 8, poner 8 * (s/s)

N = 5*(s+8);
D = (s+11)*(s-8);

pretty(N);
pretty(D);

disp(".............");

N2 = subs(N, i*w);
D2 = subs(D, i*w);

pretty(N2);
pretty(D2);

disp(".............");

N3 = expand(N2);
D3 = expand(D2);

pretty(N3);
pretty(D3);
disp(".............");

assume(w, 'real');

N3_R = real(N3);
N3_I = imag(N3);

D3_R = real(D3);
D3_I = imag(D3);

disp("(" + char(N3_R) + ") + i(" + char(N3_I) + ") · " + "(" + char(D3_R) + ") - i(" + char(D3_I) + ")" );
disp("(" + char(D3_R) + ") + i(" + char(D3_I) + ") · " + "(" + char(D3_R) + ") - i(" + char(D3_I) + ")" );

disp(".............");

N4 = expand(N3 * (D3_R - i*D3_I));
N4_R = real(N4); 
N4_I = imag(N4);

disp("(" + char(N4_R) + ") + i(" + char(N4_I) + ")");
disp("(" + char(D3_R) + ")^2 + (" + char(D3_I) + ")^2");

disp(".............");

disp("Cruces con el eje imaginario");

disp("(" + char(N4_R) + ") = 0");

w_real = solve(N4_R);

size_real = size(w_real, 1);

disp("..............."); 

if size_real == 1
    disp("No hay cruces con el eje imaginario");
elseif size_real == 2
    w_final = abs(w_real(2));
    disp("w = ± " + char(abs(w_real(2))) + " = " + "±" + double(abs(w_real(2))));
    disp("Aquí poner función original reemplazando el valor de w");
elseif size_real == 3
    w_final = abs(w_real(3));
    disp("w = ± " + char(abs(w_real(3))) + " = " + "±" + double(abs(w_real(3))));
    disp("Aquí poner función original reemplazando el valor de w");
end

disp("...............");

w_prima = N4_I/((D3_R)^2 + (D3_I)^2);

if((w_real * 10) == w_real)
    w_prima = [0 0 0 0];
else
    w_real = w_real(w_real~=0);
    w_prima = subs(w_prima, w_real);
end

disp("w' = ±" + char(abs(w_prima(2))) + " = " + "±" + double(abs((w_prima(2)))));
disp("...............");

disp("Cruces con el eje real");

disp("(" + char(N4_I) + ") = 0");

w_imag = solve(N4_I);

size_imag = size(w_imag, 1);

disp("..............."); 

if size_imag == 1
    disp("No hay cruces con el eje real");
elseif size_imag == 2
    w_finali = abs(w_imag(2));
    disp("w = ± " + char(abs(w_imag(2))) + " = " + "±" + double(abs(w_imag(2))));
    disp("Aquí poner función original reemplazando el valor de w");
elseif size_imag == 3
    w_finali = abs(w_imag(3));
    disp("w = ± " + char(abs(w_imag(3))) + " = " + "±" + double(abs(w_imag(3))));
    disp("Aquí poner función original reemplazando el valor de w");
end

disp("...............");

w_primai = N4_R/((D3_R)^2 + (D3_I)^2);


if((w_imag * 10) == w_imag)
    w_primai = [0 0 0 0];
else
    w_imag = w_imag(w_imag~=0);
    w_primai = subs(w_primai, w_imag);
end





disp("w' = " + char(w_primai(2)) + " = " + "" + double(w_primai(2)));
disp("...............");
