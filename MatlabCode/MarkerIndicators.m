function MarkerIndicators(datadir)
choice = questdlg('Vuoi graficare andamento nel training?', ...
    '', ...
    'Si','No','No');
switch choice
    case 'No'
        training = 0;
    case 'Si'
        training = 1;
end
% markers = {'hipc','spine','shc','head','shl','elbl','wristl','handl','shr','elbr','wristr','handr','hipl','kneel','anklel','footl','hipr','kneer','ankler','footr'};
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
A=load(['mats',filesep,'ReachKinectData']);
load(['mats',filesep,'start']);
start = ind;
load(['mats',filesep,'stop']);
stop = ind;
load(['mats',filesep,'ReachMetrics']);
MT = ind.MT;

for subj=1:size(A.ind,1)
    
    [threshold{subj}]=importThresholds(soggetti{subj});
    rows_x =find(diff(threshold{subj}(:,1))~=0);
    rows_y =find(diff(threshold{subj}(:,2))~=0);
    rows_z =find(diff(threshold{subj}(:,3))~=0);
    for sess=1:size(A.ind,2)
        for g = 1:size(A.ind,3)
            
            if ~isnan(start{subj,sess,g})
                data_markers = A.ind{subj,sess,g};
                zind = find(sum(abs(data_markers'))~=0);
                data_markers=data_markers(zind,:);
                xyz = [];
                for i=1:3:size(data_markers,2)-2
                    xyz = cat(3,xyz, data_markers(:,i:i+2));
                end
                deltashx = [];
                    deltashy = [];
                    deltashz =[];
                
                for trial = 1:length(start{subj,sess,g})
                    try
                        if isnan(MT{subj,sess,g}(trial))
                            MAHip(trial,:) = nan;
                            PLHip(trial,:) = nan;
                            MASh(trial,:) = nan;
                            PLSh(trial,:) = nan;
                            deltashx(trial) = nan;
                    deltashy(trial) = nan;
                    deltashz(trial) =nan;
                    
                            continue
                        end
                    catch
                        keyboard
                    end
                    hipx = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),1,[1 13 17]));
                    hipy = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),2,[1 13 17]));
                    hipz = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),3,[1 13 17]));
                    trunkx = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),1,[2]));
                    trunky = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),2,[2]));
                    trunkz = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),3,[2]));
                    shx = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),1,[3 5 9]));
                    shy = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),2,[3 5 9]));
                    shz = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),3,[3 5 9]));
                    deltashx(trial) = median(abs(shx(:,2)-shx(:,3)));
                    deltashy(trial) = median(abs(shy(:,2)-shy(:,3)));
                    deltashz(trial) = median(abs(shz(:,2)-shz(:,3)));
                    
                    deltahipx(trial) = median(abs(hipx(:,2)-hipx(:,3)));
                    deltahipy(trial) = median(abs(hipy(:,2)-hipy(:,3)));
                    deltahipz(trial) = median(abs(hipz(:,2)-hipz(:,3)));
                    
                    hip = cat(3,hipx,hipy,hipz);
                    % calcolo della distanza finale
                    MAHip(trial,:) =sqrt(sum(diff(hip([1 end],:,:)).^2,3));% norm(CursorXY(end,:)-CursorXY(1,:))
                    %calcolo del percorso  fatto
                    PLHip(trial,:) = sum(sqrt(sum(diff(hip).^2,3)));%norm(CursorXY(i+1,:)-CursorXY(i,:));
                    
                    sh = cat(3,shx,shy,shz);
                    % calcolo della distanza finale
                    MASh(trial,:) =sqrt(sum(diff(sh([1 end],:,:)).^2,3));% norm(CursorXY(end,:)-CursorXY(1,:))
                    %calcolo del percorso  fatto
                    PLSh(trial,:) = sum(sqrt(sum(diff(sh).^2,3)));
                
                    if subj==3
                        figure(sess*g+6*g*sess+sess)
                        title(['sess', num2str(sess),'task',num2str(g)])
%                for t = 1:stop{subj,sess,g}(trial)-start{subj,sess,g}(trial)+1
%                 line([hipx(t,:) hipx(t,1)],[hipy(t,:) hipy(t,1)],[hipz(t,:) hipz(t,1)])
%                 hold on
%                 line([hipx(t,1) trunkx(t) shx(t,1)],[hipy(t,1) trunky(t) shy(t,1)],[hipz(t,1) trunkz(t) shz(t,1)],'col','r')
%                 line([shx(t,:) shx(t,1)],[shy(t,:) shy(t,1)],[shz(t,:) shz(t,1)])
%                 
                plot3(shx(:,1),shy(:,1),shz(:,1),'.c')
                hold on
                plot3(shx(:,2),shy(:,2),shz(:,2),'.m')
                plot3(shx(:,3),shy(:,3),shz(:,3),'.g')
                
                plot3(hipx(:,1),hipy(:,1),hipz(:,1),'.r')
                hold on
                plot3(hipx(:,2),hipy(:,2),hipz(:,2),'.b')
                plot3(hipx(:,3),hipy(:,3),hipz(:,3),'.k')
                xlabel('x')
                ylabel('y')
                zlabel('z')
%                 view(-90,90); %Piano xy
                view(0,90); %piano yx
%                 view(0,0); %Piano zx
%                 view(-90,0); %Piano zy
%                 drawnow
% %                 %
% %                 %                 pause(1)
%             end
                    end 
                end %trial
                MA_HipL(:,subj,sess,g) = [nanmean(MAHip(:,2)) nanstd(MAHip(:,2))./sqrt(length(start{subj,sess,g}))];
                MA_ShL(:,subj,sess,g)= [nanmean(MASh(:,2)) nanstd(MASh(:,2))./sqrt(length(start{subj,sess,g}))];
                
                SH_x(:,subj,sess,g) = [nanmean(deltashx) nanstd(deltashx)./sqrt(length(start{subj,sess,g}))];
                SH_y(:,subj,sess,g)= [nanmean(deltashy) nanstd(deltashy)./sqrt(length(start{subj,sess,g}))];
                SH_z(:,subj,sess,g) = [nanmean(deltashz) nanstd(deltashz)./sqrt(length(start{subj,sess,g}))];
                HIP_x(:,subj,sess,g) = [nanmean(deltahipx) nanstd(deltahipx)./sqrt(length(start{subj,sess,g}))];
                HIP_y(:,subj,sess,g)= [nanmean(deltahipy) nanstd(deltahipy)./sqrt(length(start{subj,sess,g}))];
                HIP_z(:,subj,sess,g) = [nanmean(deltahipz) nanstd(deltahipz)./sqrt(length(start{subj,sess,g}))];
                
                PL_HipL(:,subj,sess,g) = [nanmean(PLHip(:,2)) nanstd(PLHip(:,2))./sqrt(length(start{subj,sess,g}))];
                PL_ShL(:,subj,sess,g) = [nanmean(PLSh(:,2)) nanstd(PLSh(:,2))./sqrt(length(start{subj,sess,g}))];
                
                MA_HipR(:,subj,sess,g) = [nanmean(MAHip(:,3)) nanstd(MAHip(:,3))./sqrt(length(start{subj,sess,g}))];
                MA_ShR(:,subj,sess,g) = [nanmean(MASh(:,3)) nanstd(MASh(:,3))./sqrt(length(start{subj,sess,g}))];
                PL_HipR(:,subj,sess,g) = [nanmean(PLHip(:,3)) nanstd(PLHip(:,3))./sqrt(length(start{subj,sess,g}))];
                PL_ShR(:,subj,sess,g) = [nanmean(PLSh(:,3)) nanstd(PLSh(:,3))./sqrt(length(start{subj,sess,g}))];
                
            else
                MA_HipL(:,subj,sess,g) = [nan nan];
                MA_ShL(:,subj,sess,g) = [nan nan];
                PL_HipL(:,subj,sess,g) = [nan nan];
                PL_ShL(:,subj,sess,g) = [nan nan];
                
                MA_HipR(:,subj,sess,g) = [nan nan];
                MA_ShR(:,subj,sess,g) = [nan nan];
                PL_HipR(:,subj,sess,g) = [nan nan];
                PL_ShR(:,subj,sess,g) = [nan nan];
            end
        end%g
    end%sess
    keyboard
    if training
        limMA = max(max([squeeze(MA_HipL(1,subj,:,:)) squeeze(MA_ShL(1,subj,:,:)) squeeze(MA_HipR(1,subj,:,:)) squeeze(MA_ShR(1,subj,:,:))]))+max(max([squeeze(MA_HipL(2,subj,:,:)) squeeze(MA_ShL(2,subj,:,:)) squeeze(MA_HipR(2,subj,:,:)) squeeze(MA_ShR(2,subj,:,:))]));
        limPL = max(max([squeeze(PL_HipL(1,subj,:,:)) squeeze(PL_ShL(1,subj,:,:)) squeeze(PL_HipR(1,subj,:,:)) squeeze(PL_ShR(1,subj,:,:))]))+max(max([squeeze(PL_HipL(2,subj,:,:)) squeeze(PL_ShL(2,subj,:,:)) squeeze(PL_HipR(2,subj,:,:)) squeeze(PL_ShR(2,subj,:,:))]));
        
        HL = figure(subj);
        subplot(2,2,1)
        patch([0.5 10.5 10.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        bar([squeeze(MA_HipL(1,subj,:,1));0;squeeze(MA_HipL(1,subj,:,2));0;squeeze(MA_HipL(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limMA],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limMA],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limMA],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 limMA]);
        ylabel('Mean L Hip MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_HipL(1,subj,:,1));0;squeeze(MA_HipL(1,subj,:,2));0;squeeze(MA_HipL(1,subj,:,3))],[squeeze(MA_HipL(2,subj,:,1));0;squeeze(MA_HipL(2,subj,:,2));0;squeeze(MA_HipL(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,2)
        patch([0.5 10.5 10.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(MA_ShL(1,subj,:,1));0;squeeze(MA_ShL(1,subj,:,2));0;squeeze(MA_ShL(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limMA],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limMA],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limMA],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 limMA]);
        ylabel('Mean L Sh MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_ShL(1,subj,:,1));0;squeeze(MA_ShL(1,subj,:,2));0;squeeze(MA_ShL(1,subj,:,3))],[squeeze(MA_ShL(2,subj,:,1));0;squeeze(MA_ShL(2,subj,:,2));0;squeeze(MA_ShL(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,2,3)
        patch([0.5 10.5 10.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(MA_HipR(1,subj,:,1));0;squeeze(MA_HipR(1,subj,:,2));0;squeeze(MA_HipR(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limMA],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limMA],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limMA],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 limMA]);
        ylabel('Mean R Hip MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_HipR(1,subj,:,1));0;squeeze(MA_HipR(1,subj,:,2));0;squeeze(MA_HipR(1,subj,:,3))],[squeeze(MA_HipR(2,subj,:,1));0;squeeze(MA_HipR(2,subj,:,2));0;squeeze(MA_HipR(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,4)
        patch([0.5 10.5 10.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(MA_ShR(1,subj,:,1));0;squeeze(MA_ShR(1,subj,:,2));0;squeeze(MA_ShR(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limMA],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limMA],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limMA],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limMA],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limMA],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limMA],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 limMA]);
        ylabel('Mean R Sh MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_ShR(1,subj,:,1));0;squeeze(MA_ShR(1,subj,:,2));0;squeeze(MA_ShR(1,subj,:,3))],[squeeze(MA_ShR(2,subj,:,1));0;squeeze(MA_ShR(2,subj,:,2));0;squeeze(MA_ShR(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%% destra%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        HR = figure(subj+length(soggetti));
        subplot(2,2,1)
        patch([0.5 10.5 10.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_HipL(1,subj,:,1));0;squeeze(PL_HipL(1,subj,:,2));0;squeeze(PL_HipL(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limPL],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limPL],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limPL],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylim([0 limPL]);
        ylabel('Mean L Hip PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_HipL(1,subj,:,1));0;squeeze(PL_HipL(1,subj,:,2));0;squeeze(PL_HipL(1,subj,:,3))],[squeeze(PL_HipL(2,subj,:,1));0;squeeze(PL_HipL(2,subj,:,2));0;squeeze(PL_HipL(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,2)
        patch([0.5 10.5 10.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_ShL(1,subj,:,1));0;squeeze(PL_ShL(1,subj,:,2));0;squeeze(PL_ShL(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limPL],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limPL],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limPL],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylim([0 limPL]);
        ylabel('Mean L Sh PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_ShL(1,subj,:,1));0;squeeze(PL_ShL(1,subj,:,2));0;squeeze(PL_ShL(1,subj,:,3))],[squeeze(PL_ShL(2,subj,:,1));0;squeeze(PL_ShL(2,subj,:,2));0;squeeze(PL_ShL(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,2,3)
        patch([0.5 10.5 10.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_HipR(1,subj,:,1));0;squeeze(PL_HipR(1,subj,:,2));0;squeeze(PL_HipR(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limPL],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limPL],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limPL],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylim([0 limPL]);
        ylabel('Mean R Hip PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_HipR(1,subj,:,1));0;squeeze(PL_HipR(1,subj,:,2));0;squeeze(PL_HipR(1,subj,:,3))],[squeeze(PL_HipR(2,subj,:,1));0;squeeze(PL_HipR(2,subj,:,2));0;squeeze(PL_HipR(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,4)
        patch([0.5 10.5 10.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_ShR(1,subj,:,1));0;squeeze(PL_ShR(1,subj,:,2));0;squeeze(PL_ShR(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 limPL],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 limPL],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 limPL],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 limPL],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 limPL],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 limPL],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylim([0 limPL]);
        ylabel('Mean R Sh PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_ShR(1,subj,:,1));0;squeeze(PL_ShR(1,subj,:,2));0;squeeze(PL_ShR(1,subj,:,3))],[squeeze(PL_ShR(2,subj,:,1));0;squeeze(PL_ShR(2,subj,:,2));0;squeeze(PL_ShR(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        HD = figure(subj+length(soggetti)*3);
        subplot(2,3,1)
        bar([squeeze(SH_x(1,subj,:,1));0;squeeze(SH_x(1,subj,:,2));0;squeeze(SH_x(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
%         if isempty(rows_x)==0
%             if length(rows_x)==2
%                 rows_x=[rows_x;nan];
%             end
%             hr=line(repmat([rows_x+0.4 rows_x+0.4],size(threshold{subj}(rows_x,1),1),1),[repmat(0,size(threshold{subj}(rows_x,1),1),1) threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+11,[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+22,[0 threshold{subj}(rows_x,1)],'col','r')
%         end
%         if isempty(rows_y)==0
%             if length(rows_y)==2
%                 rows_y=[rows_y;nan];
%             end
%             hg=line([rows_y+0.5 rows_y+0.5],[repmat(0,size(threshold{subj}(rows_y,2),1),1) threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+11,[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+22,[0 threshold{subj}(rows_y,2)],'col','g')
%         end
%         if isempty(rows_z)==0
%             if length(rows_z)==2
%                 rows_z=[rows_z;nan];
%             end
%             hk=line([rows_z+0.6 rows_z+0.6],[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+11,[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+22,[0 threshold{subj}(rows_z,3)],'col','k')
%         end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylabel('SH_x [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(SH_x(1,subj,:,1));0;squeeze(SH_x(1,subj,:,2));0;squeeze(SH_x(1,subj,:,3))],[squeeze(SH_x(2,subj,:,1));0;squeeze(SH_x(2,subj,:,2));0;squeeze(SH_x(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
         
        subplot(2,3,2)
        bar([squeeze(SH_y(1,subj,:,1));0;squeeze(SH_y(1,subj,:,2));0;squeeze(SH_y(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
%         if isempty(rows_x)==0
%             if length(rows_x)==2
%                 rows_x=[rows_x;nan];
%             end
%             hr=line([rows_x+0.4 rows_x+0.4],[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+11,[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+22,[0 threshold{subj}(rows_x,1)],'col','r')
%         end
%         if isempty(rows_y)==0
%             if length(rows_y)==2
%                 rows_y=[rows_y;nan];
%             end
%             hg=line([rows_y+0.5 rows_y+0.5],[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+11,[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+22,[0 threshold{subj}(rows_y,2)],'col','g')
%         end
%         if isempty(rows_z)==0
%             if length(rows_z)==2
%                 rows_z=[rows_z;nan];
%             end
%             hk=line([rows_z+0.6 rows_z+0.6],[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+11,[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+22,[0 threshold{subj}(rows_z,3)],'col','k')
%         end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylabel('SH_y [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(SH_y(1,subj,:,1));0;squeeze(SH_y(1,subj,:,2));0;squeeze(SH_y(1,subj,:,3))],[squeeze(SH_y(2,subj,:,1));0;squeeze(SH_y(2,subj,:,2));0;squeeze(SH_y(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,3,3)
        bar([squeeze(SH_z(1,subj,:,1));0;squeeze(SH_z(1,subj,:,2));0;squeeze(SH_z(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
%         if isempty(rows_x)==0
%             if length(rows_x)==2
%                 rows_x=[rows_x;nan];
%             end
%             hr=line([rows_x+0.4 rows_x+0.4],[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+11,[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+22,[0 threshold{subj}(rows_x,1)],'col','r')
%         end
%         if isempty(rows_y)==0
%             if length(rows_y)==2
%                 rows_y=[rows_y;nan];
%             end
%             hg=line([rows_y+0.5 rows_y+0.5],[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+11,[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+22,[0 threshold{subj}(rows_y,2)],'col','g')
%         end
%         if isempty(rows_z)==0
%             if length(rows_z)==2
%                 rows_z=[rows_z;nan];
%             end
%             hk=line([rows_z+0.6 rows_z+0.6],[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+11,[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+22,[0 threshold{subj}(rows_z,3)],'col','k')
%         end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylabel('SH_z [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(SH_z(1,subj,:,1));0;squeeze(SH_z(1,subj,:,2));0;squeeze(SH_z(1,subj,:,3))],[squeeze(SH_z(2,subj,:,1));0;squeeze(SH_z(2,subj,:,2));0;squeeze(SH_z(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        subplot(2,3,4)
        bar([squeeze(HIP_x(1,subj,:,1));0;squeeze(HIP_x(1,subj,:,2));0;squeeze(HIP_x(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
%         if isempty(rows_x)==0
%             if length(rows_x)==2
%                 rows_x=[rows_x;nan];
%             end
%             hr=line([rows_x+0.4 rows_x+0.4],[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+11,[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+22,[0 threshold{subj}(rows_x,1)],'col','r')
%         end
%         if isempty(rows_y)==0
%             if length(rows_y)==2
%                 rows_y=[rows_y;nan];
%             end
%             hg=line([rows_y+0.5 rows_y+0.5],[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+11,[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+22,[0 threshold{subj}(rows_y,2)],'col','g')
%         end
%         if isempty(rows_z)==0
%             if length(rows_z)==2
%                 rows_z=[rows_z;nan];
%             end
%             hk=line([rows_z+0.6 rows_z+0.6],[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+11,[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+22,[0 threshold{subj}(rows_z,3)],'col','k')
%         end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylabel('Hip_x [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(HIP_x(1,subj,:,1));0;squeeze(HIP_x(1,subj,:,2));0;squeeze(HIP_x(1,subj,:,3))],[squeeze(HIP_x(2,subj,:,1));0;squeeze(HIP_x(2,subj,:,2));0;squeeze(HIP_x(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,3,5)
        bar([squeeze(HIP_y(1,subj,:,1));0;squeeze(HIP_y(1,subj,:,2));0;squeeze(HIP_y(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
%         if isempty(rows_x)==0
%             if length(rows_x)==2
%                 rows_x=[rows_x;nan];
%             end
%             hr=line([rows_x+0.4 rows_x+0.4],[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+11,[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+22,[0 threshold{subj}(rows_x,1)],'col','r')
%         end
%         if isempty(rows_y)==0
%             if length(rows_y)==2
%                 rows_y=[rows_y;nan];
%             end
%             hg=line([rows_y+0.5 rows_y+0.5],[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+11,[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+22,[0 threshold{subj}(rows_y,2)],'col','g')
%         end
%         if isempty(rows_z)==0
%             if length(rows_z)==2
%                 rows_z=[rows_z;nan];
%             end
%             hk=line([rows_z+0.6 rows_z+0.6],[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+11,[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+22,[0 threshold{subj}(rows_z,3)],'col','k')
%         end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylabel('Hip_y [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(HIP_y(1,subj,:,1));0;squeeze(HIP_y(1,subj,:,2));0;squeeze(HIP_y(1,subj,:,3))],[squeeze(HIP_y(2,subj,:,1));0;squeeze(HIP_y(2,subj,:,2));0;squeeze(HIP_y(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,3,6)
        bar([squeeze(HIP_z(1,subj,:,1));0;squeeze(HIP_z(1,subj,:,2));0;squeeze(HIP_z(1,subj,:,3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
%         if isempty(rows_x)==0
%             if length(rows_x)==2
%                 rows_x=[rows_x;nan];
%             end
%             hr=line([rows_x+0.4 rows_x+0.4],[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+11,[0 threshold{subj}(rows_x,1)],'col','r')
%             hr=line([rows_x+0.4 rows_x+0.4]+22,[0 threshold{subj}(rows_x,1)],'col','r')
%         end
%         if isempty(rows_y)==0
%             if length(rows_y)==2
%                 rows_y=[rows_y;nan];
%             end
%             hg=line([rows_y+0.5 rows_y+0.5],[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+11,[0 threshold{subj}(rows_y,2)],'col','g')
%             hg=line([rows_y+0.5 rows_y+0.5]+22,[0 threshold{subj}(rows_y,2)],'col','g')
%         end
%         if isempty(rows_z)==0
%             if length(rows_z)==2
%                 rows_z=[rows_z;nan];
%             end
%             hk=line([rows_z+0.6 rows_z+0.6],[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+11,[0 threshold{subj}(rows_z,3)],'col','k')
%             hk=line([rows_z+0.6 rows_z+0.6]+22,[0 threshold{subj}(rows_z,3)],'col','k')
%         end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33])
        ylabel('Hip_z [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(HIP_z(1,subj,:,1));0;squeeze(HIP_z(1,subj,:,2));0;squeeze(HIP_z(1,subj,:,3))],[squeeze(HIP_z(2,subj,:,1));0;squeeze(HIP_z(2,subj,:,2));0;squeeze(HIP_z(2,subj,:,3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
    else
        if subj==3 
        first = 2;
        last = max(find(~isnan(MA_HipL(1,subj,:,1))));
        firstc = min(find(~isnan(MA_HipL(1,subj,:,3))));
        lastc = max(find(~isnan(MA_HipL(1,subj,:,3))));
        else
            first = min(find(~isnan(MA_HipL(1,subj,:,1))));
        last = max(find(~isnan(MA_HipL(1,subj,:,1))));
        firstc = min(find(~isnan(MA_HipL(1,subj,:,3))));
        lastc = max(find(~isnan(MA_HipL(1,subj,:,3))));
        end
        limMA = max(max([squeeze(MA_HipL(1,subj,[first last],:)) squeeze(MA_ShL(1,subj,[first last],:)) squeeze(MA_HipR(1,subj,[first last],:)) squeeze(MA_ShR(1,subj,[first last],:))]))+max(max([squeeze(MA_HipL(2,subj,[first last],:)) squeeze(MA_ShL(2,subj,[first last],:)) squeeze(MA_HipR(2,subj,[first last],:)) squeeze(MA_ShR(2,subj,[first last],:))]));
        limPL = max(max([squeeze(PL_HipL(1,subj,[first last],:)) squeeze(PL_ShL(1,subj,[first last],:)) squeeze(PL_HipR(1,subj,[first last],:)) squeeze(PL_ShR(1,subj,[first last],:))]))+max(max([squeeze(PL_HipL(2,subj,[first last],:)) squeeze(PL_ShL(2,subj,[first last],:)) squeeze(PL_HipR(2,subj,[first last],:)) squeeze(PL_ShR(2,subj,[first last],:))]));
        
        HL = figure(subj);
        subplot(2,2,1)
        patch([0.5 2.5 2.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        bar([squeeze(MA_HipL(1,subj,[first last],1));0;squeeze(MA_HipL(1,subj,[first last],2));0;squeeze(MA_HipL(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 limMA]);
        ylabel('Mean L Hip MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_HipL(1,subj,[first last],1));0;squeeze(MA_HipL(1,subj,[first last],2));0;squeeze(MA_HipL(1,subj,[firstc lastc],3))],[squeeze(MA_HipL(2,subj,[first last],1));0;squeeze(MA_HipL(2,subj,[first last],2));0;squeeze(MA_HipL(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,2)
        patch([0.5 2.5 2.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(MA_ShL(1,subj,[first last],1));0;squeeze(MA_ShL(1,subj,[first last],2));0;squeeze(MA_ShL(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 limMA]);
        ylabel('Mean L Sh MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_ShL(1,subj,[first last],1));0;squeeze(MA_ShL(1,subj,[first last],2));0;squeeze(MA_ShL(1,subj,[firstc lastc],3))],[squeeze(MA_ShL(2,subj,[first last],1));0;squeeze(MA_ShL(2,subj,[first last],2));0;squeeze(MA_ShL(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,2,3)
        patch([0.5 2.5 2.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(MA_HipR(1,subj,[first last],1));0;squeeze(MA_HipR(1,subj,[first last],2));0;squeeze(MA_HipR(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 limMA]);
        ylabel('Mean R Hip MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_HipR(1,subj,[first last],1));0;squeeze(MA_HipR(1,subj,[first last],2));0;squeeze(MA_HipR(1,subj,[firstc lastc],3))],[squeeze(MA_HipR(2,subj,[first last],1));0;squeeze(MA_HipR(2,subj,[first last],2));0;squeeze(MA_HipR(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,4)
        patch([0.5 2.5 2.5 0.5],[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limMA limMA],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(MA_ShR(1,subj,[first last],1));0;squeeze(MA_ShR(1,subj,[first last],2));0;squeeze(MA_ShR(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 limMA]);
        ylabel('Mean R Sh MA [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(MA_ShR(1,subj,[first last],1));0;squeeze(MA_ShR(1,subj,[first last],2));0;squeeze(MA_ShR(1,subj,[firstc lastc],3))],[squeeze(MA_ShR(2,subj,[first last],1));0;squeeze(MA_ShR(2,subj,[first last],2));0;squeeze(MA_ShR(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%% destra%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        HR = figure(subj+length(soggetti));
        subplot(2,2,1)
        patch([0.5 2.5 2.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_HipL(1,subj,[first last],1));0;squeeze(PL_HipL(1,subj,[first last],2));0;squeeze(PL_HipL(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylim([0 limPL]);
        ylabel('Mean L Hip PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_HipL(1,subj,[first last],1));0;squeeze(PL_HipL(1,subj,[first last],2));0;squeeze(PL_HipL(1,subj,[firstc lastc],3))],[squeeze(PL_HipL(2,subj,[first last],1));0;squeeze(PL_HipL(2,subj,[first last],2));0;squeeze(PL_HipL(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,2)
        patch([0.5 2.5 2.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_ShL(1,subj,[first last],1));0;squeeze(PL_ShL(1,subj,[first last],2));0;squeeze(PL_ShL(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylim([0 limPL]);
        ylabel('Mean L Sh PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_ShL(1,subj,[first last],1));0;squeeze(PL_ShL(1,subj,[first last],2));0;squeeze(PL_ShL(1,subj,[firstc lastc],3))],[squeeze(PL_ShL(2,subj,[first last],1));0;squeeze(PL_ShL(2,subj,[first last],2));0;squeeze(PL_ShL(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,2,3)
        patch([0.5 2.5 2.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_HipR(1,subj,[first last],1));0;squeeze(PL_HipR(1,subj,[first last],2));0;squeeze(PL_HipR(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylim([0 limPL]);
        ylabel('Mean R Hip PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_HipR(1,subj,[first last],1));0;squeeze(PL_HipR(1,subj,[first last],2));0;squeeze(PL_HipR(1,subj,[firstc lastc],3))],[squeeze(PL_HipR(2,subj,[first last],1));0;squeeze(PL_HipR(2,subj,[first last],2));0;squeeze(PL_HipR(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        %     title(['Soggetto: ',soggetti{subj}])
        
        subplot(2,2,4)
        patch([0.5 2.5 2.5 0.5],[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 limPL limPL],[0.8 0.8 0.8],'edgecolor','none')
        
        bar([squeeze(PL_ShR(1,subj,[first last],1));0;squeeze(PL_ShR(1,subj,[first last],2));0;squeeze(PL_ShR(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylim([0 limPL]);
        ylabel('Mean R Sh PL [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(PL_ShR(1,subj,[first last],1));0;squeeze(PL_ShR(1,subj,[first last],2));0;squeeze(PL_ShR(1,subj,[firstc lastc],3))],[squeeze(PL_ShR(2,subj,[first last],1));0;squeeze(PL_ShR(2,subj,[first last],2));0;squeeze(PL_ShR(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        HD = figure(subj+length(soggetti)*3);
        subplot(2,3,1)
        bar([squeeze(SH_x(1,subj,[first last],1));0;squeeze(SH_x(1,subj,[first last],2));0;squeeze(SH_x(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylabel('SH_x [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(SH_x(1,subj,[first last],1));0;squeeze(SH_x(1,subj,[first last],2));0;squeeze(SH_x(1,subj,[firstc lastc],3))],[squeeze(SH_x(2,subj,[first last],1));0;squeeze(SH_x(2,subj,[first last],2));0;squeeze(SH_x(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
         
        subplot(2,3,2)
        bar([squeeze(SH_y(1,subj,[first last],1));0;squeeze(SH_y(1,subj,[first last],2));0;squeeze(SH_y(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylabel('SH_y [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(SH_y(1,subj,[first last],1));0;squeeze(SH_y(1,subj,[first last],2));0;squeeze(SH_y(1,subj,[firstc lastc],3))],[squeeze(SH_y(2,subj,[first last],1));0;squeeze(SH_y(2,subj,[first last],2));0;squeeze(SH_y(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,3,3)
        bar([squeeze(SH_z(1,subj,[first last],1));0;squeeze(SH_z(1,subj,[first last],2));0;squeeze(SH_z(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylabel('SH_z [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(SH_z(1,subj,[first last],1));0;squeeze(SH_z(1,subj,[first last],2));0;squeeze(SH_z(1,subj,[firstc lastc],3))],[squeeze(SH_z(2,subj,[first last],1));0;squeeze(SH_z(2,subj,[first last],2));0;squeeze(SH_z(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        subplot(2,3,4)
        bar([squeeze(HIP_x(1,subj,[first last],1));0;squeeze(HIP_x(1,subj,[first last],2));0;squeeze(HIP_x(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylabel('Hip_x [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(HIP_x(1,subj,[first last],1));0;squeeze(HIP_x(1,subj,[first last],2));0;squeeze(HIP_x(1,subj,[firstc lastc],3))],[squeeze(HIP_x(2,subj,[first last],1));0;squeeze(HIP_x(2,subj,[first last],2));0;squeeze(HIP_x(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,3,5)
        bar([squeeze(HIP_y(1,subj,[first last],1));0;squeeze(HIP_y(1,subj,[first last],2));0;squeeze(HIP_y(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylabel('Hip_y [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(HIP_y(1,subj,[first last],1));0;squeeze(HIP_y(1,subj,[first last],2));0;squeeze(HIP_y(1,subj,[firstc lastc],3))],[squeeze(HIP_y(2,subj,[first last],1));0;squeeze(HIP_y(2,subj,[first last],2));0;squeeze(HIP_y(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
        subplot(2,3,6)
        bar([squeeze(HIP_z(1,subj,[first last],1));0;squeeze(HIP_z(1,subj,[first last],2));0;squeeze(HIP_z(1,subj,[firstc lastc],3))],0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9])
        ylabel('Hip_z [m]','FontSize',15)
        hold on
        h=errorbar([squeeze(HIP_z(1,subj,[first last],1));0;squeeze(HIP_z(1,subj,[first last],2));0;squeeze(HIP_z(1,subj,[firstc lastc],3))],[squeeze(HIP_z(2,subj,[first last],1));0;squeeze(HIP_z(2,subj,[first last],2));0;squeeze(HIP_z(2,subj,[firstc lastc],3))],'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        
    end
%     saveas(HD,['figs',filesep,'body',filesep,soggetti{subj},'_Alba',num2str(training)],'png')
%     saveas(HL,['figs',filesep,'body',filesep,soggetti{subj},'_Left',num2str(training)],'png')
%     saveas(HR,['figs',filesep,'body',filesep,soggetti{subj},'_Right',num2str(training)],'png')
%     close all
close(HL)
close(HD)
close(HR)
% keyboard
    
end%subj