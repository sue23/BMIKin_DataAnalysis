function [ h1,h2,h3 ] = Plot_ratioVar_training( r,subj,rows )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
limratio=max([max(r.ratioL_xo(:,subj)) max(r.ratioL_yo(:,subj)) max(r.ratioL_zo(:,subj)) max(r.ratioR_xo(:,subj)) max(r.ratioR_yo(:,subj)) max(r.ratioR_zo(:,subj))]);
h1=figure;
subplot(2,3,1)
bar(r.ratioL_xo(:,subj))
if isempty(rows.x)==0
    if length(rows.x)==2
        rows.x=[rows.x;nan];
    end
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_xo(:,subj))],'col','r')
end
if isempty(rows.y)==0
    if length(rows.y)==2
        rows.y=[rows.y;nan];
    end
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_xo(:,subj))],'col','g')
end
if isempty(rows.z)==0
    if length(rows.z)==2
        rows.z=[rows.z;nan];
    end
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_xo(:,subj))],'col','k')
end
title('variance ratio_L(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,2)
bar(r.ratioL_yo(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_yo(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_yo(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_yo(:,subj))],'col','k')
end
title('variance ratio_L(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,3)
bar(r.ratioL_zo(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_zo(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_zo(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_zo(:,subj))],'col','k')
end
title('variance ratio_L(z)')
ylim([0 max([limratio])])
legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,4)
bar(r.ratioR_xo(:,subj))
if isempty(rows.x)==0
    if length(rows.x)==2
        rows.x=[rows.x;nan];
    end
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_xo(:,subj))],'col','r')
end
if isempty(rows.y)==0
    if length(rows.y)==2
        rows.y=[rows.y;nan];
    end
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_xo(:,subj))],'col','g')
end
if isempty(rows.z)==0
    if length(rows.z)==2
        rows.z=[rows.z;nan];
    end
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_xo(:,subj))],'col','k')
end
title('variance ratio_R(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,5)
bar(r.ratioR_yo(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_yo(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_yo(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_yo(:,subj))],'col','k')
end
title('variance ratio_R(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,6)
bar(r.ratioR_zo(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_zo(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_zo(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_zo(:,subj))],'col','k')
end
title('variance ratio_R(z)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
suptitle('Reach H')


limratio=max([max(r.ratioL_xv(:,subj)) max(r.ratioL_yv(:,subj)) max(r.ratioL_zv(:,subj)) max(r.ratioR_xv(:,subj)) max(r.ratioR_yv(:,subj)) max(r.ratioR_zv(:,subj))]);

%%% Shoulders Vertical
h2=figure;
subplot(2,3,1)
bar(r.ratioL_xv(:,subj))
if isempty(rows.x)==0
    if length(rows.x)==2
        rows.x=[rows.x;nan];
    end
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_xv(:,subj))],'col','r')
end
if isempty(rows.y)==0
    if length(rows.y)==2
        rows.y=[rows.y;nan];
    end
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_xv(:,subj))],'col','g')
end
if isempty(rows.z)==0
    if length(rows.z)==2
        rows.z=[rows.z;nan];
    end
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_xv(:,subj))],'col','k')
end
title('variance ratio_L(x)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,2)
bar(r.ratioL_yv(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_yv(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_yv(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_yv(:,subj))],'col','k')
end
title('variance ratio_L(y)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,3)
bar(r.ratioL_zv(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_zv(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_zv(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_zv(:,subj))],'col','k')
end
title('variance ratio_L(z)')
legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,4)
bar(r.ratioR_xv(:,subj))
if isempty(rows.x)==0
    if length(rows.x)==2
        rows.x=[rows.x;nan];
    end
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_xv(:,subj))],'col','r')
end
if isempty(rows.y)==0
    if length(rows.y)==2
        rows.y=[rows.y;nan];
    end
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_xv(:,subj))],'col','g')
end
if isempty(rows.z)==0
    if length(rows.z)==2
        rows.z=[rows.z;nan];
    end
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_xv(:,subj))],'col','k')
end
title('variance ratio_R(x)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,5)
bar(r.ratioR_yv(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_yv(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_yv(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_yv(:,subj))],'col','k')
end
title('variance ratio_R(y)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
subplot(2,3,6)
bar(r.ratioR_zv(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_zv(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_zv(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_zv(:,subj))],'col','k')
end
title('variance ratio_R(z)')
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
ylim([0 max([limratio])])
box off
suptitle('Reach V')




limratio=max([max(r.ratioL_xc(:,subj)) max(r.ratioL_yc(:,subj)) max(r.ratioL_zc(:,subj)) max(r.ratioR_xc(:,subj)) max(r.ratioR_yc(:,subj)) max(r.ratioR_zc(:,subj))]);

%%%%   Cross Reaching
h3=figure;
subplot(2,3,1)
bar(r.ratioL_xc(:,subj))
if isempty(rows.x)==0
    if length(rows.x)==2
        rows.x=[rows.x;nan];
    end
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_xc(:,subj))],'col','r')
end
if isempty(rows.y)==0
    if length(rows.y)==2
        rows.y=[rows.y;nan];
    end
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_xc(:,subj))],'col','g')
end
if isempty(rows.z)==0
    if length(rows.z)==2
        rows.z=[rows.z;nan];
    end
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_xc(:,subj))],'col','k')
end
title('variance ratio_L(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,2)
bar(r.ratioL_yc(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_yc(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_yc(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_yc(:,subj))],'col','k')
end
title('variance ratio_L(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,3)
bar(r.ratioL_zc(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioL_zc(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioL_zc(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioL_zc(:,subj))],'col','k')
end
title('variance ratio_L(z)')
ylim([0 max([limratio])])
legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,4)
bar(r.ratioR_xc(:,subj))
if isempty(rows.x)==0
    if length(rows.x)==2
        rows.x=[rows.x;nan];
    end
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_xc(:,subj))],'col','r')
end
if isempty(rows.y)==0
    if length(rows.y)==2
        rows.y=[rows.y;nan];
    end
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_xc(:,subj))],'col','g')
end
if isempty(rows.z)==0
    if length(rows.z)==2
        rows.z=[rows.z;nan];
    end
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_xc(:,subj))],'col','k')
end
title('variance ratio_R(x)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,5)
bar(r.ratioR_yc(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_yc(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_yc(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_yc(:,subj))],'col','k')
end
title('variance ratio_R(y)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
subplot(2,3,6)
bar(r.ratioR_zc(:,subj))
if isempty(rows.x)==0
    hr=line([rows.x+0.4 rows.x+0.4],[0 max(r.ratioR_zc(:,subj))],'col','r')
end
if isempty(rows.y)==0
    hg=line([rows.y+0.5 rows.y+0.5],[0 max(r.ratioR_zc(:,subj))],'col','g')
end
if isempty(rows.z)==0
    hk=line([rows.z+0.6 rows.z+0.6],[0 max(r.ratioR_zc(:,subj))],'col','k')
end
title('variance ratio_R(z)')
ylim([0 max([limratio])])
%     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
box off
suptitle('Reach C')

end