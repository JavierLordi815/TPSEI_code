function [ PerrorTest, ClaseAsign ] = dqda( Design, Test )
%DQDA Función que permite utilizar el método DQDA para clasificar un
%conjunto de datos multiclase y multiparámetro.
%   Design: Conjunto de diseño
%   Test: Conjunto de test
%   PerrorTest: Tasa de error del etiquetado obtenido frente al real
%   ClaseAsign: Clase asignada a cada patrón por el método DLDA

    L = size(Design.P, 1);
    C = size(Design.T, 1);
    % Calculamos la media de cada clase (a partir de diseño/training)
    media = calcMean(L, C, Design);
    % Calculamos la varianza de cada clase
    varianza = calcVar(L, C, Design,true);
    % Opcional: Calcular los coeficientes de las expresiones
    coefs = calcCoefs(C,media, varianza,true);
    %% 3º Test
    % Asignamos la clase a cada patrón
    ClaseAsign=bayesianClassifier(L,C,Test,coefs,true);
    % Medida del error.
    PerrorTest=calcError(ClaseAsign,Test.T);
end

