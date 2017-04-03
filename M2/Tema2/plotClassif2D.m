function plotClassif2D(Test,ClaseAsign, charact)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    if length(charact) == 2
        figure
            for i=1:size(Test.T,1)
                subplot(1,2,1); % Etiquetado real
                plot(Test.P(charact(1), logical(Test.T(i, :))),...
                     Test.P(charact(2), logical(Test.T(i, :))), '.');
                hold on
                title('Etiquetado real')
                subplot(1,2,2); % Etiquetado tras clasificación
                plot(Test.P(charact(1), ClaseAsign==i),...
                     Test.P(charact(2), ClaseAsign==i), '.');
                hold on
                title('Etiquetado clasificador')
            end
    else
        disp('Error, plotClassif2D solo puede representar en 2D')
    end
end

