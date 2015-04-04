function ComputeDeltaPos(datadir)
%PlotHipDistanceinMap valuta distanza tra marker in fase di esercizio
%   Detailed explanation goes here

% markers = {'hipc','spine','shc','head','shl','elbl','wristl','handl','shr','elbr','wristr','handr','hipl','kneel','anklel','footl','hipr','kneer','ankler','footr'};
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
A=load(['mats',filesep,'ReachKinectData']); %marker in system body
tit='';
load(['mats',filesep,'start']);
start = ind;
load(['mats',filesep,'stop']);
stop = ind;
load(['mats',filesep,'targetseq']);
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
    for g = 1:2%size(A.ind,3)
        switch g
            case 1 %reach orizzontale
                ex='reachH';
                seq = horizseq;
                target = {'Tgt Left','Tgt Right'};
            case 2 %reach verticale
                ex='reachV';
                seq = vertseq;
                target = {'Tgt Up','Tgt Down'};
            case 3 %reach cross
                ex='reachC';
                seq = crossseq;
                target = {'Tgt Up','Tgt Left','Tgt Down','Tgt Right'};
        end
        DhipLXsess = [];
        DhipRXsess = [];
        DhipCXsess = [];
        
        DshLXsess = [];
        DshRXsess = [];
        DshCXsess = [];
        
        hipL_shL_sess = [];
        hipR_shR_sess = [];
        hipC_shC_sess = [];
        
        ShoulderLeftsess=[];
        ShoulderRightsess=[];
        HipLeftsess=[];
        HipRightsess=[];
        
        for sess=1:maxsess
            if g==1
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    %ordine: left hip right hip left shoulder right
                    %shoulder
                    posture=CalibPosture.ind{sess,subj}.A_oPosture(3:4,[37:39 49:51 13:15 25:27]);
                else
                    posture=CalibPosture.ind{sess,subj}.APosture(3:4,[37:39 49:51 13:15 25:27]);
                end
            elseif g==2
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    posture=[CalibPosture.ind{sess,subj}.A_vPosture(2,[37:39 49:51 13:15 25:27]); CalibPosture.ind{sess,subj}.A_vPosture(1,[37:39 49:51 13:15 25:27])];
                else
                    posture=[CalibPosture.ind{sess,subj}.APosture(2,[37:39 49:51 13:15 25:27]); CalibPosture.ind{sess,subj}.APosture(1,[37:39 49:51 13:15 25:27])];
                end
            else
                posture=CalibPosture.ind{sess,subj}.APosture(:,[37:39 49:51 13:15 25:27]);
            end
            
            data_markers = A.ind{subj,sess,g};
            xyz = [];
            for i=1:3:size(data_markers,2)-2
                xyz = cat(3,xyz, data_markers(:,i:i+2));
            end
            if isempty(xyz)
                continue
            end
            
            clear DhipL DhipR DhipC DshL DshR DshC hipL_shL hipR_shR hipC_shC hipR hipL hipC shL shR shC
            % calcolo dei delta shoulder (Dsh) e delta hip (Dhip) right and
            % left for each trial
            % calcolo dei rapporti Dhip/Dsh per ogni tiral
            for trial = 1:length(start{subj,sess,g})
                switch seq{subj,sess}(trial)
                    case 1
                        norm_LH = norm(posture(1,1:3));
                        norm_RH = norm(posture(1,4:6));
                        norm_LS = norm(posture(1,7:9));
                        norm_RS = norm(posture(1,10:12));
                    case 2
                        norm_LH = norm(posture(2,1:3));
                        norm_RH = norm(posture(2,4:6));
                        norm_LS = norm(posture(2,7:9));
                        norm_RS = norm(posture(2,10:12));
                end
                if isnan(start{subj,sess,g}(trial))
                    continue
                end
                try %calcolo i delta max min
                    normalizedHipL=squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,13))./norm_LH;
                    [~, indx_min]=min(abs(normalizedHipL));
                    [~, indx_max]=max(abs(normalizedHipL));
                    hipL(trial,:) = [normalizedHipL(indx_min(1),1) normalizedHipL(indx_min(2),2) normalizedHipL(indx_min(3),3) normalizedHipL(indx_max(1),1) normalizedHipL(indx_max(2),2) normalizedHipL(indx_max(3),3)];
                    DhipL(trial,:) =hipL(trial,4:6)-hipL(trial,1:3);
                catch
                    keyboard
                end
                normalizedHipR=squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,17))./norm_RH;
                [~, indx_min]=min(abs(normalizedHipR));
                [~, indx_max]=max(abs(normalizedHipR));
                hipR(trial,:) =  [normalizedHipR(indx_min(1),1) normalizedHipR(indx_min(2),2) normalizedHipR(indx_min(3),3) normalizedHipR(indx_max(1),1) normalizedHipR(indx_max(2),2) normalizedHipR(indx_max(3),3)];
                DhipR(trial,:) =hipR(trial,4:6)-hipR(trial,1:3);
            
                [~, indx_min]=min(abs(squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,1))));
                [~, indx_max]=max(abs(squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,1))));
                try
%                 hipC(trial,:) = [squeeze(xyz(start{subj,sess,g}(trial)+indx_min(1),1,1)) squeeze(xyz(start{subj,sess,g}(trial)+indx_min(2),2,1)) squeeze(xyz(start{subj,sess,g}(trial)+indx_min(3),3,1)) squeeze(xyz(start{subj,sess,g}(trial)+indx_max(1),1,1)) squeeze(xyz(start{subj,sess,g}(trial)+indx_max(2),2,1)) squeeze(xyz(start{subj,sess,g}(trial)+indx_max(3),3,1))];
%                 DhipC(trial,:) = hipC(trial,4:6)-hipC(trial,1:3);
                catch
                    keyboard
                end
                normalizedShL=squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,5))./norm_LS;
                [~, indx_min]=min(abs(normalizedShL));
                [~, indx_max]=max(abs(normalizedShL));
                shL(trial,:)=  [normalizedShL(indx_min(1),1) normalizedShL(indx_min(2),2) normalizedShL(indx_min(3),3) normalizedShL(indx_max(1),1) normalizedShL(indx_max(2),2) normalizedShL(indx_max(3),3)];
                DshL(trial,:) =shL(trial,4:6)-shL(trial,1:3);
                
                normalizedShR=squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,9))./norm_RS;
                [~, indx_min]=min(abs(normalizedShR));
                [~, indx_max]=max(abs(normalizedShR));
                shR(trial,:)=  [normalizedShR(indx_min(1),1) normalizedShR(indx_min(2),2) normalizedShR(indx_min(3),3) normalizedShR(indx_max(1),1) normalizedShR(indx_max(2),2) normalizedShR(indx_max(3),3)];
                DshR(trial,:) =shR(trial,4:6)-shR(trial,1:3);
                
                [~, indx_min]=min(abs(squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,3))));
                [~, indx_max]=max(abs(squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,3))));
%                 shC(trial,:) =  [squeeze(xyz(start{subj,sess,g}(trial)+indx_min(1),1,3)) squeeze(xyz(start{subj,sess,g}(trial)+indx_min(2),2,3)) squeeze(xyz(start{subj,sess,g}(trial)+indx_min(3),3,3)) squeeze(xyz(start{subj,sess,g}(trial)+indx_max(1),1,3)) squeeze(xyz(start{subj,sess,g}(trial)+indx_max(2),2,3)) squeeze(xyz(start{subj,sess,g}(trial)+indx_max(3),3,3))];
%                 DshC(trial,:) =shC(trial,4:6)-shC(trial,1:3);
                % calcolo anche i rapporti Dhip/Dsh per ogni trial
                hipL_shL(trial,:)=DhipL(trial,:)./DshL(trial,:);
                hipR_shR(trial,:)=DhipR(trial,:)./DshR(trial,:);
%                 hipC_shC(trial,:)=DhipC(trial,:)./DshC(trial,:);
                
            end %end trial
            
            try
                HipRightsess=[HipRightsess;[hipR,seq{subj,sess}']];
                HipLeftsess=[HipLeftsess;[hipL,seq{subj,sess}']];
                ShoulderRightsess=[ShoulderRightsess;[shR,seq{subj,sess}']];
                ShoulderLeftsess=[ShoulderLeftsess;[shL,seq{subj,sess}']];
                
                DhipLXsess = [DhipLXsess;[DhipL,seq{subj,sess}']];
                DhipRXsess = [DhipRXsess;[DhipR,seq{subj,sess}']];
%                 DhipCXsess = [DhipCXsess;[DhipC,seq{subj,sess}']];
                
                DshLXsess = [DshLXsess;[DshL,seq{subj,sess}']];
                DshRXsess = [DshRXsess;[DshR,seq{subj,sess}']];
%                 DshCXsess = [DshCXsess;[DshC,seq{subj,sess}']];
                % creo la matrice in cui unisco tutte le sessioni anche per
                % i rapporti Dhip/Dsh
                hipL_shL_sess = [hipL_shL_sess;[hipL_shL,seq{subj,sess}']];
                hipR_shR_sess = [hipR_shR_sess;[hipR_shR,seq{subj,sess}']];
%                 hipC_shC_sess =[hipC_shC_sess;[hipC_shC,seq{subj,sess}']];
                
                for nt = 1:max(seq{subj,sess})
                    DhipLM(sess,:,nt) = nanmean(DhipL(find(seq{subj,sess}==nt),:));
                    DhipRM(sess,:,nt)=  nanmean(DhipR(find(seq{subj,sess}==nt),:));
%                     DhipCM(sess,:,nt) =  nanmean(DhipC(find(seq{subj,sess}==nt),:));
                    DhipLstd(sess,:,nt) = nanstd(DhipL(find(seq{subj,sess}==nt),:));
                    DhipRstd(sess,:,nt)=  nanstd(DhipR(find(seq{subj,sess}==nt),:));
%                     DhipCstd(sess,:,nt) =  nanstd(DhipC(find(seq{subj,sess}==nt),:));
                    %mean min e max
                    Mean_minmaxHipR(sess,:,nt) = nanmean(HipRightsess(find(seq{subj,sess}==nt),:));
                    Mean_minmaxHipL(sess,:,nt) = nanmean(HipLeftsess(find(seq{subj,sess}==nt),:));
                    Mean_minmaxShoulderR(sess,:,nt) = nanmean(ShoulderRightsess(find(seq{subj,sess}==nt),:));
                    Mean_minmaxShoulderL(sess,:,nt) = nanmean(ShoulderLeftsess(find(seq{subj,sess}==nt),:));
                    Std_minmaxHipR(sess,:,nt) = nanstd(HipRightsess(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                    Std_minmaxHipL(sess,:,nt) = nanstd(HipLeftsess(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                    Std_minmaxShoulderR(sess,:,nt) = nanstd(ShoulderRightsess(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                    Std_minmaxShoulderL(sess,:,nt) = nanstd(ShoulderLeftsess(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                    
                    DshLM(sess,:,nt)=  nanmean(DshL(find(seq{subj,sess}==nt),:));
                    DshRM(sess,:,nt)=  nanmean(DshR(find(seq{subj,sess}==nt),:));
%                     DshCM(sess,:,nt) =  nanmean(DshC(find(seq{subj,sess}==nt),:));
                    DshLstd(sess,:,nt)=  nanstd(DshL(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                    DshRstd(sess,:,nt)=  nanstd(DshR(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
%                     DshCsstd(sess,:,nt) =  nanstd(DshC(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                    
                    hip_shLmean(sess,:,nt)=  nanmean(hipL_shL_sess(find(seq{subj,sess}==nt),:));
                    hip_shRmean(sess,:,nt)=  nanmean(hipR_shR_sess(find(seq{subj,sess}==nt),:));
%                     hip_shCmean(sess,:,nt) =  nanmean(hipC_shC_sess(find(seq{subj,sess}==nt),:));
                    hip_shLstd(sess,:,nt)=  nanstd(hipL_shL_sess(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                    hip_shRstd(sess,:,nt)=  nanstd(hipR_shR_sess(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
%                     hip_shCstd(sess,:,nt) =  nanstd(hipC_shC_sess(find(seq{subj,sess}==nt),:))./sqrt(length(find(seq{subj,sess}==nt)));
                end
            catch
                keyboard
            end
        end
        for nt = 1:max(seq{subj,sess})
            %             lim = [0 max(max([DhipLXsess(:,1:3); DhipRXsess(:,1:3); DshLXsess(:,1:3); DshRXsess(:,1:3)]))];
            %             hhip=figure;
            %             subplot(2,3,1)
            %             plot(DhipLXsess(find(DhipLXsess(:,4)==nt),1),'.');
            %             ylabel('\Delta HipL [m]')
            %             ylim(lim)
            %             title('X')
            %             subplot(2,3,2)
            %             plot(DhipLXsess(find(DhipLXsess(:,4)==nt),2),'.');
            %             title('Y')
            %             ylim(lim)
            %             subplot(2,3,3)
            %             plot(DhipLXsess(find(DhipLXsess(:,4)==nt),3),'.');
            %             title('Z')
            %             ylim(lim)
            %             subplot(2,3,4)
            %             plot(DhipRXsess(find(DhipRXsess(:,4)==nt),1),'.');
            %             ylabel('\Delta HipR [m]')
            %             ylim(lim)
            %             xlabel('trials')
            %             subplot(2,3,5)
            %             plot(DhipRXsess(find(DhipRXsess(:,4)==nt),2),'.');
            %             xlabel('trials')
            %             ylim(lim)
            %             subplot(2,3,6)
            %             plot(DhipRXsess(find(DhipRXsess(:,4)==nt),3),'.');
            %             xlabel('trials')
            %             ylim(lim)
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(hhip,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'hip'],'png')
            
            %             hsh=figure;
            %             subplot(2,3,1)
            %             plot(DshLXsess(find(DshLXsess(:,4)==nt),1),'.');
            %             ylabel('\Delta ShoulderL [m]')
            %             ylim(lim)
            %             title('X')
            %             subplot(2,3,2)
            %             plot(DshLXsess(find(DshLXsess(:,4)==nt),2),'.');
            %             ylim(lim)
            %             title('Y')
            %             subplot(2,3,3)
            %             plot(DshLXsess(find(DshLXsess(:,4)==nt),3),'.');
            %             ylim(lim)
            %             title('Z')
            %
            %             subplot(2,3,4)
            %             plot(DshRXsess(find(DshRXsess(:,4)==nt),1),'.');
            %             ylim(lim)
            %             ylabel('\Delta ShoulderR [m]')
            %             xlabel('trials')
            %             subplot(2,3,5)
            %             plot(DshRXsess(find(DshRXsess(:,4)==nt),2),'.');
            %             ylim(lim)
            %             xlabel('trials')
            %             subplot(2,3,6)
            %             plot(DshRXsess(find(DshRXsess(:,4)==nt),3),'.');
            %             ylim(lim)
            %             xlabel('trials')
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(hsh,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'sh'],'png')
            
            %             lim=[0 max(max([hipL_shL_sess(:,1:3) hipR_shR_sess(:,1:3)]))];
            %             % plot delta separati
            %             deltahipsh=figure;
            %             subplot(2,3,1)
            %             plot(hipL_shL_sess(find(hipL_shL_sess(:,4)==nt),1),'.');
            %             ylabel('\Delta hip/shoulder Left [m]')
            %             title('Delta Left, X')
            %             ylim(lim)
            %             subplot(2,3,2)
            %             plot(hipL_shL_sess(find(hipL_shL_sess(:,4)==nt),2),'.');
            %             title('Delta Left, Y')
            %             ylim(lim)
            %             subplot(2,3,3)
            %             plot(hipL_shL_sess(find(hipL_shL_sess(:,4)==nt),3),'.');
            %             title('Delta Left, Z')
            %             ylim(lim)
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             subplot(2,3,4)
            %             plot(hipR_shR_sess(find(hipR_shR_sess(:,4)==nt),1),'.');
            %             ylim(lim)
            %             xlabel('trials')
            %             ylabel('\Delta hip/shoulder Right [m]')
            %             title('Delta Right, X')
            %             subplot(2,3,5)
            %             plot(hipR_shR_sess(find(hipR_shR_sess(:,4)==nt),2),'.');
            %             ylim(lim)
            %             xlabel('trials')
            %             title('Delta Right, Y')
            %             subplot(2,3,6)
            %             plot(hipR_shR_sess(find(hipR_shR_sess(:,4)==nt),3),'.');
            %             ylim(lim)
            %             xlabel('trials')
            %             title('Delta Right, Z')
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(deltahipsh,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'hip_over_sh'],'png')
            
            %             % plot delta insieme
            %             deltahipshall=figure;
            %             subplot(3,1,1)
            %             plot(hipL_shL_sess(find(hipL_shL_sess(:,4)==nt),1),'.');
            %             hold on
            %             plot(hipR_shR_sess(find(hipR_shR_sess(:,4)==nt),1),'r.');
            %             ylabel('\Delta hip/Shoulder [m]')
            %             ylim(lim)
            %             title('X')
            %             subplot(3,1,2)
            %             plot(hipL_shL_sess(find(hipL_shL_sess(:,4)==nt),2),'.');
            %             hold on
            %             plot(hipR_shR_sess(find(hipR_shR_sess(:,4)==nt),2),'r.');
            %             ylim(lim)
            %             ylabel('\Delta hip/Shoulder Left [m]')
            %             title('Y')
            %             subplot(3,1,3)
            %             plot(hipL_shL_sess(find(hipL_shL_sess(:,4)==nt),3),'.');
            %             hold on
            %             plot(hipR_shR_sess(find(hipR_shR_sess(:,4)==nt),3),'r.');
            %             ylim(lim)
            %             title('Z')
            %             xlabel('trials')
            %             ylabel('\Delta hip/Shoulder Left [m]')
            %             legend('left','right')
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(deltahipshall,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'hip_over_shall'],'png')
            
            %             %figures mean
            %             lim = [0 max(max(max([DhipLM(:,1:3,:)+DhipLstd(:,1:3,:); DhipRM(:,1:3,:)+DhipRstd(:,1:3,:); DshLM(:,1:3,:)+DshLstd(:,1:3,:); DshRM(:,1:3,:)+DshRstd(:,1:3,:)])))];
            
            %             hhipmean=figure;
            %             subplot(2,3,1)
            %             errorbar(DhipLM(:,1,nt),DhipLstd(:,1,nt),'.')
            %             ylabel('\Delta HipL [m]')
            %             ylim(lim)
            %             title('X')
            %             subplot(2,3,2)
            %             errorbar(DhipLM(:,2,nt),DhipLstd(:,2,nt),'.');
            %             title('Y')
            %             ylim(lim)
            %             subplot(2,3,3)
            %             errorbar(DhipLM(:,3,nt),DhipLstd(:,3,nt),'.');
            %             title('Z')
            %             ylim(lim)
            %             subplot(2,3,4)
            %             errorbar(DhipRM(:,1,nt),DhipRstd(:,1,nt),'.');
            %             ylabel('\Delta HipR [m]')
            %             ylim(lim)
            %             xlabel('session')
            %             subplot(2,3,5)
            %             errorbar(DhipRM(:,2,nt),DhipRstd(:,2,nt),'.');
            %             xlabel('session')
            %             ylim(lim)
            %             subplot(2,3,6)
            %             errorbar(DhipRM(:,3,nt),DhipRstd(:,3,nt),'.');
            %             xlabel('session')
            %             ylim(lim)
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(hhipmean,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'MEANhip'],'png')
            
            %             hshmean=figure;
            %             subplot(2,3,1)
            %             errorbar(DshLM(:,1,nt),DshLstd(:,1,nt),'.');
            %             ylabel('\Delta ShoulderL [m]')
            %             ylim(lim)
            %             title('X')
            %             subplot(2,3,2)
            %             errorbar(DshLM(:,2,nt),DshLstd(:,2,nt),'.');
            %             ylim(lim)
            %             title('Y')
            %             subplot(2,3,3)
            %             errorbar(DshLM(:,3,nt),DshLstd(:,3,nt),'.');
            %             ylim(lim)
            %             title('Z')
            %             subplot(2,3,4)
            %             errorbar(DshRM(:,1,nt),DshRstd(:,1,nt),'.');
            %             ylim(lim)
            %             ylabel('\Delta ShoulderR [m]')
            %             xlabel('session')
            %             subplot(2,3,5)
            %             errorbar(DshRM(:,2,nt),DshRstd(:,2,nt),'.');
            %             ylim(lim)
            %             xlabel('session')
            %             subplot(2,3,6)
            %             errorbar(DshRM(:,3,nt),DshRstd(:,3,nt),'.');
            %             ylim(lim)
            %             xlabel('session')
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(hshmean,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'MEANsh'],'png')
            
%             lim=[min(min(min(abs([hip_shLmean(1,1:3,:)-hip_shLstd(1,1:3,:) hip_shRmean(1,1:3,:)-hip_shRstd(1,1:3,:) hip_shLmean(end,1:3,:)-hip_shLstd(end,1:3,:) hip_shRmean(end,1:3,:)-hip_shRstd(end,1:3,:)])))) max(max(max(abs([hip_shLmean(1,1:3,:)+hip_shLstd(1,1:3,:) hip_shRmean(1,1:3,:)+hip_shRstd(1,1:3,:) hip_shLmean(end,1:3,:)+hip_shLstd(end,1:3,:) hip_shRmean(end,1:3,:)+hip_shRstd(end,1:3,:)]))))];
            %             % plot delta separati
            %             deltahipshmean=figure;
            %             subplot(2,3,1)
            %             errorbar(hip_shLmean(:,1,nt),hip_shLstd(:,1,nt),'.');
            %             ylabel('\Delta hip/Shoulder Left [m]')
            %             title('Delta Left, X')
            %             ylim(lim)
            %             subplot(2,3,2)
            %             errorbar(hip_shLmean(:,2,nt),hip_shLstd(:,2,nt),'.');
            %             title('Delta Left, Y')
            %             ylim(lim)
            %             subplot(2,3,3)
            %             errorbar(hip_shLmean(:,3,nt),hip_shLstd(:,3,nt),'.');
            %             title('Delta Left, Z')
            %             ylim(lim)
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             subplot(2,3,4)
            %             errorbar(hip_shRmean(:,1,nt),hip_shRstd(:,1,nt),'.');
            %             ylim(lim)
            %             xlabel('session')
            %             ylabel('\Delta hip/Shoulder Right [m]')
            %             title('Delta Right, X')
            %             subplot(2,3,5)
            %             errorbar(hip_shRmean(:,2,nt),hip_shRstd(:,2,nt),'.');
            %             ylim(lim)
            %             xlabel('session')
            %             title('Delta Right, Y')
            %             subplot(2,3,6)
            %             errorbar(hip_shRmean(:,3,nt),hip_shRstd(:,3,nt),'.');
            %             ylim(lim)
            %             xlabel('session')
            %             title('Delta Right, Z')
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(deltahipshmean,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'MEANhip_over_sh'],'png')
            %
            % plot delta insieme
            %             deltahipshallmean=figure;
            %             subplot(3,1,1)
            %             errorbar(hip_shLmean(:,1,nt),hip_shLstd(:,1,nt),'.');
            %             hold on
            %             errorbar(hip_shRmean(:,1,nt),hip_shRstd(:,1,nt),'r.');
            %             ylabel('\Delta hip/shoulder [m]')
            %             ylim(lim)
            %             title('X')
            %             subplot(3,1,2)
            %             errorbar(hip_shLmean(:,2,nt),hip_shLstd(:,2,nt),'.');
            %             hold on
            %             errorbar(hip_shRmean(:,2,nt),hip_shRstd(:,2,nt),'r.');
            %             ylim(lim)
            %             ylabel('\Delta hip/shoulder [m]')
            %             title('Y')
            %             subplot(3,1,3)
            %             errorbar(hip_shLmean(:,3,nt),hip_shLstd(:,3,nt),'.');
            %             hold on
            %             errorbar(hip_shRmean(:,3,nt),hip_shRstd(:,3,nt),'r.');
            %             ylim(lim)
            %             title('Z')
            %             xlabel('session')
            %             ylabel('\Delta hip/shoulder [m]')
            %             legend('left','right')
            %             suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            %             saveas(deltahipshallmean,['figs',filesep,'Delta',filesep,'DeltaPos_Subj',num2str(subj),ex,target{nt},'MEANhip_over_shall'],'png')
            lim=[0 max(max(max(abs([hip_shLmean(1,1:3,:)+hip_shLstd(1,1:3,:) hip_shRmean(1,1:3,:)+hip_shRstd(1,1:3,:) hip_shLmean(end,1:3,:)+hip_shLstd(end,1:3,:) hip_shRmean(end,1:3,:)+hip_shRstd(end,1:3,:)]))))];

            deltahipshprepost=figure;
            subplot(1,3,1)
            bar(abs([hip_shLmean(1,1,nt),hip_shLmean(end,1,nt),hip_shRmean(1,1,nt),hip_shRmean(end,1,nt)]));
            hold on
            errorbar(abs([hip_shLmean(1,1,nt),hip_shLmean(end,1,nt),hip_shRmean(1,1,nt),hip_shRmean(end,1,nt)]),[hip_shLstd(1,1,nt),hip_shLstd(end,1,nt),hip_shRstd(1,1,nt),hip_shRstd(end,1,nt)],'.');
            ylabel('\Delta hip/shoulder [m]')
            ylim(lim)
            title('X')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(1,3,2)
            bar(abs([hip_shLmean(1,2,nt),hip_shLmean(end,2,nt),hip_shRmean(1,2,nt),hip_shRmean(end,2,nt)]));
            hold on
            errorbar(abs([hip_shLmean(1,2,nt),hip_shLmean(end,2,nt),hip_shRmean(1,2,nt),hip_shRmean(end,2,nt)]),[hip_shLstd(1,2,nt),hip_shLstd(end,2,nt),hip_shRstd(1,2,nt),hip_shRstd(end,2,nt)],'.');
            ylim(lim)
            title('Y')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(1,3,3)
            bar(abs([hip_shLmean(1,3,nt),hip_shLmean(end,3,nt),hip_shRmean(1,3,nt),hip_shRmean(end,3,nt)]));
            hold on
            errorbar(abs([hip_shLmean(1,3,nt),hip_shLmean(end,3,nt),hip_shRmean(1,3,nt),hip_shRmean(end,3,nt)]),[hip_shLstd(1,3,nt),hip_shLstd(end,3,nt),hip_shRstd(1,3,nt),hip_shRstd(end,3,nt)],'.');
            ylim(lim)
            title('Z')
            suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            saveas(deltahipshprepost,['figs',filesep,'Delta',filesep,'PrePostDeltaPos_Subj',num2str(subj),ex,target{nt},'hip_over_shallNormalized'],'fig')
            
            lim=[min(min(min([Mean_minmaxHipL(1,1:6,:)-Std_minmaxHipL(1,1:6,:) Mean_minmaxHipR(1,1:6,:)-Std_minmaxHipR(1,1:6,:) Mean_minmaxHipR(end,1:6,:)-Std_minmaxHipR(end,1:6,:) Mean_minmaxHipL(end,1:6,:)-Std_minmaxHipL(end,1:6,:)]))) max(max(max([Mean_minmaxHipL(1,1:6,:)+Std_minmaxHipL(1,1:6,:) Mean_minmaxHipR(1,1:6,:)+Std_minmaxHipR(1,1:6,:) Mean_minmaxHipR(end,1:6,:)+Std_minmaxHipR(end,1:6,:) Mean_minmaxHipL(end,1:6,:)+Std_minmaxHipL(end,1:6,:)])))];
            maxminhipprepost=figure;
            subplot(2,3,1)
            bar([Mean_minmaxHipL(1,1,nt),Mean_minmaxHipL(end,1,nt),Mean_minmaxHipR(1,1,nt),Mean_minmaxHipR(end,1,nt)]);
            hold on
            errorbar([Mean_minmaxHipL(1,1,nt),Mean_minmaxHipL(end,1,nt),Mean_minmaxHipR(1,1,nt),Mean_minmaxHipR(end,1,nt)],[Std_minmaxHipL(1,1,nt),Std_minmaxHipL(end,1,nt),Std_minmaxHipR(1,1,nt),Std_minmaxHipR(end,1,nt)],'.');
            ylabel('Min hip [m]')
            ylim(lim)
            title('min along X')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,2)
            bar([Mean_minmaxHipL(1,2,nt),Mean_minmaxHipL(end,2,nt),Mean_minmaxHipR(1,2,nt),Mean_minmaxHipR(end,2,nt)]);
            hold on
            errorbar([Mean_minmaxHipL(1,2,nt),Mean_minmaxHipL(end,2,nt),Mean_minmaxHipR(1,2,nt),Mean_minmaxHipR(end,2,nt)],[Std_minmaxHipL(1,2,nt),Std_minmaxHipL(end,2,nt),Std_minmaxHipR(1,2,nt),Std_minmaxHipR(end,2,nt)],'.');
            ylim(lim)
            title('min alongY')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,3)
            bar([Mean_minmaxHipL(1,3,nt),Mean_minmaxHipL(end,3,nt),Mean_minmaxHipR(1,3,nt),Mean_minmaxHipR(end,3,nt)]);
            hold on
            errorbar([Mean_minmaxHipL(1,3,nt),Mean_minmaxHipL(end,3,nt),Mean_minmaxHipR(1,3,nt),Mean_minmaxHipR(end,3,nt)],[Std_minmaxHipL(1,3,nt),Std_minmaxHipL(end,3,nt),Std_minmaxHipR(1,3,nt),Std_minmaxHipR(end,3,nt)],'.');
            ylim(lim)
            title('min along Z')
            suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,4)
            bar([Mean_minmaxHipL(1,4,nt),Mean_minmaxHipL(end,4,nt),Mean_minmaxHipR(1,4,nt),Mean_minmaxHipR(end,4,nt)]);
            hold on
            errorbar([Mean_minmaxHipL(1,4,nt),Mean_minmaxHipL(end,4,nt),Mean_minmaxHipR(1,4,nt),Mean_minmaxHipR(end,4,nt)],[Std_minmaxHipL(1,4,nt),Std_minmaxHipL(end,4,nt),Std_minmaxHipR(1,4,nt),Std_minmaxHipR(end,4,nt)],'.');
            ylabel('Max [m]')
            xlabel('Session')
            ylim(lim)
            title('max along X')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,5)
            bar([Mean_minmaxHipL(1,5,nt),Mean_minmaxHipL(end,5,nt),Mean_minmaxHipR(1,5,nt),Mean_minmaxHipR(end,5,nt)]);
            hold on
            errorbar([Mean_minmaxHipL(1,5,nt),Mean_minmaxHipL(end,5,nt),Mean_minmaxHipR(1,5,nt),Mean_minmaxHipR(end,5,nt)],[Std_minmaxHipL(1,5,nt),Std_minmaxHipL(end,5,nt),Std_minmaxHipR(1,5,nt),Std_minmaxHipR(end,5,nt)],'.');
            ylim(lim)
            title('max alongY')
            xlabel('Session')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,6)
            bar([Mean_minmaxHipL(1,6,nt),Mean_minmaxHipL(end,6,nt),Mean_minmaxHipR(1,6,nt),Mean_minmaxHipR(end,6,nt)]);
            hold on
            errorbar([Mean_minmaxHipL(1,6,nt),Mean_minmaxHipL(end,6,nt),Mean_minmaxHipR(1,6,nt),Mean_minmaxHipR(end,6,nt)],[Std_minmaxHipL(1,6,nt),Std_minmaxHipL(end,6,nt),Std_minmaxHipR(1,6,nt),Std_minmaxHipR(end,6,nt)],'.');
            ylim(lim)
            xlabel('Session')
            title('max along Z')
            suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            saveas(maxminhipprepost,['figs',filesep,'Delta',filesep,'PrePostMinMaxPos_Subj',num2str(subj),ex,target{nt},'Hip'],'fig')
            
            lim=[min(min(min([Mean_minmaxShoulderL(1,1:6,:)-Std_minmaxShoulderL(1,1:6,:) Mean_minmaxShoulderR(1,1:6,:)-Std_minmaxShoulderR(1,1:6,:) Mean_minmaxShoulderR(end,1:6,:)-Std_minmaxShoulderR(end,1:6,:) Mean_minmaxShoulderL(end,1:6,:)-Std_minmaxShoulderL(end,1:6,:)]))) max(max(max([Mean_minmaxShoulderL(1,1:6,:)+Std_minmaxShoulderL(1,1:6,:) Mean_minmaxShoulderR(1,1:6,:)+Std_minmaxShoulderR(1,1:6,:) Mean_minmaxShoulderR(end,1:6,:)+Std_minmaxShoulderR(end,1:6,:) Mean_minmaxShoulderL(end,1:6,:)+Std_minmaxShoulderL(end,1:6,:)])))];
            maxminshprepost=figure;
            subplot(2,3,1)
            bar([Mean_minmaxShoulderL(1,1,nt),Mean_minmaxShoulderL(end,1,nt),Mean_minmaxShoulderR(1,1,nt),Mean_minmaxShoulderR(end,1,nt)]);
            hold on
            errorbar([Mean_minmaxShoulderL(1,1,nt),Mean_minmaxShoulderL(end,1,nt),Mean_minmaxShoulderR(1,1,nt),Mean_minmaxShoulderR(end,1,nt)],[Std_minmaxShoulderL(1,1,nt),Std_minmaxShoulderL(end,1,nt),Std_minmaxShoulderR(1,1,nt),Std_minmaxShoulderR(end,1,nt)],'.');
            ylabel('Min shoulder [m]')
            ylim(lim)
            title('min along X')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,2)
            bar([Mean_minmaxShoulderL(1,2,nt),Mean_minmaxShoulderL(end,2,nt),Mean_minmaxShoulderR(1,2,nt),Mean_minmaxShoulderR(end,2,nt)]);
            hold on
            errorbar([Mean_minmaxShoulderL(1,2,nt),Mean_minmaxShoulderL(end,2,nt),Mean_minmaxShoulderR(1,2,nt),Mean_minmaxShoulderR(end,2,nt)],[Std_minmaxShoulderL(1,2,nt),Std_minmaxShoulderL(end,2,nt),Std_minmaxShoulderR(1,2,nt),Std_minmaxShoulderR(end,2,nt)],'.');
            ylim(lim)
            title('min alongY')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,3)
            bar([Mean_minmaxShoulderL(1,3,nt),Mean_minmaxShoulderL(end,3,nt),Mean_minmaxShoulderR(1,3,nt),Mean_minmaxShoulderR(end,3,nt)]);
            hold on
            errorbar([Mean_minmaxShoulderL(1,3,nt),Mean_minmaxShoulderL(end,3,nt),Mean_minmaxShoulderR(1,3,nt),Mean_minmaxShoulderR(end,3,nt)],[Std_minmaxShoulderL(1,3,nt),Std_minmaxShoulderL(end,3,nt),Std_minmaxShoulderR(1,3,nt),Std_minmaxShoulderR(end,3,nt)],'.');
            ylim(lim)
            title('min along Z')
            suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,4)
            bar([Mean_minmaxShoulderL(1,4,nt),Mean_minmaxShoulderL(end,4,nt),Mean_minmaxShoulderR(1,4,nt),Mean_minmaxShoulderR(end,4,nt)]);
            hold on
            errorbar([Mean_minmaxShoulderL(1,4,nt),Mean_minmaxShoulderL(end,4,nt),Mean_minmaxShoulderR(1,4,nt),Mean_minmaxShoulderR(end,4,nt)],[Std_minmaxShoulderL(1,4,nt),Std_minmaxShoulderL(end,4,nt),Std_minmaxShoulderR(1,4,nt),Std_minmaxShoulderR(end,4,nt)],'.');
            ylabel('Max Shoulder[m]')
            xlabel('Session')
            ylim(lim)
            title('max along X')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,5)
            bar([Mean_minmaxShoulderL(1,5,nt),Mean_minmaxShoulderL(end,5,nt),Mean_minmaxShoulderR(1,5,nt),Mean_minmaxShoulderR(end,5,nt)]);
            hold on
            errorbar([Mean_minmaxShoulderL(1,5,nt),Mean_minmaxShoulderL(end,5,nt),Mean_minmaxShoulderR(1,5,nt),Mean_minmaxShoulderR(end,5,nt)],[Std_minmaxShoulderL(1,5,nt),Std_minmaxShoulderL(end,5,nt),Std_minmaxShoulderR(1,5,nt),Std_minmaxShoulderR(end,5,nt)],'.');
            ylim(lim)
            title('max alongY')
            xlabel('Session')
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            subplot(2,3,6)
            bar([Mean_minmaxShoulderL(1,6,nt),Mean_minmaxShoulderL(end,6,nt),Mean_minmaxShoulderR(1,6,nt),Mean_minmaxShoulderR(end,6,nt)]);
            hold on
            errorbar([Mean_minmaxShoulderL(1,6,nt),Mean_minmaxShoulderL(end,6,nt),Mean_minmaxShoulderR(1,6,nt),Mean_minmaxShoulderR(end,6,nt)],[Std_minmaxShoulderL(1,6,nt),Std_minmaxShoulderL(end,6,nt),Std_minmaxShoulderR(1,6,nt),Std_minmaxShoulderR(end,6,nt)],'.');
            ylim(lim)
            xlabel('Session')
            title('max along Z')
            suptitle(['Subj',num2str(subj),' ',ex,' ',target{nt}])
            box off
            a=gca;
            a.XTickLabel = {'L_p_r','L_p_o','R_p_r','R_p_o'};
            saveas(maxminshprepost,['figs',filesep,'Delta',filesep,'PrePostMinMaxPos_Subj',num2str(subj),ex,target{nt},'Shoulder'],'fig')
            
        end
        clear DhipLM DhipRM DhipLstd DhipRstd 
        %mean min e max
        clear Mean_minmaxHipR Mean_minmaxHipL Mean_minmaxShoulderR Mean_minmaxShoulderL Std_minmaxHipR Std_minmaxHipL Std_minmaxShoulderR Std_minmaxShoulderL 
        clear DshLM DshRM  DshLstd DshRstd 
        clear hip_shLmean hip_shRmean  hip_shLstd hip_shRstd 
    end
end

