% Funciones para utilizar 
% newff crea una red neuronal feed forward (entradas a la izquierda)
perceptron = newff(Design.P, Design.T(1, :), [], {'tansig'}, 'trainlm');
% El tercer par�metro est� vacio para un perceptron simple
% COn traingdx, el algoritmo de gradiente controla la constante de
% aprendizaje
% Para controlar qu� utiliza como entrenamiento, test y validaci�n,
% utilizamos par�metros de dentro del perceptron. Con un perceptr�n, no es
% necesario validar ya que es dificil que sobreentrene (como en el caso del
% discriminante lineal)
perceptron.divideParam.trainRatio = 1;
perceptron.divideParam.valRatio = 0;
perceptron.divideParam.testRatio = 0;
% Para entrenar al perceptron, se hace lo siguiente:
perceptron_entrenado = train(perceptron, Design.P, Design.T(1, :));
% Salida del perceptr�n
Y = sim(perceptron_entrenado, Design.P);
% Autom�ticamente adapta la salida entre 0 y 1
plot3(Design.P(1, :), Design.P(2, :), Y, 'g.');
% Los puntos mejor clasificados no aportar�n error, sino los peores clasificados 
% Qu� pasa si tengo m�ltiples clases?
% Tendr� una neurona/perceptron para cada clase
% Para modificar las caracter�sticas de entrenamiento:
% perceptron.trainParam
% Tarea: seguir avanzando y a�adir una funci�n como las anteriores pero con
% un perceptr�n. Con m�ltiples clases tendremos que decidir la salida mayor
% entre las C salidas. Las fronteras seguir�n siendo lineas rectas. La
% ganancia respecto al discriminante lineal es muy poca, pero con redes
% neuronales hay una ganancia significativa.
