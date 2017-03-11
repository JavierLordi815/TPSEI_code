clc; clear; close all;
addpath dataSets\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR'};
load(dataSets{1});
%% 1� divisi�n
% Dividirla base de datos en dise�o (training) y test, desorden�ndolos
% al azar. Establecemos 1000 para dise�o y 1000 para test
% N� de componentes/caracter�sticas
L = size(Data.P, 1);
% N� de patrones
N = size(Data.P, 2);
% N� de clases
C = size(Data.T, 1);
% Valores de k
h = 0.07;
% Vector de errores
% PerrorTest = zeros(1, hMax);
% Seleccionamos unos cuantos al azar
[~, ind] = sort(rand(1, size(Data.P, 2)));
Design.P = Data.P(:, ind(1:end/2));
Design.T = Data.T(:, ind(1:end/2));
Test.P = Data.P(:, ind(end/2 + (1:end/2)));
Test.T = Data.T(:, ind(end/2 + (1:end/2)));
%% Ejecuci�n del m�todo
[ PerrorTest, ClaseAsign ] = kernel( Design, Test, h );
%% 4� Visualizaci�n
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

