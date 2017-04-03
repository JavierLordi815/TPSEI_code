function [ClaseAsign]=bayesianClassifier(L,C,Test,coefs,aproxType)
%BAYESIANCLASSIFIER Funci�n que aplica uno de los dos m�todos de
%clasificaci�n dependiendo de un par�metro de entrada.
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
            % Calculo la expresi�n para cada clase
            crit = sum(coefs(:, 1:L) .* patr + coefs(:, L + (1:L)), 2);
            [~, ind] = min(crit);
            ClaseAsign(ind, n) = true;      
        end
    elseif aproxType == true % DQDA
        for n = 1:N_test
            patr = Test.P(:, n); % cojo el patr�n
            patr=ones(C,1)*patr';
            % Calculo la expresi�n para cada clase
            crit = sum(coefs(:, 1:L) .* patr.^2 + coefs(:, L + (1:L)) .* patr + coefs(:, 2 * L + (1:L)), 2);
            [~, ind] = min(crit);
            ClaseAsign(ind, n) = true;      
        end
    end
    % Pasar ClaseAsign de representaci�n binaria a n�meros enteros
    % correspondientes a la clase:
    [~, ClaseAsign]=max(ClaseAsign);
end

