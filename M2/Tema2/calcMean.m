function [media]=calcMean(L,C,Train)
%CALCMEAN Calcula la media para cada clase y característica a partir de los 
%datos de entrenamiento/diseño
%   L: Número de características
%   C: Número de clases
%   Train: Base de datos de diseño (struct con Train.P, que contiene los valores
%   de características para cada patrón y Train.T, que contiene la etiqueta)
%   media: contiene CxL elementos, que corresponden a la media para cada
%   clase y cada componente.
    media=zeros(C, L);
    for c=1:C
        media(c,:)=mean(Train.P(:,Train.T(c,:)==1),2);
    end 
end

