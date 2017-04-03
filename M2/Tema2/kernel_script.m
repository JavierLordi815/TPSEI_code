clc; clear; close all;
addpath ..\dataSets\
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
h = 0.01:0.01:1;
% Vector de errores
PerrorTest = zeros(1, length(h));
% Seleccionamos unos cuantos al azar
[~, ind] = sort(rand(1, size(Data.P, 2)));
Design.P = Data.P(:, ind(1:floor(end*percTr)));
Design.T = Data.T(:, ind(1:floor(end*percTr)));
Test.P = Data.P(:, ind(floor(end*percTr)+1:end));
Test.T = Data.T(:, ind(floor(end*percTr)+1:end));
%% Ejecuci�n del m�todo
parfor i = 1:length(h)
    [ PerrorTest(i), ~ ] = kernel( Design, Test, h(i) );
end
% Obtengo la clase asignada pr el clasificador con menor error
[~, ind] = min(PerrorTest);
[~, ClaseAsign] = kernel( Design, Test, h(ind));
%% 4� Visualizaci�n
figure
plot(h, PerrorTest, 'sqk-')
title('Evoluci�n de la probabilidad de error con el aumento de h')
xlabel('h')
ylabel('P_{error}')
