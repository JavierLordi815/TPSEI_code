clc; clear; close all;
addpath ..\dataSets\
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
h = 0.01:0.01:1;
% Vector de errores
PerrorTest = zeros(1, length(h));
% Seleccionamos unos cuantos al azar
[~, ind] = sort(rand(1, size(Data.P, 2)));
Design.P = Data.P(:, ind(1:floor(end*percTr)));
Design.T = Data.T(:, ind(1:floor(end*percTr)));
Test.P = Data.P(:, ind(floor(end*percTr)+1:end));
Test.T = Data.T(:, ind(floor(end*percTr)+1:end));
%% Ejecución del método
parfor i = 1:length(h)
    [ PerrorTest(i), ~ ] = kernel( Design, Test, h(i) );
end
% Obtengo la clase asignada pr el clasificador con menor error
[~, ind] = min(PerrorTest);
[~, ClaseAsign] = kernel( Design, Test, h(ind));
%% 4º Visualización
figure
plot(h, PerrorTest, 'sqk-')
title('Evolución de la probabilidad de error con el aumento de h')
xlabel('h')
ylabel('P_{error}')
