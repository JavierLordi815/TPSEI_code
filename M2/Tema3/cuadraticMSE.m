function [ PerrorTest, ClaseAsign ] = cuadraticMSE( Design, Test )
%LINEARMSE Discriminante lineal de mínimos cuadrados
%   Detailed explanation goes here
[C, N_Design] = size(Design.T);
[L, N_Test] = size(Test.P);
% Posibles combinaciones de L características en grupos de 2.
combinat = nchoosek(1:L, 2);
cuadratic = Design.P(combinat(:, 1), :) .* Design.P(combinat(:, 2), :);
Q_Design = [ones(1, N_Design); Design.P; Design.P.^2; cuadratic];
combinat = nchoosek(1:L, 2);
cuadratic = Test.P(combinat(:, 1), :) .* Test.P(combinat(:, 2), :);
Q_Test = [ones(1, N_Test); Test.P; Test.P.^2; cuadratic];
clear comb cuadratic
T_Design = Design.T;
T_Test = Test.T;
% Calculo V:
V = T_Design * Q_Design.' * pinv(Q_Design * Q_Design.');
% Calculo Y:
Y = V * Q_Test;
E = Y - T_Test;
[~, ClaseAsign] = max(Y);
[~, T_Test] = max(T_Test);
PerrorTest = sum(ClaseAsign ~= T_Test, 2) / N_Test;
end

