function [varianza]=calcVar(L,C,Train,aproxType)
%CALCVAR Calcula la varianza para cada clase y caracter�stica a partir de los 
%datos de dise�o. 
%   L: N�mero de caracter�sticas
%   C: N�mero de clases
%   Train: Base de datos de dise�o (struct con Train.P, que contiene los valores
%   de caracter�sticas para cada patr�n y Train.T, que contiene la etiqueta)
%   varianza: contiene L elementos en el caso DLDA, que corresponde a la
%   varianza de cada caracter�stica. En DQDA, contiene CxL elementos,
%   correspondientes a la varianza de cada caracter�stica para los patrones
%   de cada clase.
%   aproxType: variable logical que contiene el tipo de aproximaci�n (false
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

