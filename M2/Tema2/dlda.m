function [PerrorTest,ClaseAsign]=dlda(Train,Test)
%DLDA Función que permite utilizar el método DLDA para clasificar un
%conjunto de datos multiclase y multiparámetro.
%   Train: Conjunto de diseño/entrenamiento (training)
%   Test: Conjunto de prueba (test)
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparación entre etiquetado real y resultado de clasificación
%   ClaseAsign: Clase asignada a cada patrón por el método DLDA

    % Calculamos la media de cada clase (a partir de diseño/training)
    L=size(Train.P,1);
    C=size(Train.T,1);
    media=calcMean(L,C,Train);
    % Calculamos la varianza de cada clase
    varianza=calcVar(L,C,Train,false);
    % Opcional: Calcular los coeficientes de las expresiones
    coefs=calcCoefs(C,media,varianza,false);
    %% 3º Test
    % Asignamos clases a cada patrón de test.
    ClaseAsign=bayesianClassifier(L,C,Test,coefs,false);
    % Medida del error.
    PerrorTest = calcError(ClaseAsign,Test.T);
end

