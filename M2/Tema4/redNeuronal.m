function [ PerrorTest, ClaseAsign ] = redNeuronal( Train, Test, nNeur, activFuncs, trainingMethod, performFunc, nEpoch )
%REDNEURONAL Funci�n que permite utilizar un perceptr�n multicapa (MLP) para
%clasificar un conjunto de datos
%   Train: Patrones de entrenamiento/training
%   Test: Patrones de test/prueba
%   nNeur: N�mero de neuronas en la capa oculta
%   activationFuncs: Funciones de activaci�n de las diferentes capas
%   trainingMethod: m�todo de entrenamiento utilizado (optimizaci�n)
%   performFunc: funci�n objetivo
%   nEpoch: N�mero de iteraciones
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparaci�n entre etiquetado real y resultado de clasificaci�n
%   ClaseAsign: Clase asignada a cada patr�n por el MLP

switch nargin
    case 2
        MLPi = newff(Train.P, Train.T, 10, {'tansig', 'purelin'}, 'traingdx', '', 'mse');
        MLPi.trainParam.epochs = 1000;
    case 3
        MLPi = newff(Train.P, Train.T, nNeur, {'tansig', 'purelin'}, 'traingdx', '', 'mse');
        MLPi.trainParam.epochs = 1000;
    case 4
        MLPi = newff(Train.P, Train.T, nNeur, activFuncs, 'traingdx', '', 'mse');
        MLPi.trainParam.epochs = 1000;
    case 5
        MLPi = newff(Train.P, Train.T, nNeur, activFuncs, trainingMethod, '', 'mse');
        MLPi.trainParam.epochs = 1000;
    case 6
        MLPi = newff(Train.P, Train.T, nNeur, activFuncs, trainingMethod, '', performFunc);
        MLPi.trainParam.epochs = 1000;
    case 7
        MLPi = newff(Train.P, Train.T, nNeur, activFuncs, trainingMethod, '', performFunc);
        MLPi.trainParam.epochs = nEpoch;
    otherwise
        return;
end
% Divisi�n de los patrones de entrenamiento entre validaci�n y
% entrenamiento para intentar evitar overfitting
MLPi.divideParam.trainRatio = 0.8;
MLPi.divideParam.valRatio = 0.2;
MLPi.divideParam.testRatio = 0;
% Entrenamiento del MLP
MLPt = train(MLPi, Train.P, Train.T);
% Simulaci�n del MLP
Y = sim(MLPt, Test.P);
[~, ClaseAsign] = max(Y);
[~, ClaseReal] = max(Test.T);
PerrorTest = calcError(ClaseAsign, ClaseReal);
end
