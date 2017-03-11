function [ PerrorTest, ClaseAsign ] = dqda( Design, Test )
%DQDA Funci�n que permite utilizar el m�todo DQDA para clasificar un
%conjunto de datos multiclase y multipar�metro.
%   Design: Conjunto de dise�o
%   Test: Conjunto de test
%   PerrorTest: Tasa de error del etiquetado obtenido frente al real
%   ClaseAsign: Clase asignada a cada patr�n por el m�todo DLDA

    %% 2� Dise�o
    % Calculamos la media de cada clase (a partir de dise�o/training)
    % Tipo de aproximaci�n ('0' equivale a 'DLDA' y '1' a 'DQDA')
    aprox_type = true;
    L = size(Design.P, 1);
    C = size(Design.T, 1);
    media = calcMean(L, C, Design);
    % Calculamos la varianza de cada clase
    varianza = calcVar(L, C, Design, aprox_type);
    % Opcional: Calcular los coeficientes de las expresiones
    coefs = calcCoefs(C, aprox_type, media, varianza);
    %% 3� Test
    % Asignamos clases a cada persona de test.
    ClaseAsign = bayesianClassifier(L, C, Test, aprox_type, coefs);
    % Medir el error.
    PerrorTest = calcError(ClaseAsign, Test.T);
end

