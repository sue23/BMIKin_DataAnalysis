function [t,prob]=ttest_paired(data1,data2)

d1_fin = find(isfinite(data1));
d2_fin = find(isfinite(data2));

data1 = data1(d1_fin);
data2 = data2(d2_fin);

n1 = length(data1);
n2 = length(data2);

if n1~=n2
   disp('Data sizes must be the same!');
   return;%% was break; MOD by Angelo
end

mean1=mean(data1);
mean2=mean(data2);

var1 = cov(data1);
var2 = cov(data2);

cov12 = cov(data1,data2);
cov12 = cov12(1,2); %%ADDED BY ANGELO
df = n1-1;



svar = (var1+var2-2*cov12)/n1;
t = (mean1-mean2)/sqrt(svar);
prob = betainc(df/(df+t^2),0.5*df,0.5);