function [ coefs ] = calcCoefs( C, aprox_type, media, varianza )
%CALCCOEFS Calcula los coeficientes del criterio de decisión
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
%   media: Media
%   varianza: Varianza

    if aprox_type == 0 % DLDA
        for c = 1:C
            coefs(c, :) = [-2 * media(c, :) ./ varianza.', (media(c, :).^2) ./ varianza.'];
        end
    elseif aprox_type == 1 %DQDA
       for c = 1:C
           coefs(c, :) = [1 ./ varianza(c, :), -2 * media(c, :) ./ varianza(c, :), ... 
               (media(c, :).^2) ./ varianza(c, :) + 2 * log(sqrt(varianza(c, :)))];
       end
    end
end

