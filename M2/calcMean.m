function [ media ] = calcMean( L, C, design )
%CALCMEAN Calcula la media para cada clase y caracter�stica a partir de los 
%datos de dise�o (De)
%   N: N�mero de patrones de dise�o
%   L: N�mero de caracter�sticas
%   C: N�mero de clases
%   De: Base de datos de dise�o (struct con De.P, que contiene los valores
%   de caracter�sticas para cada patr�n y De.T, que contiene la etiqueta)
%   media: contiene CxL elementos, que corresponden a la media para cada
%   clase y cada componente.

    media = zeros(C, L);
    for c = 1:C
        media(c, :) = mean(design.P(:, design.T(c, :) == 1), 2);
        % Tambi�n se podr�a de la siguiente manera:
        % media(c, :) = mean(De.P(:, find(De.T(c, :))), 2);
    end 

end

