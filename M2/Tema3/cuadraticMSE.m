function [ PerrorTest, ClaseAsign ] = cuadraticMSE( Train, Test )
%CUADRATICMSE Funci�n que permite ejecutar el m�todo del discriminante cuadr�tico 
% de m�nimos cuadrados.
%   Train: Patrones de entrenamiento/training
%   Test: Patrones de test/prueba
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparaci�n entre etiquetado real y resultado de clasificaci�n
%   ClaseAsign: Clase asignada a cada patr�n por el m�todo de discriminante
%   cuadr�tico de m�nimos cuadrados

    N_Train = size(Train.T,2);
    [L,N_Test] = size(Test.P);
    % Posibles combinaciones de L caracter�sticas en grupos de 2.
    combinat = nchoosek(1:L, 2);
    cuadratic = Train.P(combinat(:, 1), :) .* Train.P(combinat(:, 2), :);
    Q_Train = [ones(1, N_Train); Train.P; Train.P.^2; cuadratic];
    combinat = nchoosek(1:L, 2);
    cuadratic = Test.P(combinat(:, 1), :) .* Test.P(combinat(:, 2), :);
    Q_Test = [ones(1, N_Test); Test.P; Test.P.^2; cuadratic];
    clear comb cuadratic
    T_Train = Train.T;
    T_Test = Test.T;
    % Calculo V:
    V = T_Train * Q_Train.' * pinv(Q_Train * Q_Train.');
    % Calculo Y:
    Y = V * Q_Test;
    E = Y - T_Test;
    [~, ClaseAsign] = max(Y);
    [~, T_Test] = max(T_Test);
    PerrorTest = calcError(ClaseAsign,T_Test);
end

