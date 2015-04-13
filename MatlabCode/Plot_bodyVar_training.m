function [ h1,h2,h3,h4,h5,h6 ] = Plot_bodyVar_training( v,subj,rows )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
limShoulder=max([max(v.varshL_xo(:,subj)) max(v.varshL_yo(:,subj)) max(v.varshL_zo(:,subj)) max(v.varshR_xo(:,subj)) max(v.varshR_yo(:,subj)) max(v.varshR_zo(:,subj))]);
        limPelvis=max([max(v.varpelvisL_xo(:,subj)) max(v.varpelvisL_yo(:,subj)) max(v.varpelvisL_zo(:,subj)) max(v.varpelvisR_xo(:,subj)) max(v.varpelvisR_yo(:,subj)) max(v.varpelvisR_zo(:,subj))]);
        %%%%  Shoulders Horizontal
        h1=figure;
        subplot(2,3,1)
        bar(v.varshL_xo(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_xo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_xo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_xo(:,subj))],'col','k')
        end
        title('Shoulder_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varshL_yo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_yo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_yo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_yo(:,subj))],'col','k')
        end
        title('Shoulder_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,3)
        bar(v.varshL_zo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_zo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_zo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_zo(:,subj))],'col','k')
        end
        title('Shoulder_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,4)
        bar(v.varshR_xo(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_xo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_xo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_xo(:,subj))],'col','k')
        end
        title('Shoulder_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varshR_yo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_yo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_yo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_yo(:,subj))],'col','k')
        end
        title('Shoulder_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varshR_zo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_zo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_zo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_zo(:,subj))],'col','k')
        end
        title('Shoulder_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        suptitle('Reach H')
        %%%%  Pelvis Horizontal
        h3=figure;
        subplot(2,3,1)
        bar(v.varpelvisL_xo(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_xo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_xo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_xo(:,subj))],'col','k')
        end
        title('Pelvis_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varpelvisL_yo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_yo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_yo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_yo(:,subj))],'col','k')
        end
        title('Pelvis_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,3)
        bar(v.varpelvisL_zo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_zo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_zo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_zo(:,subj))],'col','k')
        end
        title('Pelvis_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,4)
        bar(v.varpelvisR_xo(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_xo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_xo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_xo(:,subj))],'col','k')
        end
        title('Pelvis_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varpelvisR_yo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_yo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_yo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_yo(:,subj))],'col','k')
        end
        title('Pelvis_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varpelvisR_zo(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_zo(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_zo(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_zo(:,subj))],'col','k')
        end
        title('Pelvis_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        
        limShoulder=max([max(v.varshL_xv(:,subj)) max(v.varshL_yv(:,subj)) max(v.varshL_zv(:,subj)) max(v.varshR_xv(:,subj)) max(v.varshR_yv(:,subj)) max(v.varshR_zv(:,subj))]);
        limPelvis=max([max(v.varpelvisL_xv(:,subj)) max(v.varpelvisL_yv(:,subj)) max(v.varpelvisL_zv(:,subj)) max(v.varpelvisR_xv(:,subj)) max(v.varpelvisR_yv(:,subj)) max(v.varpelvisR_zv(:,subj))]);
        suptitle('Reach H')
        %%% Shoulders Vertical
        h2=figure;
        subplot(2,3,1)
        bar(v.varshL_xv(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_xv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_xv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_xv(:,subj))],'col','k')
        end
        title('Shoulder_L(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,2)
        bar(v.varshL_yv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_yv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_yv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_yv(:,subj))],'col','k')
        end
        title('Shoulder_L(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,3)
        bar(v.varshL_zv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_zv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_zv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_zv(:,subj))],'col','k')
        end
        title('Shoulder_L(z)')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,4)
        bar(v.varshR_xv(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_xv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_xv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_xv(:,subj))],'col','k')
        end
        title('Shoulder_R(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,5)
        bar(v.varshR_yv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_yv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_yv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_yv(:,subj))],'col','k')
        end
        title('Shoulder_R(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,6)
        bar(v.varshR_zv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_zv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_zv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_zv(:,subj))],'col','k')
        end
        title('Shoulder_R(z)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        suptitle('Reach V')
        
        %%%%  Pelvis Vertical
        h4=figure;
        subplot(2,3,1)
        bar(v.varpelvisL_xv(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_xv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_xv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_xv(:,subj))],'col','k')
        end
        title('Pelvis_L(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,2)
        bar(v.varpelvisL_yv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_yv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_yv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_yv(:,subj))],'col','k')
        end
        title('Pelvis_L(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,3)
        bar(v.varpelvisL_zv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_zv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_zv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_zv(:,subj))],'col','k')
        end
        title('Pelvis_L(z)')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,4)
        bar(v.varpelvisR_xv(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_xv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_xv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_xv(:,subj))],'col','k')
        end
        title('Pelvis_R(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,5)
        bar(v.varpelvisR_yv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_yv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_yv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_yv(:,subj))],'col','k')
        end
        title('Pelvis_R(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,6)
        bar(v.varpelvisR_zv(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_zv(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_zv(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_zv(:,subj))],'col','k')
        end
        title('Pelvis_R(z)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        
        limShoulder=max([max(v.varshL_xc(:,subj)) max(v.varshL_yc(:,subj)) max(v.varshL_zc(:,subj)) max(v.varshR_xc(:,subj)) max(v.varshR_yc(:,subj)) max(v.varshR_zc(:,subj))]);
        limPelvis=max([max(v.varpelvisL_xc(:,subj)) max(v.varpelvisL_yc(:,subj)) max(v.varpelvisL_zc(:,subj)) max(v.varpelvisR_xc(:,subj)) max(v.varpelvisR_yc(:,subj)) max(v.varpelvisR_zc(:,subj))]);
        suptitle('Reach V')
        
        %%%%  Shoulders Cross Reaching
        h5=figure;
        subplot(2,3,1)
        bar(v.varshL_xc(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_xc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_xc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_xc(:,subj))],'col','k')
        end
        title('Shoulder_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varshL_yc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_yc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_yc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_yc(:,subj))],'col','k')
        end
        title('Shoulder_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,3)
        bar(v.varshL_zc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshL_zc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshL_zc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshL_zc(:,subj))],'col','k')
        end
        title('Shoulder_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,4)
        bar(v.varshR_xc(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_xc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_xc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_xc(:,subj))],'col','k')
        end
        title('Shoulder_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varshR_yc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_yc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_yc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_yc(:,subj))],'col','k')
        end
        title('Shoulder_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varshR_zc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varshR_zc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varshR_zc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varshR_zc(:,subj))],'col','k')
        end
        title('Shoulder_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        suptitle('Reach C')
        
        %%%%  Pelvis cross
        h6=figure;
        subplot(2,3,1)
        bar(v.varpelvisL_xc(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_xc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_xc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_xc(:,subj))],'col','k')
        end
        title('Pelvis_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varpelvisL_yc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_yc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_yc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_yc(:,subj))],'col','k')
        end
        title('Pelvis_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,3)
        bar(v.varpelvisL_zc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisL_zc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisL_zc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisL_zc(:,subj))],'col','k')
        end
        title('Pelvis_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,4)
        bar(v.varpelvisR_xc(:,subj))
        if isempty(rows.x)==0
            if length(rows.x)==2
                rows.x=[rows.x;nan];
            end
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_xc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            if length(rows.y)==2
                rows.y=[rows.y;nan];
            end
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_xc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            if length(rows.z)==2
                rows.z=[rows.z;nan];
            end
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_xc(:,subj))],'col','k')
        end
        title('Pelvis_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varpelvisR_yc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_yc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_yc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_yc(:,subj))],'col','k')
        end
        title('Pelvis_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varpelvisR_zc(:,subj))
        if isempty(rows.x)==0
            hr=line([rows.x+0.4 rows.x+0.4],[0 max(v.varpelvisR_zc(:,subj))],'col','r')
        end
        if isempty(rows.y)==0
            hg=line([rows.y+0.5 rows.y+0.5],[0 max(v.varpelvisR_zc(:,subj))],'col','g')
        end
        if isempty(rows.z)==0
            hk=line([rows.z+0.6 rows.z+0.6],[0 max(v.varpelvisR_zc(:,subj))],'col','k')
        end
        title('Pelvis_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        suptitle('Reach C')

end

