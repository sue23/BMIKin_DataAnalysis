function pckinect(datadir)
%PlotHipDistanceinMap valuta distanza tra marker in fase di esercizio
%   Detailed explanation goes here

% markers = {'hipc','spine','shc','head','shl','elbl','wristl','handl','shr','elbr','wristr','handr','hipl','kneel','anklel','footl','hipr','kneer','ankler','footr'};
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
A=load(['mats',filesep,'ReachKinectData']);
tit='';
load(['mats',filesep,'start']);
start = ind;
load(['mats',filesep,'stop']);
stop = ind;
load(['mats',filesep,'Mappe']);
maps = ind;
load(['mats',filesep,'cursor']);
cursor = ind;

for subj=1:3%length(soggetti)
    %similmente a prima, dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
    if maxsess>10
        display('WARNING! Sessions more than 10');
        keyboard
    end
    d=1;
    beg = [2 1 1];
    for sess=[beg(subj) maxsess]
        hip=[]; trunk=[];trunkh=[];trunkv=[];shoulder=[];
        for g = 1:2%size(A.ind,3)
            if g==1
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    %ordine: left hip right hip left shoulder right
                    %shoulder
                    mappa=maps{sess,subj}.A_o;
                else
                    mappa=maps{sess,subj}.A;
                end
            elseif g==2
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    mappa=maps{sess,subj}.A_v;
                else
                    mappa=maps{sess,subj}.A;
                end
            else
                mappa=maps{sess,subj}.A;
            end
            
            data_markers = A.ind{subj,sess,g};
            xyz = [];
            for i=1:3:size(data_markers,2)-2
                xyz = cat(3,xyz, data_markers(:,i:i+2));
            end
            
            
            
            for trial = 1:length(start{subj,sess,g})
                if isnan(start{subj,sess,g}(trial))
                    continue
                end
                hipL = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[13]));
                hipR = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[17]));
                hipC = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[1]));
                shL=squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,5));
                shR=squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,9));
                shC=squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,3));
                hip = [hip;hipC hipL hipR];
                trunk = [trunk;hipL hipR hipC shL shR shC];
                shoulder = [shoulder;shL shR shC];
                if g==1
                    trunkh = [trunkh; hipL hipR hipC];% shL shR shC];
                else
                    trunkv = [trunkv; hipL hipR hipC];% shL shR shC];
                end
            end %trial
            
            Mappa=mappa([1 2 3 37 38 39 49 50 51],:);
        end %g
        [coeff,score,latent,~,explained]=pca(trunk);
        pc=coeff(:,[1 2])';
        p =pc*(trunk)';%-repmat(mean(hip),size(hip,1),1))';
        figure
        plot(p(1,:),p(2,:),'.')
        title(['subj',num2str(subj),'sess',num2str(sess),'trunk'])
        ang(subj,d)= acosd(dot(p(2,find(isnan(p(1,:))==0))',p(1,find(isnan(p(1,:))==0))'));
        %         saveas(gcf,['subj',num2str(subj),'sess',num2str(sess),'trunk.fig'])
        
        [coeffsh,scoresh,latentsh,~,explainedsh]=pca(shoulder);
        pcsh=coeffsh(:,[1 2])';
        psh =pcsh*(shoulder)';%-repmat(mean(hip),size(hip,1),1))';
        figure
        plot(psh(1,:),psh(2,:),'.')
        title(['subj',num2str(subj),'sess',num2str(sess),'Shoulder'])
        %         saveas(gcf,['subj',num2str(subj),'sess',num2str(sess),'Shoulder.fig'])
        
        [coeffhip,scorehip,latenthip,~,explainedhip]=pca(hip);
        %prendo le prime due pc
%         coeffhip=coeffhip.*[ones(size(coeffhip,1),2),zeros(size(coeffhip,1),size(coeffhip,2)-2)];
        %prendo la prima pc
        coeffhip=coeffhip.*[ones(size(coeffhip,1),1),zeros(size(coeffhip,1),size(coeffhip,2)-1)];
        phip =coeffhip'*(hip)';%-repmat(mean(hip),size(hip,1),1))';
        figure
        subplot(1,2,1)
        plot(phip(1,:),phip(2,:),'.')
        title('Body nello spazio delle pca')
        c = Mappa'*phip;
        subplot(1,2,2)
        plot(c(1,:),c(2,:),'.')
        title('Body nello spazio del cursore')
        suptitle(['subj',num2str(subj),'sess',num2str(sess),'Hip nello spazio del cursore'])
                saveas(gcf,['subj',num2str(subj),'sess',num2str(sess),'Hip.fig'])
        %         ho(subj,d) = nanstd(ph(2,:))./nanstd(ph(1,:));
        %         ve(subj,d) = nanstd(pv(2,:))./nanstd(pv(1,:));
        
        coefftrunk(:,:,d) = cat(3,coeff);
        d=d+1;
        
        
        
    end %sess
    
    % % %     preh_coef_s1 = coefftrunk(:,:,1);
    % % %     posth_coef_s1 = coefftrunk(:,:,2);
    % % %     posth_shr_s1 = posth_coef_s1(13:15,1:2);
    % % %     preh_shr_s1 = preh_coef_s1(13:15,1:2);
    % % %     posth_shl_s1 = posth_coef_s1(10:12,1:2);
    % % %     preh_shl_s1 = preh_coef_s1(10:12,1:2);
    % % %     figure
    % % %     subplot(2,2,1)
    % % %     bar(abs(preh_shr_s1),'DisplayName','preh_shr_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('pre shr H')
    % % %
    % % % %     ylim([-0.18 0.01])
    % % %     subplot(2,2,2)
    % % %     bar(abs(posth_shr_s1),'DisplayName','posth_shr_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('post shr H')
    % % %
    % % % %     ylim([-0.18 0.01])
    % % %     subplot(2,2,3)
    % % %
    % % %     bar(abs(preh_shl_s1),'DisplayName','preh_shl_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('pre shl H')
    % % % %     ylim([-0.18 0.01])
    % % %     subplot(2,2,4)
    % % %     bar(abs(posth_shl_s1),'DisplayName','posth_shl_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('post shl H')
    % % % %     ylim([-0.18 0.01])
    % % %
    % % %
    % % %
    % % %     preh_coef_s1 = coefftrunk(:,:,1);
    % % %     posth_coef_s1 = coefftrunk(:,:,2);
    % % %     posth_per_s1 = posth_coef_s1(4:6,1:2);
    % % %     preh_per_s1 = preh_coef_s1(4:6,1:2);
    % % %     posth_pel_s1 = posth_coef_s1(1:3,1:2);
    % % %     preh_pel_s1 = preh_coef_s1(1:3,1:2);
    % % %     figure
    % % %     subplot(2,2,1)
    % % %     bar(abs(preh_per_s1),'DisplayName','preh_per_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('pre per H')
    % % %
    % % % %     ylim([-0.18 0.01])
    % % %     subplot(2,2,2)
    % % %     bar(abs(posth_per_s1),'DisplayName','posth_per_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('post per H')
    % % %
    % % % %     ylim([-0.18 0.01])
    % % %     subplot(2,2,3)
    % % %     bar(abs(preh_pel_s1),'DisplayName','preh_pel_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('pre pel H')
    % % % %     ylim([-0.18 0.01])
    % % %     subplot(2,2,4)
    % % %     bar(abs(posth_pel_s1),'DisplayName','posth_pel_s1')
    % % %     ylim([0 1])
    % % %     legend('Ipc','IIpc')
    % % %     title('post pel H')
    % % % %     ylim([-0.18 0.01])
end %subj

keyboard

% figure
% subplot(2,1,1)
% bar(ho);
% set(gca,'XTick',[1 2 3],'XTickLabel',{'Sabject 1','Subject 2','Subject 3'});
% legend('First session','Last session')
% legend boxoff
% box off
% title('Horizontal')
% subplot(2,1,2)
% bar(ve)
% set(gca,'XTick',[1 2 3],'XTickLabel',{'Sabject 1','Subject 2','Subject 3'});
% legend('First session','Last session')
% legend boxoff
% box off
% title('Vertical')

% figure
% subplot(2,1,1)
% bar(toth);
% set(gca,'XTick',[1 2 3],'XTickLabel',{'Sabject 1','Subject 2','Subject 3'});
% legend('First session','Last session')
% legend boxoff
% box off
% title('Horizontal')
% subplot(2,1,2)
% bar(totv)
% set(gca,'XTick',[1 2 3],'XTickLabel',{'Sabject 1','Subject 2','Subject 3'});
% legend('First session','Last session')
% legend boxoff
% box off
% title('Vertical')



% end

