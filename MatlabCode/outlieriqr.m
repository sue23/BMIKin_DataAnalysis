function [newx,outlierindx] = outlieriqr(x)
% Find outlier based on IQR
%Outlier defined as either below Q1-1.5*IQR or Q3+1.5*IQR
q1 = prctile(x,25);q3 = prctile(x,75);
iqrx = iqr(x);
outlierindx = find(x>(q3+1.5*iqrx) |x<(q1-1.5*iqrx));
newx = x;
newx(outlierindx) = NaN;
