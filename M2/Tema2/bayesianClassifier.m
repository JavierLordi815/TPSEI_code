function [ClaseAsign]=bayesianClassifier(L,C,Test,coefs,aproxType)
%BAYESIANCLASSIFIER Función que aplica uno de los dos métodos de
%clasificación dependiendo de un parámetro de entrada.
%   L:
%   C:
%   Test:
%   coefs:
%   aproxType:
    N_test = size(Test.P, 2);
    ClaseAsign = false(C, N_test);
    if aproxType == false % DLDA
        for n = 1:N_test
            patr = Test.P(:, n); % cojo el patron
            patr=ones(C,1)*patr';
            % Calculo la expresión para cada clase
            crit = sum(coefs(:, 1:L) .* patr + coefs(:, L + (1:L)), 2);
            [~, ind] = min(crit);
            ClaseAsign(ind, n) = true;      
        end
    elseif aproxType == true % DQDA
        for n = 1:N_test
            patr = Test.P(:, n); % cojo el patrón
            patr=ones(C,1)*patr';
            % Calculo la expresión para cada clase
            crit = sum(coefs(:, 1:L) .* patr.^2 + coefs(:, L + (1:L)) .* patr + coefs(:, 2 * L + (1:L)), 2);
            [~, ind] = min(crit);
            ClaseAsign(ind, n) = true;      
        end
    end
    % Pasar ClaseAsign de representación binaria a números enteros
    % correspondientes a la clase:
    [~, ClaseAsign]=max(ClaseAsign);
end

