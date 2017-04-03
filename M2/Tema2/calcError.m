function [PerrorTest]=calcError(ClaseAsign,Test)
%CALCERROR Funci�n que calcula el error entre la clasificaci�n y la clase
%real de los patrones de prueba.
%   ClaseAsign: Clase Asignada a cada patr�n de test
%   Test: Clase real de cada patr�n de test
%   PerrorTest: Probabilidad de error, obtenida del n�mero de errores entre
%   los dos valores anteriores.
    
    if min(size(ClaseAsign)) > 1
        [~,ClaseAsign]=max(ClaseAsign);
    end
    if min(size(Test)) > 1
        [~, Test] = max(Test);  
    end
    PerrorTest=mean(ClaseAsign~=Test);
end

