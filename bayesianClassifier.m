function [ test_new ] = bayesianClassifier( L, C, test, aprox_type, coefs )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
N_test = size(test.P, 2);
test_new = false(C, N_test);
if aprox_type == 0 % DLDA
    for n = 1:N_test
        patr = test.P(:, n); % cojo el patron
        patr=ones(C,1)*patr';
        % Calculo la expresión para cada clase
        crit = sum(coefs(:, 1:L) .* patr + coefs(:, L + (1:L)), 2);
        [~, ind] = min(crit);
        test_new(ind, n) = true;      
    end
elseif aprox_type == 1 % DQDA
    for n = 1:N_test
        patr = test.P(:, n); % cojo el patrón
        patr=ones(C,1)*patr';
        % Calculo la expresión para cada clase
        crit = sum(coefs(:, 1:L) .* patr.^2 + coefs(:, L + (1:L)) .* patr + coefs(:, 2 * L + (1:L)), 2);
        [~, ind] = min(crit);
        test_new(ind, n) = true;      
    end
end
end

