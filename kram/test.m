fid = fopen('test.txt','r') 
C = textscan(fid, '%s',' ');
fclose(fid)
C = C{:};

[x,y]=size(C);
email = '[a-z_]+@[a-z]+\.(com|net)';
result = result(:);

for i=0:x
    
    result(i) = regexp(C(i), email, 'match')
end

% index = strfind(C,'@');
% index = find(~cellfun(@isempty,index));
% 
% mist = strfind(C,'@font-face');
% mist = find(~cellfun(@isempty,mist));
% 
% result = C(index)
% C(mist)
