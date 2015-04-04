function PostureAnalysis(datadir)
% This function analyze the delta(pelvis) and delta(shoulder) of the
% subject when he/she acqured the target during the three reaching
% exercises: horizontal, vertical and cross
% from the kinect matrix what we need are the following columns:
% LEFT SHOULDER 13:15
% RIGHT SHOULDER 25:27
% LEFT PELVIS 37:39
% RIGHT PELVIS 49:51

%nella cartella datadir c'? una cartella per ogni soggetto che contiene
%tutti i dati
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
ReachBodyPosture=load(['mats',filesep,'ReachKinectData']);
stop=load(['mats',filesep,'stop']);
trgt_seq=load(['mats',filesep,'targetseq']);
deltaShoulder_x=nan.*ones(length(soggetti),10,3,4);
deltaShoulder_y=nan.*ones(length(soggetti),10,3,4);
deltaShoulder_z=nan.*ones(length(soggetti),10,3,4);
deltaPelvis_x=nan.*ones(length(soggetti),10,3,4);
deltaPelvis_y=nan.*ones(length(soggetti),10,3,4);
deltaPelvis_z=nan.*ones(length(soggetti),10,3,4);
CalibPosture=load(['mats',filesep,'Mappe']);

for subj=1:length(soggetti)
    %similmente a prima, dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
    if maxsess>10
        display('WARNING! Sessions more than 10');
        keyboard
    end
    [threshold{subj}]=importThresholds(soggetti{subj});
    
    rows_x =find(diff(threshold{subj}(:,1))~=0);
    rows_y =find(diff(threshold{subj}(:,2))~=0);
    rows_z =find(diff(threshold{subj}(:,3))~=0);
    
    for g=1:3
        if g==1
            seq=trgt_seq.horizseq;
        elseif g==2
            seq=trgt_seq.vertseq;
        else
            seq=trgt_seq.crossseq;
        end
        switch g
            case 1
                Reach='Reach H';
            case 2
                Reach='Reach V';
            case 3
                Reach='Reach C';
        end
        
        for sess=1:maxsess
            if g==1
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    post=CalibPosture.ind{sess,subj}.A_oPosture(3:4,:);
                else
                    post=CalibPosture.ind{sess,subj}.APosture(3:4,:);
                end
            elseif g==2
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    post=CalibPosture.ind{sess,subj}.A_vPosture(1:2,:);
                else
                    post=CalibPosture.ind{sess,subj}.APosture(1:2,:);
                end
            else
                post=CalibPosture.ind{sess,subj}.APosture;
            end
            if (isempty(ReachBodyPosture.ind{subj,sess,g}) | isnan(ReachBodyPosture.ind{subj,sess,g}))
                deltaShoulder_x(subj,sess,g,4)=nan;
                deltaShoulder_y(subj,sess,g,4)=nan;
                deltaShoulder_z(subj,sess,g,4)=nan;
                deltaPelvis_x(subj,sess,g,4)=nan;
                deltaPelvis_y(subj,sess,g,4)=nan;
                deltaPelvis_z(subj,sess,g,4)=nan;
            else
                if g==3
                    tgt1 = ReachBodyPosture.ind{subj,sess,g}(stop.ind{subj,sess,g}(find(seq{subj,sess}==1)),:);
                    tgt2 = ReachBodyPosture.ind{subj,sess,g}(stop.ind{subj,sess,g}(find(seq{subj,sess}==2)),:);
                    tgt3 = ReachBodyPosture.ind{subj,sess,g}(stop.ind{subj,sess,g}(find(seq{subj,sess}==3)),:);
                    tgt4 = ReachBodyPosture.ind{subj,sess,g}(stop.ind{subj,sess,g}(find(seq{subj,sess}==4)),:);
                    if size(tgt1,1)~=size(tgt2,1)~=size(tgt3,1)~=size(tgt4,1)
                        [u,j]=max([size(tgt1,1),size(tgt2,1),size(tgt3,1),size(tgt4,1)]);
                        
                        tgt1=cat(1,tgt1,repmat(nan,abs(diff([size(tgt1,1),u])),size(tgt1,2)));%./repmat(post(1,:),u,1);
                        try
                        tgt2=cat(1,tgt2,repmat(nan,abs(diff([size(tgt2,1),u])),size(tgt2,2)));%./repmat(post(3,:),u,1);
                        catch
                            keyboard
                        end
                        tgt3=cat(1,tgt3,repmat(nan,abs(diff([size(tgt3,1),u])),size(tgt3,2)));%./repmat(post(2,:),u,1);
                        
                        tgt4=cat(1,tgt4,repmat(nan,abs(diff([size(tgt4,1),u])),size(tgt4,2)));%./repmat(post(4,:),u,1);
                        
                    end
                    Posture = cat(3,tgt1,tgt2,tgt3,tgt4);
                    deltaShoulder_x(subj,sess,g,:)=nanmean(Posture(:,13,:)-Posture(:,25,:));
                    deltaShoulder_y(subj,sess,g,:)=nanmean(Posture(:,14,:)-Posture(:,26,:));
                    deltaShoulder_z(subj,sess,g,:)=nanmean(Posture(:,15,:)-Posture(:,27,:));
                    deltaPelvis_x(subj,sess,g,:)=nanmean(Posture(:,37,:)-Posture(:,49,:));
                    deltaPelvis_y(subj,sess,g,:)=nanmean(Posture(:,38,:)-Posture(:,50,:));
                    deltaPelvis_z(subj,sess,g,:)=nanmean(Posture(:,39,:)-Posture(:,51,:));
                else
                    tgt1 = ReachBodyPosture.ind{subj,sess,g}(stop.ind{subj,sess,g}(find(seq{subj,sess}==1)),:);
                    tgt2 = ReachBodyPosture.ind{subj,sess,g}(stop.ind{subj,sess,g}(find(seq{subj,sess}==2)),:);
                    if size(tgt1,1)~=size(tgt2,1)
                        [v,i]=min([size(tgt1,1),size(tgt2,1)]);
                        if i==1
                            tgt1=cat(1,tgt1,repmat(nan,abs(diff([size(tgt1,1),size(tgt2,1)])),size(tgt1,2)));
                        else
                            tgt2=cat(1,tgt2,repmat(nan,abs(diff([size(tgt1,1),size(tgt2,1)])),size(tgt2,2)));
                        end
                    end
%                     Posture = cat(3,tgt1./repmat(post(1,:),size(tgt1,1),1),tgt2./repmat(post(2,:),size(tgt2,1),1));
                    Posture = cat(3,tgt1,tgt2);
                    deltaShoulder_x(subj,sess,g,1:2)=nanmean(Posture(:,13,:)-Posture(:,25,:));
                    deltaShoulder_y(subj,sess,g,1:2)=nanmean(Posture(:,14,:)-Posture(:,26,:));
                    deltaShoulder_z(subj,sess,g,1:2)=nanmean(Posture(:,15,:)-Posture(:,27,:));
                    deltaPelvis_x(subj,sess,g,1:2)=nanmean(Posture(:,37,:)-Posture(:,49,:));
                    deltaPelvis_y(subj,sess,g,1:2)=nanmean(Posture(:,38,:)-Posture(:,50,:));
                    deltaPelvis_z(subj,sess,g,1:2)=nanmean(Posture(:,39,:)-Posture(:,51,:));
                end
            end
            
        end %sess
        for cc=1:size(deltaShoulder_x,4)
            if isnan(deltaShoulder_x(subj,:,g,cc))
                continue
            end
            limShoulder_Mo=max([max(deltaShoulder_x(subj,:,g,cc)) max(deltaShoulder_y(subj,:,g,cc)) max(deltaShoulder_z(subj,:,g,cc))]);
            limPelvis_Mo=max([max(deltaPelvis_x(subj,:,g,cc)) max(deltaPelvis_y(subj,:,g,cc)) max(deltaPelvis_z(subj,:,g,cc))]);
            limShoulder_mo=min([min(deltaShoulder_x(subj,:,g,cc)) min(deltaShoulder_y(subj,:,g,cc)) min(deltaShoulder_z(subj,:,g,cc))]);
            limPelvis_mo=min([min(deltaPelvis_x(subj,:,g,cc)) min(deltaPelvis_y(subj,:,g,cc)) min(deltaPelvis_z(subj,:,g,cc))]);
            h1=figure;
            subplot(2,3,1)
            bar(deltaShoulder_x(subj,:,g,cc))
            if isempty(rows_x)==0
                if length(rows_x)==2
                    rows_x=[rows_x;nan];
                end
                hr=line([rows_x+0.4 rows_x+0.4],[0 max(deltaShoulder_x(subj,:,g,cc))],'col','r')
            end
            if isempty(rows_y)==0
                if length(rows_y)==2
                    rows_y=[rows_y;nan];
                end
                hg=line([rows_y+0.5 rows_y+0.5],[0 max(deltaShoulder_x(subj,:,g,cc))],'col','g')
            end
            if isempty(rows_z)==0
                if length(rows_z)==2
                    rows_z=[rows_z;nan];
                end
                hk=line([rows_z+0.6 rows_z+0.6],[0 max(deltaShoulder_x(subj,:,g,cc))],'col','k')
            end
            title(['L-RSh(x)', Reach])
            try
            ylim([limShoulder_mo limShoulder_Mo])
            catch
                keyboard
            end
%             legend([hr(1) hg(1) hk(1)],{'x','y','z'})
            box off
            subplot(2,3,2)
            bar(deltaShoulder_y(subj,:,g,cc))
            if isempty(rows_x)==0
                if length(rows_x)==2
                    rows_x=[rows_x;nan];
                end
                hr=line([rows_x+0.4 rows_x+0.4],[0 max(deltaShoulder_y(subj,:,g,cc))],'col','r')
            end
            if isempty(rows_y)==0
                if length(rows_y)==2
                    rows_y=[rows_y;nan];
                end
                hg=line([rows_y+0.5 rows_y+0.5],[0 max(deltaShoulder_y(subj,:,g,cc))],'col','g')
            end
            if isempty(rows_z)==0
                if length(rows_z)==2
                    rows_z=[rows_z;nan];
                end
                hk=line([rows_z+0.6 rows_z+0.6],[0 max(deltaShoulder_y(subj,:,g,cc))],'col','k')
            end
            title(['L-RSh(y)', Reach])
            ylim([limShoulder_mo limShoulder_Mo])
%             legend([hr(1) hg(1) hk(1)],{'x','y','z'})
            box off
            subplot(2,3,3)
            bar(deltaShoulder_z(subj,:,g,cc))
            if isempty(rows_x)==0
                if length(rows_x)==2
                    rows_x=[rows_x;nan];
                end
                hr=line([rows_x+0.4 rows_x+0.4],[0 max(deltaShoulder_z(subj,:,g,cc))],'col','r')
            end
            if isempty(rows_y)==0
                if length(rows_y)==2
                    rows_y=[rows_y;nan];
                end
                hg=line([rows_y+0.5 rows_y+0.5],[0 max(deltaShoulder_z(subj,:,g,cc))],'col','g')
            end
            if isempty(rows_z)==0
                if length(rows_z)==2
                    rows_z=[rows_z;nan];
                end
                hk=line([rows_z+0.6 rows_z+0.6],[0 max(deltaShoulder_z(subj,:,g,cc))],'col','k')
            end
            title(['L-RSh(z)', Reach])
            ylim([limShoulder_mo limShoulder_Mo])
            legend([hr(1) hg(1) hk(1)],{'x','y','z'})
            box off
            subplot(2,3,4)
            bar(deltaPelvis_x(subj,:,g,cc))
            if isempty(rows_x)==0
                if length(rows_x)==2
                    rows_x=[rows_x;nan];
                end
                hr=line([rows_x+0.4 rows_x+0.4],[0 max(deltaPelvis_x(subj,:,g,cc))],'col','r')
            end
            if isempty(rows_y)==0
                if length(rows_y)==2
                    rows_y=[rows_y;nan];
                end
                hg=line([rows_y+0.5 rows_y+0.5],[0 max(deltaPelvis_x(subj,:,g,cc))],'col','g')
            end
            if isempty(rows_z)==0
                if length(rows_z)==2
                    rows_z=[rows_z;nan];
                end
                hk=line([rows_z+0.6 rows_z+0.6],[0 max(deltaPelvis_x(subj,:,g,cc))],'col','k')
            end
            title(['L-RPelv(x)', Reach])
            ylim([limPelvis_mo limPelvis_Mo])
%             legend([hr(1) hg(1) hk(1)],{'x','y','z'})
            box off
            subplot(2,3,5)
            bar(deltaPelvis_y(subj,:,g,cc))
            if isempty(rows_x)==0
                if length(rows_x)==2
                    rows_x=[rows_x;nan];
                end
                hr=line([rows_x+0.4 rows_x+0.4],[0 max(deltaPelvis_y(subj,:,g,cc))],'col','r')
            end
            if isempty(rows_y)==0
                if length(rows_y)==2
                    rows_y=[rows_y;nan];
                end
                hg=line([rows_y+0.5 rows_y+0.5],[0 max(deltaPelvis_y(subj,:,g,cc))],'col','g')
            end
            if isempty(rows_z)==0
                if length(rows_z)==2
                    rows_z=[rows_z;nan];
                end
                hk=line([rows_z+0.6 rows_z+0.6],[0 max(deltaPelvis_y(subj,:,g,cc))],'col','k')
            end
            title(['L-RPelv(y)', Reach])
            ylim([limPelvis_mo limPelvis_Mo])
%             legend([hr(1) hg(1) hk(1)],{'x','y','z'})
            box off
            subplot(2,3,6)
            bar(deltaPelvis_z(subj,:,g,cc))
            if isempty(rows_x)==0
                if length(rows_x)==2
                    rows_x=[rows_x;nan];
                end
                hr=line([rows_x+0.4 rows_x+0.4],[0 max(deltaPelvis_z(subj,:,g,cc))],'col','r')
            end
            if isempty(rows_y)==0
                if length(rows_y)==2
                    rows_y=[rows_y;nan];
                end
                hg=line([rows_y+0.5 rows_y+0.5],[0 max(deltaPelvis_z(subj,:,g,cc))],'col','g')
            end
            if isempty(rows_z)==0
                if length(rows_z)==2
                    rows_z=[rows_z;nan];
                end
                hk=line([rows_z+0.6 rows_z+0.6],[0 max(deltaPelvis_z(subj,:,g,cc))],'col','k')
            end
            title(['L-RPelv(z)', Reach])
            ylim([limPelvis_mo limPelvis_Mo])
%             legend([hr(1) hg(1) hk(1)],{'x','y','z'})
            box off
            suptitle(['Target',num2str(cc)])
            saveas(h1,['figs',filesep,'delta',filesep,soggetti{subj},'Reach',num2str(g),'_deltaShPel',num2str(cc)],'png')
            close
        end %dir trgts
    end % g
    
end%subject
end