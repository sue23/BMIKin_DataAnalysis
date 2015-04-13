function [ var] = getvar( cursor, outlier )
%getvar calcola variabilitita' del movimento
%   cursor = 2XN solo movimenti di andata
%   outlier = outlier calcolati con mt e pathlength
if isempty(outlier)
    var.shouldL.andate_x = nan;
    var.shouldL.andate_y = nan;
    var.shouldL.andate_z = nan;
    
    var.shouldR.andate_x = nan;
    var.shouldR.andate_y = nan;
    var.shouldR.andate_z = nan;
    
    var.pelvisR.andate_x = nan;
    var.pelvisR.andate_y = nan;
    var.pelvisR.andate_z = nan;
    
    var.pelvisL.andate_x = nan;
    var.pelvisL.andate_y = nan;
    var.pelvisL.andate_z = nan;
else
    out = find(outlier);
    for i=1:length(out)
        cursor{out(i)}=cursor{out(i)}.*nan;
    end
    shl = [];
    shr = [];
    hipr = [];
    hipl = [];
    for trial = 1:length(cursor)
        
        
        shl = [shl, cursor{trial}(:,13:15)'];
        shr = [shr, cursor{trial}(:,25:27)'];
        hipr = [hipr, cursor{trial}(:,49:51)'];
        hipl = [hipl, cursor{trial}(:,37:39)'];
        
    end %trial
    varshl=sqrt(diag(nancov(shl')));
    var.shouldL.andate_x = varshl(1,1);
    var.shouldL.andate_y = varshl(2,1);
    var.shouldL.andate_z = varshl(3,1);
    
    varshr=sqrt(diag(nancov(shr')));
    var.shouldR.andate_x = varshr(1,1);
    var.shouldR.andate_y = varshr(2,1);
    var.shouldR.andate_z = varshr(3,1);
    
    varhipr=sqrt(diag(nancov(hipr')));
    var.pelvisR.andate_x = varhipr(1,1);
    var.pelvisR.andate_y = varhipr(2,1);
    var.pelvisR.andate_z = varhipr(3,1);
    
    varhipl=sqrt(diag(nancov(hipl')));
    var.pelvisL.andate_x = varhipl(1,1);
    var.pelvisL.andate_y = varhipl(2,1);
    var.pelvisL.andate_z = varhipl(3,1);
end
end %function

