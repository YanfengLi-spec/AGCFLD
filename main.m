 clear all 
 clc
 load('COIL20_Obj.mat'); 
 nClass = length(unique(gnd));
 Kclass=10;%2:10;
 [a,b]=sort(gnd,'ascend');
 gnd=a;
 fea=fea(b,:);
 fea = NormalizeFea(fea);  
 LabelsRatio=0.1;
 [X,Sampgnd,gndSampNum]=Creat_SampleDatasets(fea,Kclass,gnd,nClass,LabelsRatio); 
 p=5;
 C=Kclass;
 [~, WA, ~] = CAN(X', C, p);
 WA=refineW(WA,gndSampNum,C,Sampgnd);
 %      COIL20    PIE    MSRA25  YaleB   Yale 
%alpha   10000   1000    100      10    100000
%beta     10      10    1000     100    10000

 Options.maxIter=100;
 Options.alpha=10000;
 Options.beta=10;
 Options.gndSampNum=gndSampNum;
 Options.labels=Sampgnd;
 Options.KClass=Kclass;
 [~, V] =AGCFLD(X',WA,Options);
[~, label] = max(V');
newL=bestMap(Sampgnd,label);
AC=Accuracy(newL,Sampgnd);
MIhat = MutualInfo(XSmpgnd,label); 