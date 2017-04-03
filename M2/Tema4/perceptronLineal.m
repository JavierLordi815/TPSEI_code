function [PerrorTest,ClaseAsign]=perceptronLineal(Train,Test,activFunc, trainingMethod, nEpoch)
%PERCEPTRONLINEAL Funci�n que permite utilizar un perceptr�n lineal
%   Train: Patrones de entrenamiento/training
%   Test: Patrones de test/prueba
%   activFunc: Funci�n de activaci�n
%   trainingMethod: m�todo de entrenamiento utilizado (optimizaci�n)
%   nEpoch: N�mero de iteraciones
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparaci�n entre etiquetado real y resultado de clasificaci�n
%   ClaseAsign: Clase asignada a cada patr�n por el perceptr�n lineal
    
    switch nargin
        case 2
            % Creaci�n de una red neuronal feed forward (entradas a la izquierda)
            perceptron=newff(Train.P,Train.T,[],{'tansig'},'traingdx');
        case 4
            perceptron=newff(Train.P,Train.T,[],{activFunc},trainingMethod);
        case 5
            perceptron=newff(Train.P,Train.T,[],{activFunc},trainingMethod);
            perceptron.trainParam.epochs=nEpoch;
        otherwise
            disp('Error: numero de argumentos invalido')
            return
    end
    % El tercer par�metro est� vacio para construir un perceptron simple
    % Con traingdx, el algoritmo de gradiente controla la constante de
    % aprendizaje
    % Para controlar qu� utiliza como entrenamiento, test y validaci�n,
    % utilizamos par�metros de dentro del perceptr�n. Con un perceptr�n, no es
    % necesario validar ya que es dificil que sobreentrene (como en el caso del
    % discriminante lineal)
    perceptron.divideParam.trainRatio = 1;
    perceptron.divideParam.valRatio = 0;
    perceptron.divideParam.testRatio = 0;
    % Entrenamos el perceptr�n
    perceptron_entrenado = train(perceptron, Train.P, Train.T);
    % Salida del perceptr�n
    Y = sim(perceptron_entrenado, Test.P);
    [~, ClaseAsign] = max(Y);
    [~, Test.T] = max(Test.T);
    PerrorTest=calcError(ClaseAsign,Test.T);
end

