clc; clear; close all;
addpath dataSets\
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
% Valores de k
kMax = 100;
K = 1:kMax;
% Vector de errores
PerrorTest = zeros(1, kMax);
% Seleccionamos unos cuantos al azar
[~, ind] = sort(rand(1, size(Data.P, 2)));
Design.P = Data.P(:, ind(1:floor(end*percTr)));
Design.T = Data.T(:, ind(1:floor(end*percTr)));
Test.P = Data.P(:, ind(floor(end*percTr)+1:end));
Test.T = Data.T(:, ind(floor(end*percTr)+1:end));
%% Ejecuci�n del m�todo
%h = waitbar(0,'Entrenando');
parfor k = K
    [ PerrorTest(k), ~ ] = knn( Design, Test, k );
    %waitbar(k/kMax,h,['Entrenamiento ',num2str(k),' de ',num2str(kMax)])
end
%% 4� Visualizaci�n
figure
plot(K, PerrorTest, 'sqk-')
title('Evoluci�n de la probabilidad de error con el aumento de k')
xlabel('k')
ylabel('P_{error}')

