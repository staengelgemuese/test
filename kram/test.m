fid = fopen('test.txt','r') 
C = textscan(fid, '%s',' ');
fclose(fid)
C = C{:};

[x,y]=size(C);

index = strfind(C,'@');
index = find(~cellfun(@isempty,index));

mist = strfind(C,'@font-face');
mist = find(~cellfun(@isempty,mist));

result = C(index)
C(mist)
