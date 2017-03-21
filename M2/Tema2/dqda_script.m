clc; clear; close all;
addpath dataSets\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR'};
load(dataSets{2});
%% 1º división
% Dividirla base de datos en diseño (training) y test, desordenándolos
% al azar. Establecemos 1000 para diseño y 1000 para test
% Nº de componentes/características
L = size(Data.P, 1);
% Nº de patrones
N = size(Data.P, 2);
% Nº de clases
C = size(Data.T, 1);
% Orden aleatorio de división de la base de datos
rand_order = randperm(N, N);
% También se puede hacer como:
% [~, ind] = sort(rand(1, size(Data.P, 2)));
% Definición de base de datos de diseño
N_design = floor(N/2);
N_test = N_design;
Design.P = Data.P(:, rand_order(1:N_design));
Design.T = Data.T(:, rand_order(1:N_design));
% Definición de base de datos de test
Test.P = Data.P(:, rand_order(N_test + 1:end)); 
Test.T = Data.T(:, rand_order(N_test + 1:end));
%% Ejecución del método
[ PerrorTest, ClaseAsign ] = dqda( Design, Test );
%% 4º Visualización
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
