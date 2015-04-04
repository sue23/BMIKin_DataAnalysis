function [ vargo_curs,varcurs ] = getcursorvar( cursor,start, stop )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

varcurs=diag(nancov(cursor'));
%         qua c'? tutto!!! andate e ritorni
go_curs=[];
for i = 1:length(start)
    
    
        try
            go_curs = [go_curs,cursor(:,start(i):stop(i))];
            
        catch
            keyboard
        end

end
if size(go_curs,2)==1
    vargo_curs = [nan;nan];
else
vargo_curs=diag(nancov(go_curs'));
end

end

