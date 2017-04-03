clc; clear; close all;
addpath ..\dataSets\
addpath ..\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR', 'glassData2', 'Datosvehiculos'};
load(dataSets{4});
%% 1� divisi�n
% Porcentaje de datos para dise�o/training
percTr = 0.8;
% N� de componentes/caracter�sticas
L = size(Data.P, 1);
% N� de patrones
N = size(Data.P, 2);
% N� de clases
C = size(Data.T, 1);
% Orden aleatorio de divisi�n de la base de datos
[~, ind] = sort(rand(1, size(Data.P, 2)));
Train.P = Data.P(:, ind(1:floor(end*percTr)));
Train.T = Data.T(:, ind(1:floor(end*percTr)));
Test.P = Data.P(:, ind(floor(end*percTr)+1:end));
Test.T = Data.T(:, ind(floor(end*percTr)+1:end));
E = inf;
numEjec = 20;
for i = 1:numEjec
%% Ejecuci�n del m�todo
[ PerrorTest, ClaseAsign ] = redNeuronal( Train, Test);
    if(PerrorTest < E)
        E = PerrorTest;
    end
end


