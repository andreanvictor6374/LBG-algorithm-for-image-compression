function  CompressedImage(indexClosestMatch,codebook,A,p)
figure('name','Original Image','numbertitle','off');
imshow(A);
[row ,col]=size(A);
B = zeros (row,col) ;
indexCM=1;
for i=1 : p : row 
    for j=1 : p :col
        index=indexClosestMatch(1,indexCM);     
        l=1;   
        for k=0:p-1   
            for t=0:p-1        
                B(i+k,j+t)=codebook(index,l);       
                l = l + 1;  
            end            
        end
        indexCM=indexCM+1;     
    end  
end
B=uint8(B);
figure('name','Compressed Image','numbertitle','off');
imshow(B);
imwrite(B,'CompressedLena.bmp')
end

