function [varianza]=calcVar(L,C,Train,aproxType)
%CALCVAR Calcula la varianza para cada clase y característica a partir de los 
%datos de diseño. 
%   L: Número de características
%   C: Número de clases
%   Train: Base de datos de diseño (struct con Train.P, que contiene los valores
%   de características para cada patrón y Train.T, que contiene la etiqueta)
%   varianza: contiene L elementos en el caso DLDA, que corresponde a la
%   varianza de cada característica. En DQDA, contiene CxL elementos,
%   correspondientes a la varianza de cada característica para los patrones
%   de cada clase.
%   aproxType: variable logical que contiene el tipo de aproximación (false
%   equivale a 'DLDA' y true a 'DQDA')

    if aproxType==false % DLDA
        varianza=var(Train.P,[],2);
    elseif aproxType==true % DQDA
        varianza=zeros(C,L);
        for c=1:C
            varianza(c,:)=var(Train.P(:,Train.T(c, :)==1),[],2);
        end
    end
end

