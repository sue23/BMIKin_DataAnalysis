function [ h1,h2,h3 ] = Plot_ratioVar_PrePost( r,subj,maxsess )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

limratio=max([max(r.ratioL_xo([1 maxsess],subj)) max(r.ratioL_yo([1 maxsess],subj)) max(r.ratioL_zo([1 maxsess],subj)) max(r.ratioR_xo([1 maxsess],subj)) max(r.ratioR_yo([1 maxsess],subj)) max(r.ratioR_zo([1 maxsess],subj))]);
%%%%  Shoulders Horizontal
h1=figure;
subplot(2,3,1)
bar(r.ratioL_xo([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,2)
bar(r.ratioL_yo([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,3)
bar(r.ratioL_zo([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(z)')
ylim([0 max([limratio])])
box off
subplot(2,3,4)
bar(r.ratioR_xo([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,5)
bar(r.ratioR_yo([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,6)
bar(r.ratioR_zo([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(z)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
suptitle('Reach H')
%                 suptitle('Reach H')


limratio=max([max(r.ratioL_xv([1 maxsess],subj)) max(r.ratioL_yv([1 maxsess],subj)) max(r.ratioL_zv([1 maxsess],subj)) max(r.ratioR_xv([1 maxsess],subj)) max(r.ratioR_yv([1 maxsess],subj)) max(r.ratioR_zv([1 maxsess],subj))]);
%%% Shoulders Vertical
h2=figure;
subplot(2,3,1)
bar(r.ratioL_xv([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(x)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,2)
bar(r.ratioL_yv([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(y)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,3)
bar(r.ratioL_zv([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(z)')
ylim([0 max([limratio])])
box off
subplot(2,3,4)
bar(r.ratioR_xv([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(x)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,5)
bar(r.ratioR_yv([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(y)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,6)
bar(r.ratioR_zv([1 maxsess],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(z)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
suptitle('Reach V')



first = min(find(~isnan(r.ratioL_xc(:,subj))));
last = max(find(~isnan(r.ratioL_xc(:,subj))));
limratio=max([max(r.ratioL_xc([first last],subj)) max(r.ratioL_yc([first last],subj)) max(r.ratioL_zc([first last],subj)) max(r.ratioR_xc([first last],subj)) max(r.ratioR_yc([first last],subj)) max(r.ratioR_zc([first last],subj))]);

%%%%  Shoulders Cross Reaching
h3=figure;
subplot(2,3,1)
bar(r.ratioL_xc([first last],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,2)
bar(r.ratioL_yc([first last],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,3)
bar(r.ratioL_zc([first last],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_L(z)')
ylim([0 max([limratio])])
box off
subplot(2,3,4)
bar(r.ratioR_xc([first last],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,5)
bar(r.ratioR_yc([first last],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,6)
bar(r.ratioR_zc([first last],subj))
ax = gca;
ax.XTickLabel = {'Pre','Post'};
title('variance ratio_R(z)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
suptitle('Reach C')


end

