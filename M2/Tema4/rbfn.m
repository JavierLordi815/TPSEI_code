function [ PerrorTest, ClaseAsign ] = rbfn(Train, Test, nCentros, displayMode, maxIter)
%RBFN Funci�n que permite utilizar una red de funciones de base radial para
%clasificar un conjunto de datos
%   Train: Patrones de entrenamiento/training
%   Test: Patrones de test/prueba
%   nCentros: N�mero de centros a utilizar
%   displayMode: Opci�n elegida como salida por pantalla
%   maxIter: N� m�ximo de iteraciones
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparaci�n entre etiquetado real y resultado de clasificaci�n
%   ClaseAsign: Clase asignada a cada patr�n por la RBFN

% N� de clases
C = size(Train.T, 1);
% Tama�o base de datos de dise�o y test
N_Train = size(Train.P, 2);
N_Test = size(Test.P, 2);
% Media y desviaci�n estandar de dise�o
m = mean(Train.P, 2);
s = std(Train.P, [], 2);
% Normalizaci�n de caracter�sticas en base de datos de dise�o
Train.P = Train.P - m * ones(1, N_Train);
Train.P = Train.P ./ (s * ones(1, N_Train));
% Normalizaci�n de caracter�sticas en base de datos de test
Test.P = (Test.P - m * ones(1, N_Test));
Test.P = (Test.P ./ (s * ones(1, N_Test)));
%C�lculo de los centros
switch nargin
    case 2
        [~,Centros]=kmeans(Train.P',31,'Maxiter',1000,'Display', 'off');
    case 3
        [~,Centros]=kmeans(Train.P',nCentros,'Maxiter',1000,'Display', 'off');
    case 4
        [~,Centros]=kmeans(Train.P',nCentros,'Maxiter',1000,'Display', displayMode);
    case 5
        [~,Centros]=kmeans(Train.P',nCentros,'Maxiter',maxIter,'Display', displayMode);
    otherwise
        return
end
    % C�lculo de la constante de suavizado
    D=dist(Centros,Centros');
    h=sqrt(mean(mean(D.^2)));
    % C�lculo de los pesos de salida
    D=dist(Centros,Train.P);
    P=exp(-0.5/h*D.^2);
    Q=[P;ones(1,size(Train.P,2))];
    W=Train.T*Q'*pinv(Q*Q');
    % Simulaci�n de la RBFN
    D=dist(Centros,Test.P);
    P=exp(-0.5/h*D.^2);
    Q=[P;ones(1,size(Test.P,2))];
    Y=W*Q;
    % Medida del error (C=2)
    if C == 2
        ClaseAsign=Y>0.5;
        PerrorTest=calcError(ClaseAsign,Test.T);
    elseif C > 2
        % Medida del error (C>2)
        [~,Test.T]=max(Test.T);
        [~,ClaseAsign]=max(Y);
        PerrorTest=calcError(ClaseAsign,Test.T);
    end
end

