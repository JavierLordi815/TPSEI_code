function [ PerrorTest, ClaseAsign ] = knn( Design, Test, k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    TestSize = size(Test.P);
    % Calcular la distancia de cada uno de los patrones de entrenamiento a cada
    % uno de los patrones de test:
    D = dist(Design.P.', Test.P);
    % Calcular las k m�s cercanas:
    [~, ind] = sort(D);
    % Coger los k vecinos m�s cercanos (filas) a cada patr�n (columnas):
    knns = ind(1:k, :);
    % Borramos D y b, al ocupar bastante memoria:
    clear D b;
    % Busco la clase de cada uno en el conjunto de dise�o
    % Se puede transformar la clase a entero de la siguiente forma (para as�
    % poder utilizar la moda):
    [~, Design.T] = max(Design.T);
    [~, Test.T] = max(Test.T);
    knnsClassif = Design.T(knns);
    ClaseAsign = zeros(1, TestSize(2));
    % Calculo la clase predominante entre los vecinos (m) y si hay empate
    % (c) en cada patr�n
    [m, ~, c] = mode(knnsClassif, 1);
    % Posibilidad de hacerlo con hist y sumando 0.5 para deshacer empates a
    % la clase del vecino m�s pr�ximo
    if k ~= 1
        for i = 1:TestSize(2)
            if size(c{i}, 1) > 1 % Si hay empate
                ClaseAsign(i) = knnsClassif(1, i); % Asigna la clase m�s cercana
            else
                ClaseAsign(i) = m(i); % Se asigna el vecino con m�s patrones cercanos
            end
        end
    elseif k == 1
        ClaseAsign = m;
    end
    % Se peude sacar el empate con mode --> mala idea
    PerrorTest = sum(ClaseAsign ~= Test.T, 2) / size(Test.T, 2);
end

