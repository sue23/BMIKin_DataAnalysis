function PlotHipDistanceDuringReach(datadir)
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
    for g = 1:size(A.ind,3)
        switch g
            case 1
                ex='reachH';
            case 2
                ex='reachV';
            case 3
                ex='reachC';
        end
        h=figure
        h1=figure
        distHipLR= [];
        distHipCR= [];
        distHipCL= [];
        posLR = [];
        posCR = [];
        posCL = [];
        for sess=1:maxsess
          data_markers = A.ind{subj,sess,g};
            xyz = [];
            for i=1:3:size(data_markers,2)-2
                xyz = cat(3,xyz, data_markers(:,i:i+2));
            end
           
            distHipLRXsess= [];
            distHipCRXsess= [];
            distHipCLXsess= [];
            
            for trial = 1:length(start{subj,sess,g})
                if isnan(start{subj,sess,g}(trial))
                    continue
                end
                try
                    hipL = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[13]));
                catch
                    keyboard
                end
                hipR = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[17]));
                hipC = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[1]));
                shL = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[5]));
                shR = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[9]));
                shC = squeeze(xyz(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:,[3]));
                
                deltashx(trial) = median(abs(shL(:,1)-shR(:,1)));
                deltashy(trial) = median(abs(shL(:,2)-shR(:,2)));
                deltashz(trial) = median(abs(shL(:,3)-shR(:,3)));
                    
                    deltahipx(trial) = median(abs(hipL(:,1)-hipR(:,1)));
                    deltahipy(trial) = median(abs(hipL(:,2)-hipR(:,3)));
                    deltahipz(trial) = median(abs(hipL(:,2)-hipR(:,3)));
                
                distHipLR= [distHipLR;sqrt(sum((hipL-hipR).^2,2))];
                distHipCR= [distHipCR;sqrt(sum((hipC-hipR).^2,2))];
                distHipCL= [distHipCL;sqrt(sum((hipC-hipL).^2,2))];
                
                distHipLRXsess= [distHipLRXsess;sqrt(sum((hipL-hipR).^2,2))];
                distHipCRXsess= [distHipCRXsess;sqrt(sum((hipC-hipR).^2,2))];
                distHipCLXsess= [distHipCLXsess;sqrt(sum((hipC-hipL).^2,2))];
                
            end
            distHipLRXsess(isnan(distHipLRXsess))=[];
            distHipCRXsess(isnan(distHipCRXsess))=[];
            distHipCLXsess(isnan(distHipCLXsess))=[];
            distHipLR(isnan(distHipLR))=[];
            distHipCR(isnan(distHipCR))=[];
            distHipCL(isnan(distHipCL))=[];
            
            figure(h)
            subplot(3,1,1)
            hold on
            line([length(distHipLR) length(distHipLR)],[0 0.2])
            subplot(3,1,2)
            hold on
            line([length(distHipCR) length(distHipCR)],[0 0.15])
            subplot(3,1,3)
            hold on
            line([length(distHipCL) length(distHipCL)],[0 0.15])
            
            figure(h1)
            subplot(3,1,1)
            hold on
            line([length(distHipLR) length(distHipLR)],[0 0.1])
            subplot(3,1,2)
            hold on
            line([length(distHipCR) length(distHipCR)],[0 0.1])
            subplot(3,1,3)
            hold on
            line([length(distHipCL) length(distHipCL)],[0 0.1])
            
            
            mxsessHipLR(sess) = nanmean(distHipLRXsess);
            mxsessHipCR(sess) = nanmean(distHipCRXsess);
            mxsessHipCL(sess) = nanmean(distHipCLXsess);
            if ~isempty(distHipLRXsess)
                try
                    posLR = [posLR;abs(distHipLRXsess-repmat(mxsessHipLR(sess),size(distHipLRXsess,1),1))];
                catch
                    keyboard
                end
                posCR = [posCR;abs(distHipCRXsess-repmat(mxsessHipCR(sess),size(distHipCRXsess,1),1))];
                posCL = [posCL;abs(distHipCLXsess-repmat(mxsessHipCL(sess),size(distHipCLXsess,1),1))];
                errHipLR(sess) = max(distHipLRXsess)-min(distHipLRXsess);
                errHipCR(sess) = max(distHipCRXsess)-min(distHipCRXsess);
                errHipCL(sess) = max(distHipCLXsess)-min(distHipCLXsess);
                
            end
            
            
            
        end
        % % % % % % % % max error% % % % % % % % % % % % % % % %
        figure;
        b=bar([errHipLR;errHipCR;errHipCL]');
        legend(b,{'distHipLR','distHipCR','distHipCL'});
        ylabel('Max Error [m]')
        suptitle([tit,ex])
        
        figure(h)
        subplot(3,1,1)
        plot(distHipLR,'.')
        ylabel('distHipLR')
        hold on
        box off
        subplot(3,1,2)
        plot(distHipCR,'.')
        ylabel('distHipCR')
        hold on
        box off
        subplot(3,1,3)
        plot(distHipCL,'.')
        ylabel('distHipCL')
        hold on
        box off
        suptitle([tit,ex])
        
        %         saveas(gcf,['figs',filesep,'MaxError'],'png')
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        lm = max([posLR;posCR;posCL]);
        figure(h1)
        subplot(3,1,1)
        plot(posLR,'.')
        ylim([0 lm])
        ylabel('errLR')
        hold on
        box off
        subplot(3,1,2)
        plot(posCR,'.')
        ylim([0 lm])
        ylabel('errCR')
        hold on
        box off
        subplot(3,1,3)
        plot(posCL,'.')
        ylim([0 lm])
        ylabel('errCL')
        hold on
        box off
        suptitle([tit,'subj',num2str(subj),ex])
%             set(gcf,'pos',[217,359 1015,377])
%             saveas(gcf,['figs',filesep,'DistfromMean',num2str(s)],'png')
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
    end
end









% end

