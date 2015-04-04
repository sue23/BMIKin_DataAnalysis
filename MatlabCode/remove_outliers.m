function [newx,outlierindx]=remove_outliers(type,x)
% s.movtime,s.serror,s.group,s.grouplabel
% x = s.movtime;
% ep = s.serror;
% group = s.group;
% grouplabel = s.grouplabel;
if isempty(x)
    type='NONE';
end
switch type
    case 'QR'
        % Find outlier based on IQR
        %Outlier defined as either below Q1-1.5*IQR or Q3+1.5*IQR
        q1 = prctile(x,25);q3 = prctile(x,70);
        iqrx = iqr(x);
        outlierindx = find(x>(q3+1.5*iqrx) |x<(q1-1.5*iqrx));
        newx = x;
        newx(outlierindx) = NaN;
        
    case 'MAD'
        newx=x;
        
        x_med = nanmedian(x);
        
        x_std = 1.4826*mad(x,1);%nanstd(x);
        if isrow(x)
            [outlierindx] = find(abs(x-x_med(ones(1,length(x))))> ...
                2.0*(x_std(ones(1,length(x)))));
        else
            keyboard
            [outlierindx] = find(abs(x-x_med(ones(length(x),1)))> ...
                2.0*(x_std(ones(length(x),1))));
        end
        newx(outlierindx)=NaN;
        
    case 'STD'
        
        newx=x;
        
        x_med = nanmedian(x);
        
        x_std = nanstd(x);
        if isrow(x)
            [outlierindx] = find(abs(x-x_med(ones(1,length(x))))> ...
                2.0*(x_std(ones(1,length(x)))));
        else
            [outlierindx] = find(abs(x-x_med(ones(length(x),1)))> ...
                2.0*(x_std(ones(length(x),1))));
        end
        newx(outlierindx)=NaN;
        
    case 'NONE'
        newx = x;
        outlierindx = [];
end