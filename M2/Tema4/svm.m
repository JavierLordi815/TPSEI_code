function [ PerrorTest, ClaseAsign ] = svm(Train,Test,mod,kerFunc,kerSc,standar,boxConst,optHyp)
%REDNEURONAL Función que permite utilizar una máquina de vector soporte (SVM) 
%para clasificar un conjunto de datos en distintos modos.
%   Train: Patrones de entrenamiento/training
%   Test: Patrones de test/prueba
%   mod: Modo de funcionamiento: 'one-against-all' o 'one-against-one'
%   kerFunc: Funciones de kernel utilizadas
%   kerSc: Factor de escala
%   standar: Valor booleano que activa la normalización automática de los
%   datos de entrada
%   boxConst: Valor máximo de los pesos
%   optHyp: Optimización de los hiperparámetros, del valor de C
%   PerrorTest: Probabilidad de error del conjunto de test obtenido de la
%   comparación entre etiquetado real y resultado de clasificación
%   ClaseAsign: Clase asignada a cada patrón por la SVM

    %Diseño de una SVM multiclase con “one-against-all”
    % Nº de clases
    C = size(Train.T, 1);
    % Tamaño base de datos de test
    N_Test = size(Test.P, 2);
    % Inicialización de la matriz de salida
    Y = zeros(C, N_Test);
    %if strcmp(mode, 'one-against-all') == true
    if C==2
        SVMModel=fitcsvm(Train.P.',Train.T(1, :).', ...
                        'KernelFunction', kerFunc, ...
                        'KernelScale', kerSc, ...
                        'Standardize', standar, ...
                        'BoxConstraint', boxConst, ...
                        'OptimizeHyperparameters', optHyp);
        [~,Y]=predict(SVMModel, Test.P.');
        [~,ClaseAsign]=max(Y);
        [~,ClaseReal]=max(Test.T);
    else
        if strcmp(mod,'one-against-all')==true
            % Inicialización del cell de svms:
            SVMModel=cell(C,1);
            for c=1:C
                SVMModel{c}=fitcsvm(Train.P.',Train.T(c, :).', ... 
                                    'KernelFunction', kerFunc, ...
                                    'KernelScale', kerSc, ...
                                    'Standardize', standar, ...
                                    'BoxConstraint', boxConst, ...
                                    'OptimizeHyperparameters', optHyp);
                [~,y]=predict(SVMModel{c}, Test.P.');
                if(size(y, 2)==2)
                    y=y(:,2);
                end
                Y(c,:)=y;
            end
            [~,ClaseAsign]=max(Y);
            [~,ClaseReal]=max(Test.T);
        elseif strcmp(mod, 'one-against-one')==true
            % Inicialización del cell de svms:
            SVMModel=cell(C,1);
            for c=1:C
                SVMModel{c}=fitcsvm(Train.P.',Train.T(c, :).', ... 
                                    'KernelFunction', kerFunc, ...
                                    'KernelScale', kerSc, ...
                                    'Standardize', standar, ...
                                    'BoxConstraint', boxConst, ...
                                    'OptimizeHyperparameters', optHyp);
                [~,y]=predict(SVMModel{c}, Test.P.');
                if(size(y, 2)==2)
                    y=y(:,2);
                end
                Y(c,:)=y;
            end
            % Diseño de una SVM multiclase con "one-against-one"
            ClasesAsigns=zeros(C*(C-1)/2,N_Test);
            n=1;
            for c=1:C
                for c2=c+1:C
                    ind=[find(Train.T(c,:)) find(Train.T(c2,:))];
                    SVM{c,c2}=fitcsvm(Train.P(:, ind)',Train.T(c, ind)', ...
                                    'KernelFunction', kerFunc, ...
                                    'KernelScale', kerSc, ...
                                    'Standardize', standar, ...
                                    'BoxConstraint', boxConst, ...
                                    'OptimizeHyperparameters', optHyp);
                    [x,~]=predict(SVM{c,c2}, Test.P');
                    ClasesAsigns(n,x==1)=c;
                    ClasesAsigns(n,x==0)=c2;
                    n=n+1;
                end
            end
            for k=1:C
                D(k,:)=sum(ClasesAsigns==k,1);
            end
        [~,ClaseAsign]=max(D+0.01*Y);
        [~,ClaseReal]=max(Test.T);
        end
    end
    PerrorTest=calcError(ClaseAsign,ClaseReal);
end

