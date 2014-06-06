GCp=zeros(20,2);
for i=1:20
    GCp(i,:)=lgc(ST,i);
end
plot(1:20,GCp(:,1),1:20,GCp(:,2))

