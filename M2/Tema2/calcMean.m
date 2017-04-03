function [media]=calcMean(L,C,Train)
%CALCMEAN Calcula la media para cada clase y caracter�stica a partir de los 
%datos de entrenamiento/dise�o
%   L: N�mero de caracter�sticas
%   C: N�mero de clases
%   Train: Base de datos de dise�o (struct con Train.P, que contiene los valores
%   de caracter�sticas para cada patr�n y Train.T, que contiene la etiqueta)
%   media: contiene CxL elementos, que corresponden a la media para cada
%   clase y cada componente.
    media=zeros(C, L);
    for c=1:C
        media(c,:)=mean(Train.P(:,Train.T(c,:)==1),2);
    end 
end

