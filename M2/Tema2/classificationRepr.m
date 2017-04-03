function classificationRepr(Test,ClaseAsign,charact)
%CLASSIFICATIONREPR Funci�n que permite representar el resultado de la
%clasificaci�n de los patrones de test en contraposici�n a la clase real a
%la que pertenecen.
%   Test: Conjunto de patrones de test a representar
%   ClaseAsign: Clase asignada a cada patr�n
%   charact: vector que contiene los �ndices de las caracter�sticas a
%   representar. No pueden ser m�s de 3. Si no se especifica un valor, se
%   representan las dos primeras.

    switch nargin
        case 2 % Representaci�n de las dos primeras caracter�sticas
            plotClassif2D(Test,ClaseAsign,[1 2]);
        case 3
            plotClassif2D(Test,ClaseAsign,charact);
        otherwise
            disp('El numero de argumentos es inv�lido')
    end
end
