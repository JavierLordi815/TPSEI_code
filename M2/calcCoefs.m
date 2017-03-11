function [ coefs ] = calcCoefs( C, aprox_type, media, varianza )
%CALCCOEFS Calcula los coeficientes del criterio de decisi�n
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

