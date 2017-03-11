function [ varianza ] = calcVar( L, C, design, aprox_type )
%CALCVAR Calcula la varianza para cada clase y característica a partir de los 
%datos de diseño. 
%   N: Número de patrones de diseño
%   L: Número de características
%   C: Número de clases
%   De: Base de datos de diseño (struct con De.P, que contiene los valores
%   de características para cada patrón y De.T, que contiene la etiqueta)
%   varianza: contiene CxL elementos o L elementos, dependiendo de si
%   existe una matriz de covarianza diagonal idéntica para todas las clases
%   (análisis DLDA) o diferente (DQDA)
%   aproxType: variable logical que contiene el tipo de aproximación ('0'
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

