function classificationRepr(Test,ClaseAsign,charact)
%CLASSIFICATIONREPR Función que permite representar el resultado de la
%clasificación de los patrones de test en contraposición a la clase real a
%la que pertenecen.
%   Test: Conjunto de patrones de test a representar
%   ClaseAsign: Clase asignada a cada patrón
%   charact: vector que contiene los índices de las características a
%   representar. No pueden ser más de 3. Si no se especifica un valor, se
%   representan las dos primeras.

    switch nargin
        case 2 % Representación de las dos primeras características
            plotClassif2D(Test,ClaseAsign,[1 2]);
        case 3
            plotClassif2D(Test,ClaseAsign,charact);
        otherwise
            disp('El numero de argumentos es inválido')
    end
end
