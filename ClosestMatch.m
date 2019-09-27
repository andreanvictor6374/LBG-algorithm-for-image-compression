function  y = ClosestMatch(TV,cb)
global dist;
[Nc, n] = size ( cb ) ; %%Nc(indices)=64, n(code word/codevector)=64
index = 0 ; 
dist = 2 ^ 32 ;
for i=1 : Nc %%index start from 1 to 64
    tempdist = 0 ;  
    for j= 1 : n 
        tempdist = tempdist + ( TV( 1 , j ) - cb( i , j ) ) ^ 2 ;
    end
    %tempdist= tempdist/n;
    tempdist=sqrt(tempdist);
    if dist > tempdist
        dist = tempdist ; 
        index = i ;
    end
end
y = index ;
end


