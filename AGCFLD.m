 function  [W,V] = AGCFLD(X,WA,Options)
        [~, N]= size(X);
        if ~isempty(WA)
                D= diag(sum(WA,1));
                LV= D - WA;
                LV_P = (abs(LV) + LV)/2;
                LV_N = (abs(LV) - LV)/2;
        end
        %...........................................  
        Y=zeros(N,Options.KClass);     
        for i =1:Options.gndSampNum
              Y(i,Options.labels(i)) = 1;
        end
        %...........................................  
      W= abs(randn(N,Options.KClass));
      V = abs(randn(N, Options.KClass));
      V_1=V;
      V_1(Options.gndSampNum+1:end,:)=0; 
      K=X'*X;
for iter = 1:Options.maxIter
    W=W.*((K*V)./(K*W*V'*V+eps));
    V=V.*((K*W+Options.alpha*Y+Options.beta*LV_N*V)./(V*W'*K*W+Options.alpha*V_1+Options.beta*LV_P*V+eps));
    V_1=V;
    V_1(Options.gndSampNum+1:end,:)=0;

end
       