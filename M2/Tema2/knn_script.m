clc; clear; close all;
addpath dataSets\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR'};
load(dataSets{1});
%% 1º división
% Dividirla base de datos en diseño (training) y test, desordenándolos
% al azar. Establecemos 1000 para diseño y 1000 para test
% Nº de componentes/características
L = size(Data.P, 1);
% Nº de patrones
N = size(Data.P, 2);
% Nº de clases
C = size(Data.T, 1);
% Valores de k
kMax = 40;
K = 1:kMax;
% Vector de errores
PerrorTest = zeros(1, kMax);
% Seleccionamos unos cuantos al azar
[~, ind] = sort(rand(1, size(Data.P, 2)));
Design.P = Data.P(:, ind(1:end/2));
Design.T = Data.T(:, ind(1:end/2));
Test.P = Data.P(:, ind(end/2 + (1:end/2)));
Test.T = Data.T(:, ind(end/2 + (1:end/2)));
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
% Para el mejor caso, visualizar:
[~, bestK] = min(PerrorTest);
[~, ClaseAsign] = knn( Design, Test, bestK);
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

