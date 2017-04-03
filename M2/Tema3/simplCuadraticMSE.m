function [PerrorTest,ClaseAsign]=simplCuadraticMSE(Train,Test)
%SIMPLCUADRATICMSE Funci�n que permite ejecutar el m�todo del discriminante cuadr�tico 
% simplificado de m�nimos cuadrados.
%   Train: Patrones de entrenamiento/training
%   Test: Patrones de test/prueba
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparaci�n entre etiquetado real y resultado de clasificaci�n
%   ClaseAsign: Clase asignada a cada patr�n por el m�todo de discriminante
%   cuadr�tico simplificado de m�nimos cuadrados
    N_Train=size(Train.T,2);
    N_Test=size(Test.P,2);
    Q_Train=[ones(1,N_Train);Train.P;Train.P.^2];
    Q_Test=[ones(1,N_Test);Test.P;Test.P.^2];
    T_Train=Train.T;
    T_Test=Test.T;
    % Calculo V:
    V=T_Train*Q_Train.'*pinv(Q_Train*Q_Train.');
    % Calculo Y:
    Y=V*Q_Test;
    E=Y-T_Test;
    [~,ClaseAsign]=max(Y);
    [~,T_Test]=max(T_Test);
    PerrorTest=calcError(ClaseAsign,T_Test);
end

