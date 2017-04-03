function [ PerrorTest, ClaseAsign ] = dqda( Design, Test )
%DQDA Funci�n que permite utilizar el m�todo DQDA para clasificar un
%conjunto de datos multiclase y multipar�metro.
%   Design: Conjunto de dise�o
%   Test: Conjunto de test
%   PerrorTest: Tasa de error del etiquetado obtenido frente al real
%   ClaseAsign: Clase asignada a cada patr�n por el m�todo DLDA

    L = size(Design.P, 1);
    C = size(Design.T, 1);
    % Calculamos la media de cada clase (a partir de dise�o/training)
    media = calcMean(L, C, Design);
    % Calculamos la varianza de cada clase
    varianza = calcVar(L, C, Design,true);
    % Opcional: Calcular los coeficientes de las expresiones
    coefs = calcCoefs(C,media, varianza,true);
    %% 3� Test
    % Asignamos la clase a cada patr�n
    ClaseAsign=bayesianClassifier(L,C,Test,coefs,true);
    % Medida del error.
    PerrorTest=calcError(ClaseAsign,Test.T);
end

