function [ vargo_curs,varcurs ] = getvar( cursor,start, stop, outlier )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


go_curs=[];
for i = 1:length(start)
    
    if outlier(i)
        cursor(:,start(i):stop(i))=nan;
    end
        try
            go_curs = [go_curs,cursor(:,start(i):stop(i))];
            
        catch
            keyboard
        end

end
%         qua c'? tutto!!! andate e ritorni

varcurs=sqrt(diag(nancov(cursor')));



if size(go_curs,2)==1
    vargo_curs = [nan;nan];
else
vargo_curs=sqrt(diag(nancov(go_curs')));
end

end

