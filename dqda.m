function [ PerrorTest, ClaseAsign ] = dqda( Design, Test )
%DQDA Función que permite utilizar el método DQDA para clasificar un
%conjunto de datos multiclase y multiparámetro.
%   Design: Conjunto de diseño
%   Test: Conjunto de test
%   PerrorTest: Tasa de error del etiquetado obtenido frente al real
%   ClaseAsign: Clase asignada a cada patrón por el método DLDA

    %% 2º Diseño
    % Calculamos la media de cada clase (a partir de diseño/training)
    % Tipo de aproximación ('0' equivale a 'DLDA' y '1' a 'DQDA')
    aprox_type = true;
    L = size(Design.P, 1);
    C = size(Design.T, 1);
    media = calcMean(L, C, Design);
    % Calculamos la varianza de cada clase
    varianza = calcVar(L, C, Design, aprox_type);
    % Opcional: Calcular los coeficientes de las expresiones
    coefs = calcCoefs(C, aprox_type, media, varianza);
    %% 3º Test
    % Asignamos clases a cada persona de test.
    ClaseAsign = bayesianClassifier(L, C, Test, aprox_type, coefs);
    % Medir el error.
    PerrorTest = calcError(ClaseAsign, Test.T);
end

