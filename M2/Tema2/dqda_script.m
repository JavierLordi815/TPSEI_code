clc; clear; close all;
addpath dataSets\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR'};
load(dataSets{2});
%% 1� divisi�n
% Dividirla base de datos en dise�o (training) y test, desorden�ndolos
% al azar. Establecemos 1000 para dise�o y 1000 para test
% N� de componentes/caracter�sticas
L = size(Data.P, 1);
% N� de patrones
N = size(Data.P, 2);
% N� de clases
C = size(Data.T, 1);
% Orden aleatorio de divisi�n de la base de datos
rand_order = randperm(N, N);
% Tambi�n se puede hacer como:
% [~, ind] = sort(rand(1, size(Data.P, 2)));
% Definici�n de base de datos de dise�o
N_design = floor(N/2);
N_test = N_design;
Design.P = Data.P(:, rand_order(1:N_design));
Design.T = Data.T(:, rand_order(1:N_design));
% Definici�n de base de datos de test
Test.P = Data.P(:, rand_order(N_test + 1:end)); 
Test.T = Data.T(:, rand_order(N_test + 1:end));
%% Ejecuci�n del m�todo
[ PerrorTest, ClaseAsign ] = dqda( Design, Test );
%% 4� Visualizaci�n
figure
plot(Test.P(1, logical(Test.T(1, :))), Test.P(2, logical(Test.T(1, :))), 'r.')
hold on
plot(Test.P(1, logical(Test.T(2, :))), Test.P(2, logical(Test.T(2, :))), 'b.')
title('Etiquetado real')
figure
plot(Test.P(1, ClaseAsign(1, :)), Test.P(2, ClaseAsign(1, :)), 'r.')
hold on
plot(Test.P(1, ClaseAsign(2, :)), Test.P(2, ClaseAsign(2, :)), 'b.')
title('Etiquetado clasificador');
