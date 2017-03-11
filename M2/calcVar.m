function [ varianza ] = calcVar( L, C, design, aprox_type )
%CALCVAR Calcula la varianza para cada clase y caracter�stica a partir de los 
%datos de dise�o. 
%   N: N�mero de patrones de dise�o
%   L: N�mero de caracter�sticas
%   C: N�mero de clases
%   De: Base de datos de dise�o (struct con De.P, que contiene los valores
%   de caracter�sticas para cada patr�n y De.T, que contiene la etiqueta)
%   varianza: contiene CxL elementos o L elementos, dependiendo de si
%   existe una matriz de covarianza diagonal id�ntica para todas las clases
%   (an�lisis DLDA) o diferente (DQDA)
%   aproxType: variable logical que contiene el tipo de aproximaci�n ('0'
%   equivale a 'DLDA' y '1' a 'DQDA')

% Los for reservan memoria para el vector grande. El while funciona igual
% que en C
    if aprox_type == 0 % DLDA
        varianza = var(design.P, [], 2);
    else % DQDA
        varianza = zeros(C, L);
        for c = 1:C
            varianza(c, :) = var(design.P(:, design.T(c, :) == 1), [], 2);
        end
    end
end

