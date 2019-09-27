function y = distortionCalculation(cb,indexClosestMatch,tset)
sol=double(0);
[Nb, n]=size(tset);
sum=0;
for i=1:Nb %%4096 (number of training data)
    for j=1:n  %%64 (number of codevector)
        sum = sum + ( cb( indexClosestMatch( 1, i ), j ) - tset( i, j ) )^2; %% based on sequence of the index of codebook ()   
    end  
end
sol = sum/(Nb*n); %%number of training data*number of codevector (4096*64)(total pixel)
                    %%n exist in formulation distance                  
y = sol;
end

