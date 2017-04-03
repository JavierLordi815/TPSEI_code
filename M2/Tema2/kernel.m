function [PerrorTest,ClaseAsign]=kernel(Train,Test,h)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% N� de componentes/caracter�sticas
L = size(Train.P, 1);
% N� de clases
C = size(Train.T, 1);
% Tama�o base de datos de dise�o y test
N_Design = size(Train.P, 2);
N_Test = size(Test.P, 2);
% Media y desviaci�n estandar de dise�o
m = mean(Train.P, 2);
s = std(Train.P, [], 2);
% Normalizaci�n de caracter�sticas en base de datos de dise�o
Train.P = Train.P - m * ones(1, N_Design);
Train.P = Train.P ./ (s * ones(1, N_Design));
% Normalizaci�n de caracter�sticas en base de datos de test
Test.P = (Test.P - m * ones(1, N_Test));
Test.P = (Test.P ./ (s * ones(1, N_Test)));
% Transformamos las etiquetas a valor num�rico (una sola fila)
[~, Train.T] = max(Train.T);
[~, Test.T] = max(Test.T);
% Probabilidad a priori de cada clase
prior = nan(N_Test, C);
for i = 1:C
    prior(i) = size(Train.T(Train.T == i), 2);
end
crit = nan(N_Test, C);
% Procedemos con la clasificaci�n:
for c = 1:C
    a = dist(Test.P.', Train.P(:, Train.T == c)).^2/h^2;
    b = exp(-1/2*a);
    crit(:,c)=prior(c)*1/N_Test*sum(1/((2*pi)^(L/2)*h^L)*b, 2);
end
[~, ClaseAsign] = (max(crit, [], 2));
ClaseAsign = ClaseAsign.';
PerrorTest = calcError(ClaseAsign,Test.T);
end

