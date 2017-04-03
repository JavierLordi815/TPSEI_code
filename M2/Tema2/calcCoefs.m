function [coefs]=calcCoefs(C,media,varianza,aproxType)
%CALCCOEFS Calcula los coeficientes del criterio de decisi�n
%   C: N�mero de clases
%   media: contiene CxL elementos, que corresponden a la media para cada
%   clase y cada componente.
%   varianza: contiene L elementos en el caso DLDA, que corresponde a la
%   varianza de cada caracter�stica. En DQDA, contiene CxL elementos,
%   correspondientes a la varianza de cada caracter�stica para los patrones
%   de cada clase.
%   aproxType: variable logical que contiene el tipo de aproximaci�n (false
%   equivale a 'DLDA' y true a 'DQDA')
%   coefs: Coeficientes de cada uno de los distintos m�todos

    if aproxType == false % DLDA
        for c = 1:C
            coefs(c, :) = [-2 * media(c, :) ./ varianza.', (media(c, :).^2) ./ varianza.'];
        end
    elseif aproxType == true %DQDA
       for c = 1:C
           coefs(c, :) = [1 ./ varianza(c, :), -2 * media(c, :) ./ varianza(c, :), ... 
               (media(c, :).^2) ./ varianza(c, :) + 2 * log(sqrt(varianza(c, :)))];
       end
    end
end

