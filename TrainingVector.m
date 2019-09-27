function y = TrainingVector( i, j, A, n, p) %%get training vector
y = zeros(1, n);
k = 1;
    for a = i : p+i-1
        for b = j : j+p-1  
            y( 1, k ) = A( a, b );        
            k = k+1;              
        end    
    end
end