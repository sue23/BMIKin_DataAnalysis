function [ h1,h2,h3,h4,h5,h6 ] = Plot_bodyVar_PrePost( v,subj,maxsess )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

limShoulder=max([max(v.varshL_xo([1 maxsess],subj)) max(v.varshL_yo([1 maxsess],subj)) max(v.varshL_zo([1 maxsess],subj)) max(v.varshR_xo([1 maxsess],subj)) max(v.varshR_yo([1 maxsess],subj)) max(v.varshR_zo([1 maxsess],subj))]);
        limPelvis=max([max(v.varpelvisL_xo([1 maxsess],subj)) max(v.varpelvisL_yo([1 maxsess],subj)) max(v.varpelvisL_zo([1 maxsess],subj)) max(v.varpelvisR_xo([1 maxsess],subj)) max(v.varpelvisR_yo([1 maxsess],subj)) max(v.varpelvisR_zo([1 maxsess],subj))]);
        %%%%  Shoulders Horizontal
        h1=figure;
        subplot(2,3,1)
        bar(v.varshL_xo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varshL_yo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,3)
        bar(v.varshL_zo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,4)
        bar(v.varshR_xo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varshR_yo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varshR_zo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        suptitle('Reach H')
        %%%%  Pelvis Horizontal
        h3=figure;
        subplot(2,3,1)
        bar(v.varpelvisL_xo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varpelvisL_yo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,3)
        bar(v.varpelvisL_zo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,4)
        bar(v.varpelvisR_xo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varpelvisR_yo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varpelvisR_zo([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        
        limShoulder=max([max(v.varshL_xv([1 maxsess],subj)) max(v.varshL_yv([1 maxsess],subj)) max(v.varshL_zv([1 maxsess],subj)) max(v.varshR_xv([1 maxsess],subj)) max(v.varshR_yv([1 maxsess],subj)) max(v.varshR_zv([1 maxsess],subj))]);
        limPelvis=max([max(v.varpelvisL_xv([1 maxsess],subj)) max(v.varpelvisL_yv([1 maxsess],subj)) max(v.varpelvisL_zv([1 maxsess],subj)) max(v.varpelvisR_xv([1 maxsess],subj)) max(v.varpelvisR_yv([1 maxsess],subj)) max(v.varpelvisR_zv([1 maxsess],subj))]);
        suptitle('Reach H')
        %%% Shoulders Vertical
        h2=figure;
        subplot(2,3,1)
        bar(v.varshL_xv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,2)
        bar(v.varshL_yv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,3)
        bar(v.varshL_zv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,4)
        bar(v.varshR_xv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,5)
        bar(v.varshR_yv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,6)
        bar(v.varshR_zv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(z)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        suptitle('Reach V')
        
        %%%%  Pelvis Vertical
        h4=figure;
        subplot(2,3,1)
        bar(v.varpelvisL_xv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,2)
        bar(v.varpelvisL_yv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,3)
        bar(v.varpelvisL_zv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,4)
        bar(v.varpelvisR_xv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(x)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,5)
        bar(v.varpelvisR_yv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(y)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,6)
        bar(v.varpelvisR_zv([1 maxsess],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(z)')
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        ylim([0 max([limShoulder,limPelvis])])
        box off
        
        first = min(find(~isnan(v.varshL_xc(:,subj))));
        last = max(find(~isnan(v.varshL_xc(:,subj))));
        limShoulder=max([max(v.varshL_xc([first last],subj)) max(v.varshL_yc([first last],subj)) max(v.varshL_zc([first last],subj)) max(v.varshR_xc([first last],subj)) max(v.varshR_yc([first last],subj)) max(v.varshR_zc([first last],subj))]);
        limPelvis=max([max(v.varpelvisL_xc([first last],subj)) max(v.varpelvisL_yc([first last],subj)) max(v.varpelvisL_zc([first last],subj)) max(v.varpelvisR_xc([first last],subj)) max(v.varpelvisR_yc([first last],subj)) max(v.varpelvisR_zc([first last],subj))]);
        suptitle('Reach V')
        
        %%%%  Shoulders Cross Reaching
        h5=figure;
        subplot(2,3,1)
        bar(v.varshL_xc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varshL_yc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,3)
        bar(v.varshL_zc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,4)
        bar(v.varshR_xc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varshR_yc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varshR_zc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Shoulder_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        suptitle('Reach C')
        
        %%%%  Pelvis cross
        h6=figure;
        subplot(2,3,1)
        bar(v.varpelvisL_xc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,2)
        bar(v.varpelvisL_yc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(y)')
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,3)
        bar(v.varpelvisL_zc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_L(z)')
        ylim([0 max([limShoulder,limPelvis])])
        box off
        subplot(2,3,4)
        bar(v.varpelvisR_xc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(x)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,5)
        bar(v.varpelvisR_yc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(y)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        subplot(2,3,6)
        bar(v.varpelvisR_zc([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Pelvis_R(z)')
        ylim([0 max([limShoulder,limPelvis])])
        %     legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        box off
        suptitle('Reach C')
end

