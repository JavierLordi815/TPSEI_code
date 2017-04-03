function [PerrorTest]=calcError(ClaseAsign,Test)
%CALCERROR Función que calcula el error entre la clasificación y la clase
%real de los patrones de prueba.
%   ClaseAsign: Clase Asignada a cada patrón de test
%   Test: Clase real de cada patrón de test
%   PerrorTest: Probabilidad de error, obtenida del número de errores entre
%   los dos valores anteriores.
    
    if min(size(ClaseAsign)) > 1
        [~,ClaseAsign]=max(ClaseAsign);
    end
    if min(size(Test)) > 1
        [~, Test] = max(Test);  
    end
    PerrorTest=mean(ClaseAsign~=Test);
end

