function [ PerrorTest, ClaseAsign, Y ] = perceptronLineal( Design, Test )
%LINEARMSE Discriminante lineal de mínimos cuadrados
%   Detailed explanation goes here
N_Test = size(Test.P, 2);
perceptron = newff(Design.P, Design.T, [], {'tansig'}, 'traingdx');
perceptron.divideParam.trainRatio = 1;
perceptron.divideParam.valRatio = 0;
perceptron.divideParam.testRatio = 0;
perceptron_entrenado = train(perceptron, Design.P, Design.T);
% Salida del perceptrón
Y = sim(perceptron_entrenado, Test.P);
[~, ClaseAsign] = max(Y);
[~, Test.T] = max(Test.T);
PerrorTest = sum(ClaseAsign ~= Test.T, 2) / N_Test;
end

