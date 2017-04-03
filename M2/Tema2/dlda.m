function [PerrorTest,ClaseAsign]=dlda(Train,Test)
%DLDA Funci�n que permite utilizar el m�todo DLDA para clasificar un
%conjunto de datos multiclase y multipar�metro.
%   Train: Conjunto de dise�o/entrenamiento (training)
%   Test: Conjunto de prueba (test)
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparaci�n entre etiquetado real y resultado de clasificaci�n
%   ClaseAsign: Clase asignada a cada patr�n por el m�todo DLDA

    % Calculamos la media de cada clase (a partir de dise�o/training)
    L=size(Train.P,1);
    C=size(Train.T,1);
    media=calcMean(L,C,Train);
    % Calculamos la varianza de cada clase
    varianza=calcVar(L,C,Train,false);
    % Opcional: Calcular los coeficientes de las expresiones
    coefs=calcCoefs(C,media,varianza,false);
    %% 3� Test
    % Asignamos clases a cada patr�n de test.
    ClaseAsign=bayesianClassifier(L,C,Test,coefs,false);
    % Medida del error.
    PerrorTest = calcError(ClaseAsign,Test.T);
end

