function y = CodeBookUpdating(container,cb,count)
[Nc, n]=size(container);
for i= 1: Nc
        temp=zeros(1,n);
        temp(1,:)=container(i,:);
    temp = temp/count(1,i); %%temp=total value in index 1/total index 1 mentioned%%the number of vector in G(i)
    if all(temp == 0)
    else
    cb(i,:)=temp(1,:);
    end
end
y=round(cb(:,:));
end

