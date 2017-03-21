function [ PerrorTest, ClaseAsign, Y ] = linearMSE( Design, Test )
%LINEARMSE Discriminante lineal de mínimos cuadrados
%   Detailed explanation goes here
[C, N_Design] = size(Design.T);
N_Test = size(Test.P, 2);
Q_Design = [ones(1, N_Design); Design.P];
Q_Test = [ones(1, N_Test); Test.P];
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

