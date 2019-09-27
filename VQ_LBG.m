clc; clear all
A=imread('lena.bmp'); %%A is a pixel matrix of the image. 
[row, col]=size(A); %%get row and column of the image
N=row*col;  %%total pixel of the image
p=8;    %% number of row and column of the training block image
n=p*p;  %% codeword size
Nb=N/n; %%number of training vector (training set)
Nc=64;  %%number of codeword/codevector (codebook length)
tSet=zeros(Nb,n); %% training vector matrix 
index_CM=1;
global dist;
%% divide the into nonoverlap nxn vector
for i= 1 : p : row
    for j=1 : p : col
        temp=TrainingVector(i,j,A(:,:),n,p); %%convert "block matrix (8x8)" become vector 1x64 TV=training Vector      
        for l = 1 : n  %n=64        
            tSet(index_CM,l)=temp(1,l); %%arrange block matrices become 64 x 4097 (training vector)
        end
        index_CM=index_CM+1;  
    end
end

%% codebook generation: step 1
temp=randi(Nb,1,Nc);
temp=double(temp);
codebook=zeros(Nc,n);
% indexCM=1;
for i = 1 : Nc 
    for j=1 : n  
        codebook(i,j)=tSet( temp(1,i), j); %%we already have codebook (length of the codeword n=64, length of the index NC=64)
    end  
end

%% codebook generation: step 2
x=double(1);
distort_fact_prev = 1 ; %%distortion factor in the previous iteration
distort_fact=1 ; %%distortion factor current iteration
iter = 0;
while x > 0.0005
    iter = iter+1;
    distort_fact_prev=distort_fact;
%%creating Nc classes
%%Nb rows with n elements and Nc channels
container_cb=zeros(Nc,n);
%Maintains the upper filled limit of the container_class
count_container=ones(1,Nc);%%why 1? for index which is never mentioned, it will be labeled by 1%%to set zeros will cause NAN in codebook when there is no indext appear.
%This stores the indices of the closest codevector present in codebook with
%a particular training vector 
indexClosestMatch=zeros(1,Nb);
for i= 1 : Nb %(total training data)
   
    index = ClosestMatch( tSet(i,:) , codebook(: , : ) );
    %codebook generation step 2-->cluster training vector closest match
    indexClosestMatch(1,i)=index;
    
    container_cb( index ,: ) =container_cb( index ,: ) + tSet(i,:);%%everytime the corresponding index is mentioned above, this parameter will increase by corresponding training set 
    
    count_container(1,index) = count_container(1,index) + 1; %%everytime the corresponding index is mentioned above, this parameter will increase by 1 
    %%indicate number of data for each index (4162-4096=64 (because initial value of count_container =,1,1,1,1,1,0,0,0,0...))
end
%This updates the codebook using the container_cb (clustering process)
% codebook generation: step 3
codebook=CodeBookUpdating(container_cb(:,:) , codebook(:,:) , count_container(:,:));

%This function updates the value of distortion factor
% codebook generation: step 4
distort_fact=distortionCalculation(codebook(:,:) , indexClosestMatch(:,:) , tSet(:,:) ) ; %%????????????????????????????

%This calculates the converence of distortion factor  
% codebook generation: step 5
x=abs(distort_fact_prev - distort_fact);
x=x/distort_fact_prev

end
%%creates the compressed image using codebook and indexClosestMatch\

CompressedImage(indexClosestMatch,codebook,A,p);

%%question : is it ok to have fraction value in codebook?
