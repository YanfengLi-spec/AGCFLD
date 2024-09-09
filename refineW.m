function W=refineW(W,l,C,XSmpgnd)
W(1:l,1:l)=0;


XSmpgnd=XSmpgnd(1:l);

for i=1:C
    inds=find(XSmpgnd==i);
    for k1=1:length(inds)
        for k2=1:length(inds)
            if inds(k1)~=inds(k2)
                W(inds(k1),inds(k2))=1;
            end
        end
    end
    
    %W(inds,inds)=1;
   % W((i-1)*(l/C)+1:(i)*(l/C),(i-1)*(l/C)+1:(i)*(l/C))=1;
end