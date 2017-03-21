% Funciones para utilizar 
% newff crea una red neuronal feed forward (entradas a la izquierda)
perceptron = newff(Design.P, Design.T(1, :), [], {'tansig'}, 'trainlm');
% El tercer parámetro está vacio para un perceptron simple
% COn traingdx, el algoritmo de gradiente controla la constante de
% aprendizaje
% Para controlar qué utiliza como entrenamiento, test y validación,
% utilizamos parámetros de dentro del perceptron. Con un perceptrón, no es
% necesario validar ya que es dificil que sobreentrene (como en el caso del
% discriminante lineal)
perceptron.divideParam.trainRatio = 1;
perceptron.divideParam.valRatio = 0;
perceptron.divideParam.testRatio = 0;
% Para entrenar al perceptron, se hace lo siguiente:
perceptron_entrenado = train(perceptron, Design.P, Design.T(1, :));
% Salida del perceptrón
Y = sim(perceptron_entrenado, Design.P);
% Automáticamente adapta la salida entre 0 y 1
plot3(Design.P(1, :), Design.P(2, :), Y, 'g.');
% Los puntos mejor clasificados no aportarán error, sino los peores clasificados 
% Qué pasa si tengo múltiples clases?
% Tendré una neurona/perceptron para cada clase
% Para modificar las características de entrenamiento:
% perceptron.trainParam
% Tarea: seguir avanzando y añadir una función como las anteriores pero con
% un perceptrón. Con múltiples clases tendremos que decidir la salida mayor
% entre las C salidas. Las fronteras seguirán siendo lineas rectas. La
% ganancia respecto al discriminante lineal es muy poca, pero con redes
% neuronales hay una ganancia significativa.
