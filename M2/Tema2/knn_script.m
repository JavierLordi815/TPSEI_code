clc; clear; close all;
addpath dataSets\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR', 'glassData2', 'Datosvehiculos'};
load(dataSets{4});
%% 1º división
% Porcentaje de datos para diseño/training
percTr = 0.8;
% Nº de componentes/características
L = size(Data.P, 1);
% Nº de patrones
N = size(Data.P, 2);
% Nº de clases
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
%% Ejecución del método
%h = waitbar(0,'Entrenando');
parfor k = K
    [ PerrorTest(k), ~ ] = knn( Design, Test, k );
    %waitbar(k/kMax,h,['Entrenamiento ',num2str(k),' de ',num2str(kMax)])
end
%% 4º Visualización
figure
plot(K, PerrorTest, 'sqk-')
title('Evolución de la probabilidad de error con el aumento de k')
xlabel('k')
ylabel('P_{error}')

