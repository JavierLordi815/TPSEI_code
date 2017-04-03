clc; clear; close all;
addpath dataSets\   
addpath Tema2\
addpath Tema3\
addpath Tema4\
dataSets = {'DatosPesoEstatura' 'DatosGaussianas' 'DatosHRR', 'glassData2', 'Datosvehiculos', 'segmentData'};
load(dataSets{4});
%% 1º división
% Dividirla base de datos en k conjuntos (folds): 1 se utilizará para test
% y los otros k-1 para training y se irán alternando dando lugar a k
% iteraciones

% Nº de características (L) y de patrones (N)
[L,N]=size(Data.P);
% Nº de clases
C=size(Data.T,1);
% Nº de conjuntos
K=7;
for j=1:20
% Dividimos en K conjuntos aleatorios los N elementos de la base de datos:
%div=cvpartition(N,'kfold',k);
folds_=crossvalind('Kfold',N,K);
%% Inicializo un cell de K elementos, para poder paralelizar
Train=cell(K,1);
Test=cell(K,1);
ClaseAsign=cell(K,1);
for i=1:K
    Train{i}.P=Data.P(:,folds_~=i);
    Train{i}.T=Data.T(:,folds_~=i);
    Test{i}.P=Data.P(:,folds_==i);
    Test{i}.T=Data.T(:,folds_==i);
    ClaseAsign{i}=false(C,length(folds_(folds_==i)));
end
PerrorTest=nan(K,1);
% Parámetros de la SVM
mod = 'one-against-one';
kerFunc = 'rbf';
kerSc = 'auto';
standar = true;
boxConst = 1;
optHyp = 'none';
%% Ejecución del método
% Bucle principal de n_gen generaciones
%progreso = waitbar(0,'Evolucionando');
parfor i=1:K
    %[PerrorTest(i),ClaseAsign{i}]=dlda(Train{i},Test{i});
    %[PerrorTest(i),ClaseAsign{i}]=dqda(Train{i},Test{i});
    %[PerrorTest(i),ClaseAsign{i}]=kernel(Train{i},Test{i},0.56); % 0.64 para C=6
    %[PerrorTest(i),ClaseAsign{i}]=knn(Train{i},Test{i},1);
    %[PerrorTest(i),ClaseAsign{i}]=linearMSE(Train{i},Test{i});
    %[PerrorTest(i),ClaseAsign{i}]=simplCuadraticMSE(Train{i},Test{i});
    %[PerrorTest(i),ClaseAsign{i}]=perceptronLineal(Train{i},Test{i});
    %[PerrorTest(i),ClaseAsign{i}]=redNeuronal(Train{i},Test{i});
    %[PerrorTest(i),ClaseAsign{i}]=rbfn(Train{i},Test{i}, 15);
    [PerrorTest(i), ClaseAsign{i}] = svm(Train{i},Test{i},'one-against-one',kerFunc,kerSc,standar,boxConst,optHyp);

end
%waitbar(i/K,progreso,['iteracion ',num2str(i),' de ',num2str(K)])
%% Cálculo del mejor caso y de la media aritmética del error, en tanto por cien:
meanError=mean(PerrorTest)*100;
Error(j) = meanError;
end
%% Representación de las dos primeras características de la base de datos
% Se utiliza el caso de menor error como criterio y un color para cada clase:
[~,ind]=min(PerrorTest);
classificationRepr(Test{ind},ClaseAsign{ind}, [2 3]);
clearvars -except meanError Error

