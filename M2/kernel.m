function [ PerrorTest, ClaseAsign ] = kernel( Design, Test, h )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Nº de componentes/características
L = size(Design.P, 1);
% Nº de clases
C = size(Design.T, 1);
% Tamaño base de datos de diseño y test
N_Design = size(Design.P, 2);
N_Test = size(Test.P, 2);
% Media y desviación estandar de diseño
m = mean(Design.P, 2);
s = std(Design.P, [], 2);
% Normalización de características en base de datos de diseño
Design.P = Design.P - m * ones(1, N_Design);
Design.P = Design.P ./ (s * ones(1, N_Design));
% Normalización de características en base de datos de test
Test.P = (Test.P - m * ones(1, N_Test));
Test.P = (Test.P ./ (s * ones(1, N_Test)));
% Transformamos las etiquetas a valor numérico (una sola fila)
[~, Design.T] = max(Design.T);
[~, Test.T] = max(Test.T);
% Probabilidad a priori de cada clase
prior = nan(N_Test, C);
for i = 1:C
    prior(i) = size(Design.T(Design.T == i), 2);
end
crit = nan(N_Test, C);
% Procedemos con la clasificación:
for c = 1:C
    a = dist(Test.P.', Design.P(:, Design.T == c)).^2/h^2;
    b = exp(-1/2*a);
    crit(:,c)=prior(c)*1/N_Test*sum(1/((2*pi)^(L/2)*h^L)*b, 2);
end
[~, ClaseAsign] = max(crit, [], 2);      
PerrorTest = sum(ClaseAsign.' ~= Test.T, 2) / N_Test;
end

