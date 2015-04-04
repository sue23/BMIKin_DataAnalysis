function plotReachPerformance(Reach,soggetti,flag)

choice = questdlg('Vuoi graficare andamento nel training?', ...
    '', ...
    'Si','No','No');
switch choice
    case 'No'
        training = 0;
    case 'Si'
        training = 1;
end
for subj=1:size(Reach.MT,2)
    [threshold{subj}]=importThresholds(soggetti{subj});
    rows_x =find(diff(threshold{subj}(:,1))~=0);
    rows_y =find(diff(threshold{subj}(:,2))~=0);
    rows_z =find(diff(threshold{subj}(:,3))~=0);
    if training
        if strcmp(flag,'rec_reach')
            MTm=[squeeze(Reach.MT(1,subj,:,1));0;squeeze(Reach.MT(1,subj,:,2))];
            MTs=[squeeze(Reach.MT(2,subj,:,1));0;squeeze(Reach.MT(2,subj,:,2))];
            MTm(MTm==0)=nan;
            MTs(MTs==0)=nan;
            [MTnew,MTind]=remove_outliers('STD',MTm);
            MTs(MTind)=nan;
            %         MTnew(MTind)=[];%nan;
            
            PLm = [squeeze(Reach.PL(1,subj,:,1));0;squeeze(Reach.PL(1,subj,:,2))];
            PLs=[squeeze(Reach.PL(2,subj,:,1));0;squeeze(Reach.PL(2,subj,:,2))];
            PLm(PLm==0)=nan;
            PLs(PLs==0)=nan;
            [PLnew,PLind]=remove_outliers('STD',PLm);
            PLs(PLind)=nan;
            %         PLnew(PLind)=[];%nan;
            
            RTm = [squeeze(Reach.RT(1,subj,:,1));0;squeeze(Reach.RT(1,subj,:,2))];
            RTs = [squeeze(Reach.RT(2,subj,:,1));0;squeeze(Reach.RT(2,subj,:,2))];
            RTm(RTm==0)=nan;
            RTs(RTs==0)=nan;
            [RTnew,RTind]=remove_outliers('STD',RTm);
            RTs(RTind)=nan;
            %         RTnew(RTind)=[];%nan;
            
            MAm = [squeeze(Reach.MA(1,subj,:,1));0;squeeze(Reach.MA(1,subj,:,2))];
            MAs = [squeeze(Reach.MA(2,subj,:,1));0;squeeze(Reach.MA(2,subj,:,2))];
            MAm(MAm==0)=nan;
            MAs(MAs==0)=nan;
            [MAnew,MAind]=remove_outliers('STD',MAm);
            MAs(MAind)=nan;
            %         MAnew(MAind)=[];%nan;
            
            EEm = [squeeze(Reach.EndPointErr(1,subj,:,1));0;squeeze(Reach.EndPointErr(1,subj,:,2))];
            EEs = [squeeze(Reach.EndPointErr(2,subj,:,1));0;squeeze(Reach.EndPointErr(2,subj,:,2))];
            EEm(EEm==0)=nan;
            EEs(EEs==0)=nan;
            [EEnew,EEind]=remove_outliers('STD',EEm);
            EEs(EEind)=nan;
            %         EEnew(EEind)=[];%nan;
            
            ARm = [squeeze(Reach.AR(1,subj,:,1));0;squeeze(Reach.AR(1,subj,:,2))];
            ARs = [squeeze(Reach.AR(2,subj,:,1));0;squeeze(Reach.AR(2,subj,:,2))];
            ARm(ARm==0)=nan;
            ARs(ARs==0)=nan;
            [ARnew,ARind]=remove_outliers('STD',ARm);
            ARs(ARind)=nan;
            %         ARnew(ARind)=[];%nan;
            
            DJm = [squeeze(Reach.DJ(1,subj,:,1));0;squeeze(Reach.DJ(1,subj,:,2))];
            DJs = [squeeze(Reach.DJ(2,subj,:,1));0;squeeze(Reach.DJ(2,subj,:,2))];
            DJm(DJm==0)=nan;
            DJs(DJs==0)=nan;
            [DJnew,DJind]=remove_outliers('STD',DJm);
            DJs(DJind)=nan;
            %         DJnew(DJind)=[];%nan;
            
            LIm = [squeeze(Reach.LI(1,subj,:,1));0;squeeze(Reach.LI(1,subj,:,2))];
            LIs = [squeeze(Reach.LI(2,subj,:,1));0;squeeze(Reach.LI(2,subj,:,2))];
            LIm(LIm==0)=nan;
            LIs(LIs==0)=nan;
            [LInew,LIind]=remove_outliers('STD',LIm);
            LIs(LIind)=nan;
            %         LInew(LIind)=[];%nan;
            
            NPm = [squeeze(Reach.NP(1,subj,:,1));0;squeeze(Reach.NP(1,subj,:,2))];
            NPs = [squeeze(Reach.NP(2,subj,:,1));0;squeeze(Reach.NP(2,subj,:,2))];
            NPm(NPm==0)=nan;
            NPs(NPs==0)=nan;
            [NPnew,NPind]=remove_outliers('STD',NPm);
            NPs(NPind)=nan;
            %         NPnew(NPind)=[];%nan;
        else
            
            MTm=[squeeze(Reach.MT(1,subj,:,1));0;squeeze(Reach.MT(1,subj,:,2));0;squeeze(Reach.MT(1,subj,:,3))];
            MTs=[squeeze(Reach.MT(2,subj,:,1));0;squeeze(Reach.MT(2,subj,:,2));0;squeeze(Reach.MT(2,subj,:,3))];
            MTm(MTm==0)=nan;
            MTs(MTs==0)=nan;
            [MTnew,MTind]=remove_outliers('STD',MTm);
            MTs(MTind)=nan;
            %         MTnew(MTind)=[];%nan;
            
            PLm = [squeeze(Reach.PL(1,subj,:,1));0;squeeze(Reach.PL(1,subj,:,2));0;squeeze(Reach.PL(1,subj,:,3))];
            PLs=[squeeze(Reach.PL(2,subj,:,1));0;squeeze(Reach.PL(2,subj,:,2));0;squeeze(Reach.PL(2,subj,:,3))];
            PLm(PLm==0)=nan;
            PLs(PLs==0)=nan;
            [PLnew,PLind]=remove_outliers('STD',PLm);
            PLs(PLind)=nan;
            %         PLnew(PLind)=[];%nan;
            
            RTm = [squeeze(Reach.RT(1,subj,:,1));0;squeeze(Reach.RT(1,subj,:,2));0;squeeze(Reach.RT(1,subj,:,3))];
            RTs = [squeeze(Reach.RT(2,subj,:,1));0;squeeze(Reach.RT(2,subj,:,2));0;squeeze(Reach.RT(2,subj,:,3))];
            RTm(RTm==0)=nan;
            RTs(RTs==0)=nan;
            [RTnew,RTind]=remove_outliers('STD',RTm);
            RTs(RTind)=nan;
            %         RTnew(RTind)=[];%nan;
            
            MAm = [squeeze(Reach.MA(1,subj,:,1));0;squeeze(Reach.MA(1,subj,:,2));0;squeeze(Reach.MA(1,subj,:,3))];
            MAs = [squeeze(Reach.MA(2,subj,:,1));0;squeeze(Reach.MA(2,subj,:,2));0;squeeze(Reach.MA(2,subj,:,3))];
            MAm(MAm==0)=nan;
            MAs(MAs==0)=nan;
            [MAnew,MAind]=remove_outliers('STD',MAm);
            MAs(MAind)=nan;
            %         MAnew(MAind)=[];%nan;
            
            EEm = [squeeze(Reach.EndPointErr(1,subj,:,1));0;squeeze(Reach.EndPointErr(1,subj,:,2));0;squeeze(Reach.EndPointErr(1,subj,:,3))];
            EEs = [squeeze(Reach.EndPointErr(2,subj,:,1));0;squeeze(Reach.EndPointErr(2,subj,:,2));0;squeeze(Reach.EndPointErr(2,subj,:,3))];
            EEm(EEm==0)=nan;
            EEs(EEs==0)=nan;
            [EEnew,EEind]=remove_outliers('STD',EEm);
            EEs(EEind)=nan;
            %         EEnew(EEind)=[];%nan;
            
            ARm = [squeeze(Reach.AR(1,subj,:,1));0;squeeze(Reach.AR(1,subj,:,2));0;squeeze(Reach.AR(1,subj,:,3))];
            ARs = [squeeze(Reach.AR(2,subj,:,1));0;squeeze(Reach.AR(2,subj,:,2));0;squeeze(Reach.AR(2,subj,:,3))];
            ARm(ARm==0)=nan;
            ARs(ARs==0)=nan;
            [ARnew,ARind]=remove_outliers('STD',ARm);
            ARs(ARind)=nan;
            %         ARnew(ARind)=[];%nan;
            
            DJm = [squeeze(Reach.DJ(1,subj,:,1));0;squeeze(Reach.DJ(1,subj,:,2));0;squeeze(Reach.DJ(1,subj,:,3))];
            DJs = [squeeze(Reach.DJ(2,subj,:,1));0;squeeze(Reach.DJ(2,subj,:,2));0;squeeze(Reach.DJ(2,subj,:,3))];
            DJm(DJm==0)=nan;
            DJs(DJs==0)=nan;
            [DJnew,DJind]=remove_outliers('STD',DJm);
            DJs(DJind)=nan;
            %         DJnew(DJind)=[];%nan;
            
            LIm = [squeeze(Reach.LI(1,subj,:,1));0;squeeze(Reach.LI(1,subj,:,2));0;squeeze(Reach.LI(1,subj,:,3))];
            LIs = [squeeze(Reach.LI(2,subj,:,1));0;squeeze(Reach.LI(2,subj,:,2));0;squeeze(Reach.LI(2,subj,:,3))];
            LIm(LIm==0)=nan;
            LIs(LIs==0)=nan;
            [LInew,LIind]=remove_outliers('STD',LIm);
            LIs(LIind)=nan;
            %         LInew(LIind)=[];%nan;
            
            NPm = [squeeze(Reach.NP(1,subj,:,1));0;squeeze(Reach.NP(1,subj,:,2));0;squeeze(Reach.NP(1,subj,:,3))];
            NPs = [squeeze(Reach.NP(2,subj,:,1));0;squeeze(Reach.NP(2,subj,:,2));0;squeeze(Reach.NP(2,subj,:,3))];
            NPm(NPm==0)=nan;
            NPs(NPs==0)=nan;
            [NPnew,NPind]=remove_outliers('STD',NPm);
            NPs(NPind)=nan;
            %         NPnew(NPind)=[];%nan;
        end
        % Movement Time
        figure(1)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(MTnew)+max(MTs) max(MTnew)+max(MTs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(MTnew)+max(MTs) max(MTnew)+max(MTs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(MTnew)+max(MTs) max(MTnew)+max(MTs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(MTnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(MTnew)+max(MTs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(MTnew)+max(MTs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(MTnew)+max(MTs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(MTnew)+max(MTs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(MTnew)+max(MTs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(MTnew)+max(MTs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(MTnew)+max(MTs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(MTnew)+max(MTs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(MTnew)+max(MTs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(MTnew)+max(MTs)]);
        ylabel('MT [s]','FontSize',15)
        hold on
        h=errorbar(MTnew,MTs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        %
        % % Path Lenght
        %
        figure(2)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(PLnew)+max(PLs) max(PLnew)+max(PLs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(PLnew)+max(PLs) max(PLnew)+max(PLs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(PLnew)+max(PLs) max(PLnew)+max(PLs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(PLnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(PLnew)+max(PLs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(PLnew)+max(PLs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(PLnew)+max(PLs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(PLnew)+max(PLs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(PLnew)+max(PLs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(PLnew)+max(PLs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(PLnew)+max(PLs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(PLnew)+max(PLs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(PLnew)+max(PLs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(PLnew)+max(PLs)]);
        ylabel('PL [px]','FontSize',15)
        hold on
        h=errorbar(PLnew,PLs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        
        %
        % %RT
        figure(3)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(RTnew)+max(RTs) max(RTnew)+max(RTs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(RTnew)+max(RTs) max(RTnew)+max(RTs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(RTnew)+max(RTs) max(RTnew)+max(RTs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(RTnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(RTnew)+max(RTs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(RTnew)+max(RTs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(RTnew)+max(RTs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(RTnew)+max(RTs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(RTnew)+max(RTs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(RTnew)+max(RTs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(RTnew)+max(RTs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(RTnew)+max(RTs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(RTnew)+max(RTs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(RTnew)+max(RTs)]);
        ylabel('RT [s]','FontSize',15)
        hold on
        h=errorbar(RTnew,RTs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        
        
        %MA
        figure(4)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(MAnew)+max(MAs) max(MAnew)+max(MAs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(MAnew)+max(MAs) max(MAnew)+max(MAs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(MAnew)+max(MAs) max(MAnew)+max(MAs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(MAnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(MAnew)+max(MAs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(MAnew)+max(MAs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(MAnew)+max(MAs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(MAnew)+max(MAs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(MAnew)+max(MAs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(MAnew)+max(MAs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(MAnew)+max(MAs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(MAnew)+max(MAs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(MAnew)+max(MAs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(MAnew)+max(MAs)]);
        ylabel('MA [px]','FontSize',15)
        hold on
        h=errorbar(MAnew,MAs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        
        
        %EndPointErr
        figure(5)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(EEnew)+max(EEs) max(EEnew)+max(EEs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(EEnew)+max(EEs) max(EEnew)+max(EEs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(EEnew)+max(EEs) max(EEnew)+max(EEs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(EEnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(EEnew)+max(EEs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(EEnew)+max(EEs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(EEnew)+max(EEs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(EEnew)+max(EEs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(EEnew)+max(EEs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(EEnew)+max(EEs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(EEnew)+max(EEs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(EEnew)+max(EEs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(EEnew)+max(EEs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(EEnew)+max(EEs)]);
        ylabel('EndPointErr [px]','FontSize',15)
        hold on
        h=errorbar(EEnew,EEs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        
        %AR
        figure(6)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(ARnew)+max(ARs) max(ARnew)+max(ARs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(ARnew)+max(ARs) max(ARnew)+max(ARs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(ARnew)+max(ARs) max(ARnew)+max(ARs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(ARnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(ARnew)+max(ARs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(ARnew)+max(ARs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(ARnew)+max(ARs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(ARnew)+max(ARs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(ARnew)+max(ARs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(ARnew)+max(ARs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(ARnew)+max(ARs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(ARnew)+max(ARs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(ARnew)+max(ARs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(ARnew)+max(ARs)]);
        ylabel('AR [-]','FontSize',15)
        hold on
        h=errorbar(ARnew,ARs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        
        %DJ
        figure(7)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(DJnew)+max(DJs) max(DJnew)+max(DJs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(DJnew)+max(DJs) max(DJnew)+max(DJs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(DJnew)+max(DJs) max(DJnew)+max(DJs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(DJnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(DJnew)+max(DJs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(DJnew)+max(DJs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(DJnew)+max(DJs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(DJnew)+max(DJs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(DJnew)+max(DJs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(DJnew)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(DJnew)+max(DJs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(DJnew)+max(DJs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(DJnew)+max(DJs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(DJnew)+max(DJs)]);
        ylabel('Jerk [-]','FontSize',15)
        hold on
        h=errorbar(DJnew,DJs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        
        %LI
        figure(8)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(LInew)+max(LIs) max(LInew)+max(LIs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(LInew)+max(LIs) max(LInew)+max(LIs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(LInew)+max(LIs) max(LInew)+max(LIs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(LInew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(LInew)+max(LIs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(LInew)+max(LIs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(LInew)+max(LIs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(LInew)+max(LIs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(LInew)+max(LIs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(LInew)+max(LIs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(LInew)+max(LIs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(LInew)+max(LIs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(LInew)+max(LIs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(LInew)+max(LIs)]);
        ylabel('LI [-]','FontSize',15)
        hold on
        h=errorbar(LInew,LIs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
        
        %NP
        figure(9)
        subplot(2,2,subj)
        patch([0.5 10.5 10.5 0.5],[0 0 max(NPnew)+max(NPs) max(NPnew)+max(NPs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 10.5 10.5 0.5]+11,[0 0 max(NPnew)+max(NPs) max(NPnew)+max(NPs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 10.5 10.5 0.5]+22,[0 0 max(NPnew)+max(NPs) max(NPnew)+max(NPs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(NPnew,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(NPnew)+max(NPs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+11,[0 max(NPnew)+max(NPs)],'col','r')
            hr=line([rows_x+0.4 rows_x+0.4]+22,[0 max(NPnew)+max(NPs)],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(NPnew)+max(NPs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+11,[0 max(NPnew)+max(NPs)],'col','g')
            hg=line([rows_y+0.5 rows_y+0.5]+22,[0 max(NPnew)+max(NPs)],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(NPnew)+max(NPs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+11,[0 max(NPnew)+max(NPs)],'col','k')
            hk=line([rows_z+0.6 rows_z+0.6]+22,[0 max(NPnew)+max(NPs)],'col','k')
        end
        set(gca,'XTick',[5 16 27],'XTickLabel',{'H','V','C'});
        xlim([0 33]);
        ylim([0 max(NPnew)+max(NPs)]);
        ylabel('NP [-]','FontSize',15)
        hold on
        h=errorbar(NPnew,NPs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',soggetti{subj}])
    else
        if strcmp(flag,'rec_reach')
            first = min(find(Reach.MT(1,subj,:,1)~=0));
            last = max(find(Reach.MT(1,subj,:,1)~=0));
            MTm=[squeeze(Reach.MT(1,subj,[first last],1));0;squeeze(Reach.MT(1,subj,[first last],2))];
            MTs=[squeeze(Reach.MT(2,subj,[first last],1));0;squeeze(Reach.MT(2,subj,[first last],2))];
            MTm(MTm==0)=nan;
            MTs(MTs==0)=nan;
            %             [MTnew,MTind]=remove_outliers('STD',MTm);
            %             MTs(MTind)=nan;
            %         MTnew(MTind)=[];%nan;
            
            PLm = [squeeze(Reach.PL(1,subj,[first last],1));0;squeeze(Reach.PL(1,subj,[first last],2))];
            PLs=[squeeze(Reach.PL(2,subj,[first last],1));0;squeeze(Reach.PL(2,subj,[first last],2))];
            PLm(PLm==0)=nan;
            PLs(PLs==0)=nan;
            %             [PLnew,PLind]=remove_outliers('STD',PLm);
            %             PLs(PLind)=nan;
            %         PLnew(PLind)=[];%nan;
            
            RTm = [squeeze(Reach.RT(1,subj,[first last],1));0;squeeze(Reach.RT(1,subj,[first last],2))];
            RTs = [squeeze(Reach.RT(2,subj,[first last],1));0;squeeze(Reach.RT(2,subj,[first last],2))];
            RTm(RTm==0)=nan;
            RTs(RTs==0)=nan;
            %             [RTnew,RTind]=remove_outliers('STD',RTm);
            %             RTs(RTind)=nan;
            %         RTnew(RTind)=[];%nan;
            
            MAm = [squeeze(Reach.MA(1,subj,[first last],1));0;squeeze(Reach.MA(1,subj,[first last],2))];
            MAs = [squeeze(Reach.MA(2,subj,[first last],1));0;squeeze(Reach.MA(2,subj,[first last],2))];
            MAm(MAm==0)=nan;
            MAs(MAs==0)=nan;
            %             [MAnew,MAind]=remove_outliers('STD',MAm);
            %             MAs(MAind)=nan;
            %         MAnew(MAind)=[];%nan;
            
            EEm = [squeeze(Reach.EndPointErr(1,subj,[first last],1));0;squeeze(Reach.EndPointErr(1,subj,[first last],2))];
            EEs = [squeeze(Reach.EndPointErr(2,subj,[first last],1));0;squeeze(Reach.EndPointErr(2,subj,[first last],2))];
            EEm(EEm==0)=nan;
            EEs(EEs==0)=nan;
            %             [EEnew,EEind]=remove_outliers('STD',EEm);
            %             EEs(EEind)=nan;
            %         EEnew(EEind)=[];%nan;
            
            ARm = [squeeze(Reach.AR(1,subj,[first last],1));0;squeeze(Reach.AR(1,subj,[first last],2))];
            ARs = [squeeze(Reach.AR(2,subj,[first last],1));0;squeeze(Reach.AR(2,subj,[first last],2))];
            ARm(ARm==0)=nan;
            ARs(ARs==0)=nan;
            %             [ARnew,ARind]=remove_outliers('STD',ARm);
            %             ARs(ARind)=nan;
            %         ARnew(ARind)=[];%nan;
            
            DJm = [squeeze(Reach.DJ(1,subj,[first last],1));0;squeeze(Reach.DJ(1,subj,[first last],2))];
            DJs = [squeeze(Reach.DJ(2,subj,[first last],1));0;squeeze(Reach.DJ(2,subj,[first last],2))];
            DJm(DJm==0)=nan;
            DJs(DJs==0)=nan;
            %             [DJnew,DJind]=remove_outliers('STD',DJm);
            %             DJs(DJind)=nan;
            %         DJnew(DJind)=[];%nan;
            
            LIm = [squeeze(Reach.LI(1,subj,[first last],1));0;squeeze(Reach.LI(1,subj,[first last],2))];
            LIs = [squeeze(Reach.LI(2,subj,[first last],1));0;squeeze(Reach.LI(2,subj,[first last],2))];
            LIm(LIm==0)=nan;
            LIs(LIs==0)=nan;
            %             [LInew,LIind]=remove_outliers('STD',LIm);
            %             LIs(LIind)=nan;
            %         LInew(LIind)=[];%nan;
            
            NPm = [squeeze(Reach.NP(1,subj,[first last],1));0;squeeze(Reach.NP(1,subj,[first last],2))];
            NPs = [squeeze(Reach.NP(2,subj,[first last],1));0;squeeze(Reach.NP(2,subj,[first last],2))];
            NPm(NPm==0)=nan;
            NPs(NPs==0)=nan;
            %             [NPnew,NPind]=remove_outliers('STD',NPm);
            %             NPs(NPind)=nan;
            %         NPnew(NPind)=[];%nan;
        else
            
            
            
            first = min(find(Reach.MT(1,subj,:,1)~=0));
            last = max(find(Reach.MT(1,subj,:,1)~=0));
            firstc = min(find(Reach.MT(1,subj,:,3)~=0));
            lastc = max(find(Reach.MT(1,subj,:,3)~=0));
            MTm=[squeeze(Reach.MT(1,subj,[first last],1));0;squeeze(Reach.MT(1,subj,[first last],2));0;squeeze(Reach.MT(1,subj,[firstc lastc],3))];
            MTs=[squeeze(Reach.MT(2,subj,[first last],1));0;squeeze(Reach.MT(2,subj,[first last],2));0;squeeze(Reach.MT(2,subj,[firstc lastc],3))];
            MTm(MTm==0)=nan;
            MTs(MTs==0)=nan;
            %             [MTnew,MTind]=remove_outliers('STD',MTm);
            %             MTs(MTind)=nan;
            %         MTnew(MTind)=[];%nan;
            
            PLm = [squeeze(Reach.PL(1,subj,[first last],1));0;squeeze(Reach.PL(1,subj,[first last],2));0;squeeze(Reach.PL(1,subj,[firstc lastc],3))];
            PLs=[squeeze(Reach.PL(2,subj,[first last],1));0;squeeze(Reach.PL(2,subj,[first last],2));0;squeeze(Reach.PL(2,subj,[firstc lastc],3))];
            PLm(PLm==0)=nan;
            PLs(PLs==0)=nan;
            %             [PLnew,PLind]=remove_outliers('STD',PLm);
            %             PLs(PLind)=nan;
            %         PLnew(PLind)=[];%nan;
            
            RTm = [squeeze(Reach.RT(1,subj,[first last],1));0;squeeze(Reach.RT(1,subj,[first last],2));0;squeeze(Reach.RT(1,subj,[firstc lastc],3))];
            RTs = [squeeze(Reach.RT(2,subj,[first last],1));0;squeeze(Reach.RT(2,subj,[first last],2));0;squeeze(Reach.RT(2,subj,[firstc lastc],3))];
            RTm(RTm==0)=nan;
            RTs(RTs==0)=nan;
            %             [RTnew,RTind]=remove_outliers('STD',RTm);
            %             RTs(RTind)=nan;
            %         RTnew(RTind)=[];%nan;
            
            MAm = [squeeze(Reach.MA(1,subj,[first last],1));0;squeeze(Reach.MA(1,subj,[first last],2));0;squeeze(Reach.MA(1,subj,[firstc lastc],3))];
            MAs = [squeeze(Reach.MA(2,subj,[first last],1));0;squeeze(Reach.MA(2,subj,[first last],2));0;squeeze(Reach.MA(2,subj,[firstc lastc],3))];
            MAm(MAm==0)=nan;
            MAs(MAs==0)=nan;
            %             [MAnew,MAind]=remove_outliers('STD',MAm);
            %             MAs(MAind)=nan;
            %         MAnew(MAind)=[];%nan;
            
            EEm = [squeeze(Reach.EndPointErr(1,subj,[first last],1));0;squeeze(Reach.EndPointErr(1,subj,[first last],2));0;squeeze(Reach.EndPointErr(1,subj,[firstc lastc],3))];
            EEs = [squeeze(Reach.EndPointErr(2,subj,[first last],1));0;squeeze(Reach.EndPointErr(2,subj,[first last],2));0;squeeze(Reach.EndPointErr(2,subj,[firstc lastc],3))];
            EEm(EEm==0)=nan;
            EEs(EEs==0)=nan;
            %             [EEnew,EEind]=remove_outliers('STD',EEm);
            %             EEs(EEind)=nan;
            %         EEnew(EEind)=[];%nan;
            
            ARm = [squeeze(Reach.AR(1,subj,[first last],1));0;squeeze(Reach.AR(1,subj,[first last],2));0;squeeze(Reach.AR(1,subj,[firstc lastc],3))];
            ARs = [squeeze(Reach.AR(2,subj,[first last],1));0;squeeze(Reach.AR(2,subj,[first last],2));0;squeeze(Reach.AR(2,subj,[firstc lastc],3))];
            ARm(ARm==0)=nan;
            ARs(ARs==0)=nan;
            %             [ARnew,ARind]=remove_outliers('STD',ARm);
            %             ARs(ARind)=nan;
            %         ARnew(ARind)=[];%nan;
            
            DJm = [squeeze(Reach.DJ(1,subj,[first last],1));0;squeeze(Reach.DJ(1,subj,[first last],2));0;squeeze(Reach.DJ(1,subj,[firstc lastc],3))];
            DJs = [squeeze(Reach.DJ(2,subj,[first last],1));0;squeeze(Reach.DJ(2,subj,[first last],2));0;squeeze(Reach.DJ(2,subj,[firstc lastc],3))];
            DJm(DJm==0)=nan;
            DJs(DJs==0)=nan;
            %             [DJnew,DJind]=remove_outliers('STD',DJm);
            %             DJs(DJind)=nan;
            %         DJnew(DJind)=[];%nan;
            
            LIm = [squeeze(Reach.LI(1,subj,[first last],1));0;squeeze(Reach.LI(1,subj,[first last],2));0;squeeze(Reach.LI(1,subj,[firstc lastc],3))];
            LIs = [squeeze(Reach.LI(2,subj,[first last],1));0;squeeze(Reach.LI(2,subj,[first last],2));0;squeeze(Reach.LI(2,subj,[firstc lastc],3))];
            LIm(LIm==0)=nan;
            LIs(LIs==0)=nan;
            %             [LInew,LIind]=remove_outliers('STD',LIm);
            %             LIs(LIind)=nan;
            %         LInew(LIind)=[];%nan;
            
            NPm = [squeeze(Reach.NP(1,subj,[first last],1));0;squeeze(Reach.NP(1,subj,[first last],2));0;squeeze(Reach.NP(1,subj,[firstc lastc],3))];
            NPs = [squeeze(Reach.NP(2,subj,[first last],1));0;squeeze(Reach.NP(2,subj,[first last],2));0;squeeze(Reach.NP(2,subj,[firstc lastc],3))];
            NPm(NPm==0)=nan;
            NPs(NPs==0)=nan;
            %             [NPnew,NPind]=remove_outliers('STD',NPm);
            %             NPs(NPind)=nan;
            %         NPnew(NPind)=[];%nan;
        end
        % Movement Time
        figure(1)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(MTm)+max(MTs) max(MTm)+max(MTs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(MTm)+max(MTs) max(MTm)+max(MTs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(MTm)+max(MTs) max(MTm)+max(MTs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(MTm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(MTm)+max(MTs)]);
        ylabel('MT [s]','FontSize',15)
        hold on
        h=errorbar(MTm,MTs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        %
        % % Path Lenght
        %
        figure(2)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(PLm)+max(PLs) max(PLm)+max(PLs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(PLm)+max(PLs) max(PLm)+max(PLs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(PLm)+max(PLs) max(PLm)+max(PLs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(PLm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        sz=[1 1 1024 768];
        dist = ceil(sz(4)/2)*0.8;
        line([0 9],[dist dist],'col','r','linestyle',':')
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(PLm)+max(PLs)]);
        ylabel('PL [px]','FontSize',15)
        hold on
        h=errorbar(PLm,PLs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        
        %
        % %RT
        figure(3)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(RTm)+max(RTs) max(RTm)+max(RTs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(RTm)+max(RTs) max(RTm)+max(RTs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(RTm)+max(RTs) max(RTm)+max(RTs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(RTm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(RTm)+max(RTs)]);
        ylabel('RT [s]','FontSize',15)
        hold on
        h=errorbar(RTm,RTs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        
        
        %MA
        figure(4)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(MAm)+max(MAs) max(MAm)+max(MAs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(MAm)+max(MAs) max(MAm)+max(MAs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(MAm)+max(MAs) max(MAm)+max(MAs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(MAm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(MAm)+max(MAs)]);
        ylabel('MA [px]','FontSize',15)
        hold on
        h=errorbar(MAm,MAs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        
        
        %EndPointErr
        figure(5)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(EEm)+max(EEs) max(EEm)+max(EEs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(EEm)+max(EEs) max(EEm)+max(EEs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(EEm)+max(EEs) max(EEm)+max(EEs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(EEm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(EEm)+max(EEs)]);
        ylabel('EndPointErr [px]','FontSize',15)
        hold on
        h=errorbar(EEm,EEs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        
        %AR
        figure(6)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(ARm)+max(ARs) max(ARm)+max(ARs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(ARm)+max(ARs) max(ARm)+max(ARs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(ARm)+max(ARs) max(ARm)+max(ARs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(ARm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(ARm)+max(ARs)]);
        ylabel('AR [-]','FontSize',15)
        hold on
        h=errorbar(ARm,ARs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        
        %DJ
        figure(7)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(DJm)+max(DJs) max(DJm)+max(DJs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(DJm)+max(DJs) max(DJm)+max(DJs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(DJm)+max(DJs) max(DJm)+max(DJs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(DJm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(DJm)+max(DJs)]);
        ylabel('Jerk [-]','FontSize',15)
        hold on
        h=errorbar(DJm,DJs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        
        %LI
        figure(8)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(LIm)+max(LIs) max(LIm)+max(LIs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(LIm)+max(LIs) max(LIm)+max(LIs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(LIm)+max(LIs) max(LIm)+max(LIs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(LIm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(LIm)+max(LIs)]);
        ylabel('LI [-]','FontSize',15)
        hold on
        h=errorbar(LIm,LIs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
        
        %NP
        figure(9)
        subplot(2,2,subj)
        patch([0.5 2.5 2.5 0.5],[0 0 max(NPm)+max(NPs) max(NPm)+max(NPs)],[0.8 0.8 0.8],'edgecolor','none')
        hold on
        patch([0.5 2.5 2.5 0.5]+3,[0 0 max(NPm)+max(NPs) max(NPm)+max(NPs)],[0.8 0.8 0.8],'edgecolor','none')
        patch([0.5 2.5 2.5 0.5]+6,[0 0 max(NPm)+max(NPs) max(NPm)+max(NPs)],[0.8 0.8 0.8],'edgecolor','none')
        bar(NPm,0.85,'facecolor',[0 0.45 0.74]);%grafica le barre
        set(gca,'XTick',[1.5 4.5 7.5],'XTickLabel',{'H','V','C'});
        xlim([0 9]);
        ylim([0 max(NPm)+max(NPs)]);
        ylabel('NP [-]','FontSize',15)
        hold on
        h=errorbar(NPm,NPs,'k');%grafica la dev standard sulle barre
        set(h,'linestyle','none')
        box off
        % set(gcf,'color',[1 1 1]);
        title(['Subject: ',num2str(subj)])
    end
end
figure(1)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'MT',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'MT',num2str(training),'.eps'])
figure(2)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'PL',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'PL',num2str(training),'.eps'])

figure(3)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'RT',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'RT',num2str(training),'.eps'])

figure(4)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'MA',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'MA',num2str(training),'.eps'])

figure(5)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'EE',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'EE',num2str(training),'.eps'])

figure(6)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'AR',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'AR',num2str(training),'.eps'])

figure(7)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'DJ',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'DJ',num2str(training),'.eps'])

figure(8)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'LI',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'LI',num2str(training),'.eps'])

figure(9)
saveas(gcf,['figs',filesep,'performance',filesep,flag,filesep,'NP',num2str(training)],'png')
print2eps(['figs',filesep,'performance',filesep,flag,filesep,'NP',num2str(training),'.eps'])
