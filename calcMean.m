function [ media ] = calcMean( L, C, design )
%CALCMEAN Calcula la media para cada clase y característica a partir de los 
%datos de diseño (De)
%   N: Número de patrones de diseño
%   L: Número de características
%   C: Número de clases
%   De: Base de datos de diseño (struct con De.P, que contiene los valores
%   de características para cada patrón y De.T, que contiene la etiqueta)
%   media: contiene CxL elementos, que corresponden a la media para cada
%   clase y cada componente.

    media = zeros(C, L);
    for c = 1:C
        media(c, :) = mean(design.P(:, design.T(c, :) == 1), 2);
        % También se podría de la siguiente manera:
        % media(c, :) = mean(De.P(:, find(De.T(c, :))), 2);
    end 

end

