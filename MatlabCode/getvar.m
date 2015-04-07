function [ varcur] = getvar( cursor, outlier )
%getvar calcola variabilitita' del movimento
%   cursor = 2XN solo movimenti di andata
%   outlier = outlier calcolati con mt e pathlength
if length(cursor)<=1 
    varcur.andate_x = nan;
    varcur.andate_y = nan;
    
else
    out = find(outlier);
    for i=1:length(out)
        cursor{out(i)}=cursor{out(i)}.*nan;
    end
    cur = cell2mat(cursor);
    vargo_curs=sqrt(diag(nancov(cur')));
    varcur.andate_x = vargo_curs(1,1);
    varcur.andate_y = vargo_curs(2,1);
end
end %function

