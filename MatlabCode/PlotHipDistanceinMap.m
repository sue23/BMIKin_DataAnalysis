function PlotHipDistanceinMap(datadir)
%PlotHipDistanceinMap valuta distanza tra marker in fase di calibrazione
%   Detailed explanation goes here

pathfig=['figs',filesep,'goodnesskinect',filesep];
% markers = {'hipc','spine','shc','head','shl','elbl','wristl','handl','shr','elbr','wristr','handr','hipl','kneel','anklel','footl','hipr','kneer','ankler','footr'};
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
CalibPosture=load(['mats',filesep,'Mappe']);
reply = input('Trasformare in coordinate Body? Y/N [N]:','s');
for subj=2%1:length(soggetti)
     %similmente a prima, dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
    if maxsess>10
        display('WARNING! Sessions more than 10');
        keyboard
    end
     for sess=1:maxsess
         if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
             post=CalibPosture.ind{sess,subj}.A_oPosture;
         else
             post=CalibPosture.ind{sess,subj}.APosture;
         end
         
       if isempty(reply)
          reply = 'N';
       end
       if strcmp(reply,'Y')
         [postB]=TKinectInBody(post,post);
         marker=postB;
         tit='Body ';
       else 
           marker = [];
            for i=1:3:size(post,2)-2
                marker = cat(3,marker, post(:,i:i+2));
            end
           tit='Kinect ';
       end
         
         
         hipL=marker(:,:,13);
         hipR=marker(:,:,17);
         hipC=marker(:,:,1);
         shL=marker(:,:,5);
         shR=marker(:,:,9);
         shC=marker(:,:,3);
         
          hipx = squeeze(marker(:,1,[1 13 17]));
                    hipy = squeeze(marker(:,2,[1 13 17]));
                    hipz = squeeze(marker(:,3,[1 13 17]));
                    trunkx = squeeze(marker(:,1,[2]));
                    trunky = squeeze(marker(:,2,[2]));
                    trunkz = squeeze(marker(:,3,[2]));
                    shx = squeeze(marker(:,1,[3 5 9]));
                    shy = squeeze(marker(:,2,[3 5 9]));
                    shz = squeeze(marker(:,3,[3 5 9]));
                
                if (sess==1 | sess==maxsess)
                    figure
                    for t=1:4
                        
                        
%                for t = 1:stop{subj,sess,g}(trial)-start{subj,sess,g}(trial)+1
                line([hipx(t,:) hipx(t,1)],[hipy(t,:) hipy(t,1)],[hipz(t,:) hipz(t,1)])
                hold on
                line([hipx(t,1) trunkx(t) shx(t,1)],[hipy(t,1) trunky(t) shy(t,1)],[hipz(t,1) trunkz(t) shz(t,1)],'col','r')
                line([shx(t,:) shx(t,1)],[shy(t,:) shy(t,1)],[shz(t,:) shz(t,1)])
%                 
                plot3(shx(t,1),shy(t,1),shz(t,1),'MarkerFaceColor',[0 1 1],'marker','.','markersize',50)
                hold on
                plot3(shx(t,2),shy(t,2),shz(t,2),'MarkerFaceColor',[1 0 1],'marker','.','markersize',50)
                plot3(shx(t,3),shy(t,3),shz(t,3),'MarkerFaceColor',[0 1 0],'marker','.','markersize',50)
                
                plot3(hipx(t,1),hipy(t,1),hipz(t,1),'MarkerFaceColor',[1 0 0],'marker','.','markersize',50)
                hold on
                plot3(hipx(t,2),hipy(t,2),hipz(t,2),'MarkerFaceColor',[0 0 1],'marker','.','markersize',50)
                plot3(hipx(t,3),hipy(t,3),hipz(t,3),'MarkerFaceColor',[0 0 0],'marker','.','markersize',50)
                text(hipx(t,1),hipy(t,1),hipz(t,1),['c',num2str(t)])
                text(hipx(t,2),hipy(t,2),hipz(t,2),['l',num2str(t)])
                text(hipx(t,3),hipy(t,3),hipz(t,3),['r',num2str(t)])
                text(shx(t,1),shy(t,1),shz(t,1),['c',num2str(t)])
                text(shx(t,2),shy(t,2),shz(t,2),['l',num2str(t)])
                text(shx(t,3),shy(t,3),shz(t,3),['r',num2str(t)])
                xlabel('x')
                ylabel('y')
                zlabel('z')
%                 zlim([-0.08 0.08])
%                 xlim([-0.25 0.25])
%                 ylim([-0.2 0.8])
                title(['sess', num2str(sess)])
%                 view(-90,90); %Piano xy
                view(0,90); %piano yx
%                 view(0,0); %Piano zx
%                 view(-90,0); %Piano zy
%                 drawnow
% %                 %
% %                 %                 pause(1)
%             end
                    end 
         %calcolo prima la distanza tra i marker durante la posizione
         %centrale. Ossia prendo il valore medio tra le quattro
         %configurazioni
         hipLm=mean(hipL);
         hipRm=mean(hipR);
         hipCm=mean(hipC);
         shLm=mean(shL);
         shRm=mean(shR);
         shCm=mean(shC);
         
         distHipLRm(sess,subj)= sqrt(sum((hipLm-hipRm).^2));
         distHipCRm(sess,subj)= sqrt(sum((hipCm-hipRm).^2));
         distHipCLm(sess,subj)= sqrt(sum((hipCm-hipLm).^2));
         
         distHipLR(sess,subj,:)= sqrt(sum((hipL-hipR).^2,2));
         distHipCR(sess,subj,:)= sqrt(sum((hipC-hipR).^2,2));
         distHipCL(sess,subj,:)= sqrt(sum((hipC-hipL).^2,2));
         
     end
    
     end
keyboard
distHipLRm(find(distHipLRm==0))= nan;
distHipCRm(find(distHipCRm==0))= nan;
distHipCLm(find(distHipCLm==0))= nan;

distHipLR(find(distHipLR==0))= nan;
distHipCR(find(distHipCR==0))= nan;
distHipCL(find(distHipCL==0))= nan;

% % % stupido perch? a questo punto mi guardo la deviazione standard?
mxsessHipLR = nanmean(distHipLR);
mxsessHipCR = nanmean(distHipCR);
mxsessHipCL = nanmean(distHipCL);


posLR = abs(distHipLR-repmat(mxsessHipLR,size(distHipLR,1),1));
posCR = abs(distHipCR-repmat(mxsessHipCR,size(distHipCR,1),1));
posCL = abs(distHipCL-repmat(mxsessHipCL,size(distHipCL,1),1));

errHipLR = max(distHipLR,[],1)-min(distHipLR,[],1);
errHipCR = max(distHipCR,[],1)-min(distHipCR,[],1);
errHipCL = max(distHipCL,[],1)-min(distHipCL,[],1);

keyboard

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
figure
h=subplot(2,2,1)
bar([errHipLR(:,:,1);errHipCR(:,:,1);errHipCL(:,:,1)]');

ylabel('Max Error [m]')
title([tit,'anteversion posture'])
% xlabel('Subjects')
subplot(2,2,2)
h=bar([errHipLR(:,:,2);errHipCR(:,:,2);errHipCL(:,:,2)]');
legend(h,{'errHipLR','errHipCR','errHipCL'})
% ylabel('Max Error [m]')
title([tit,'retroversion posture'])
% xlabel('Subjects')
subplot(2,2,3)
h=bar([errHipLR(:,:,3);errHipCR(:,:,3);errHipCL(:,:,3)]');
% legend(h,{'errHipLR','errHipCR','errHipCL'})
ylabel('Max Error [m]')
title([tit,'right hip elevation'])
xlabel('Subjects')
subplot(2,2,4)
h=bar([errHipLR(:,:,4);errHipCR(:,:,4);errHipCL(:,:,4)]');
% legend(h,{'errHipLR','errHipCR','errHipCL'})
% ylabel('Max Error [m]')
title([tit,'left hip elevation'])
xlabel('Subjects')
 saveas(gcf,[pathfig,filesep,tit,'MaxError'],'png')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
for s =1:4
    Ml=max(max(max([posLR(:,s,:),posCR(:,s,:),posCL(:,s,:)])));
figure
h=subplot(2,2,1)
bar([posLR(:,s,1),posCR(:,s,1),posCL(:,s,1)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylabel('Error [m]')
title([tit,'anteversion posture'])
ylim([0 Ml])
box off
h=subplot(2,2,2)
bar([posLR(:,s,2),posCR(:,s,2),posCL(:,s,2)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylim([0 Ml])
title([tit,'retroversion posture'])
% xlabel('Subjects')
box off
h=subplot(2,2,3)
bar([posLR(:,s,3),posCR(:,s,3),posCL(:,s,3)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylabel('Error [m]')
title([tit,'right hip elevation'])
ylim([0 Ml])
box off
h=subplot(2,2,4)
bar([posLR(:,s,4),posCR(:,s,4),posCL(:,s,4)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylim([0 Ml])
box off
% ylabel('Max Error [m]')
title([tit,'left hip elevation'])
suptitle(['Subjects' num2str(s)])
set(gcf,'pos',[217,359 1015,377])
 saveas(gcf,[pathfig,filesep,tit,'DistfromMean',num2str(s)],'png')
end


for s=1:4
figure
h=subplot(2,2,1);
bar(1:3,[distHipLR(:,s,1),distHipCR(:,s,1),distHipCL(:,s,1)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylim([0 0.2])
box off
ylabel('Distance [m]')
title([tit,'anteversion posture'])
% xlabel('Subjects')
h=subplot(2,2,2);
bar([distHipLR(:,s,2),distHipCR(:,s,2),distHipCL(:,s,2)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylim([0 0.2])
box off
% ylabel('Max Error [m]')
title([tit,'retroversion posture'])
% xlabel('Subjects')
h=subplot(2,2,3);
bar([distHipLR(:,s,3),distHipCR(:,s,3),distHipCL(:,s,3)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylim([0 0.2])
box off
ylabel('Distance [m]')
title([tit,'right hip elevation'])
h=subplot(2,2,4);
bar([distHipLR(:,s,4),distHipCR(:,s,4),distHipCL(:,s,4)]');
set(h,'xticklabels',{'distHipLR','distHipCR','distHipCL'});
ylim([0 0.2])
box off
title([tit,'left hip elevation'])
suptitle(['Subject',num2str(s)])

set(gcf,'pos',[217,359 1015,377])
 saveas(gcf,[pathfig,filesep,tit,'Distmarker',num2str(s)],'png')
end


end

