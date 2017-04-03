function [PerrorTest,ClaseAsign]=perceptronLineal(Train,Test,activFunc, trainingMethod, nEpoch)
%PERCEPTRONLINEAL Función que permite utilizar un perceptrón lineal
%   Train: Patrones de entrenamiento/training
%   Test: Patrones de test/prueba
%   activFunc: Función de activación
%   trainingMethod: método de entrenamiento utilizado (optimización)
%   nEpoch: Número de iteraciones
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparación entre etiquetado real y resultado de clasificación
%   ClaseAsign: Clase asignada a cada patrón por el perceptrón lineal
    
    switch nargin
        case 2
            % Creación de una red neuronal feed forward (entradas a la izquierda)
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
    % El tercer parámetro está vacio para construir un perceptron simple
    % Con traingdx, el algoritmo de gradiente controla la constante de
    % aprendizaje
    % Para controlar qué utiliza como entrenamiento, test y validación,
    % utilizamos parámetros de dentro del perceptrón. Con un perceptrón, no es
    % necesario validar ya que es dificil que sobreentrene (como en el caso del
    % discriminante lineal)
    perceptron.divideParam.trainRatio = 1;
    perceptron.divideParam.valRatio = 0;
    perceptron.divideParam.testRatio = 0;
    % Entrenamos el perceptrón
    perceptron_entrenado = train(perceptron, Train.P, Train.T);
    % Salida del perceptrón
    Y = sim(perceptron_entrenado, Test.P);
    [~, ClaseAsign] = max(Y);
    [~, Test.T] = max(Test.T);
    PerrorTest=calcError(ClaseAsign,Test.T);
end

