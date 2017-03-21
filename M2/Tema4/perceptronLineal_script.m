clc; clear; close all;
addpath ..\dataSets\
addpath ..\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR'};
load(dataSets{3});
%% 1� divisi�n
% Dividirla base de datos en dise�o (training) y test, desorden�ndolos
% al azar. Establecemos 1000 para dise�o y 1000 para test
% N� de componentes/caracter�sticas
L = size(Data.P, 1);
% N� de patrones
N = size(Data.P, 2);
% N� de clases
C = size(Data.T, 1);
% Seleccionamos unos cuantos al azar
[~, ind] = sort(rand(1, size(Data.P, 2)));
Design.P = Data.P(:, ind(1:end/2));
Design.T = Data.T(:, ind(1:end/2));
Test.P = Data.P(:, ind(end/2 + (1:end/2)));
Test.T = Data.T(:, ind(end/2 + (1:end/2)));
%% Ejecuci�n del m�todo
[ PerrorTest, ClaseAsign, Y ] = perceptronLineal( Design, Test );
%% 4� Visualizaci�n
% figure
% stem3(Data.P(1, 1:end/2), Data.P(2, 1:end/2), Data.T(1, 1:end/2), 'r');
% hold on
% stem3(Data.P(1, end/2+1:end), Data.P(2, end/2+1:end), Data.T(1, end/2+1:end), 'b');
% plot3(Test.P(1, :), Test.P(2, :), Y(1, :), 'ok')
figure
plot(Test.P(1, logical(Test.T(1, :))), Test.P(2, logical(Test.T(1, :))), 'r.')
hold on
plot(Test.P(1, logical(Test.T(2, :))), Test.P(2, logical(Test.T(2, :))), 'b.')
title('Etiquetado real')
figure
plot(Test.P(1, ClaseAsign == 1), Test.P(2, ClaseAsign == 1), 'r.')
hold on
plot(Test.P(1, ClaseAsign == 2), Test.P(2, ClaseAsign == 2), 'b.')
title('Etiquetado clasificador');

