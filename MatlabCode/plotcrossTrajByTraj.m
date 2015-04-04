function  plotcrossTrajByTraj(reach_mov,start,stop,start2,stop2,MT,soggetti,vertseq,horizseq)
%plotReconstructedTraj
%   reach mov: il movimento del reach reale
%   reach_mov: il movimento ricostruito

%Target locations
%
%           2
%       3       1
%
%     4           8
%
%       5       7
%           6
%
sz=[1 1 1024 768];
initial=[sz(3)/2; sz(4)/2];
dist = ceil(sz(4)/2)*0.8;
TR = 5;
for ii=1:8
    alfa = 2*pi*ii/8;
    Targets(1:2,ii) = initial + dist*[cos(alfa);sin(alfa)];
end

cursor=reach_mov;
for subj=1:size(reach_mov,1)
    h1=figure;
    set(h1,'pos',[1   286   560   420])
    
    for sess=1:size(reach_mov,2)
        figure(h1)
        subplot(2,5,sess)
        plot(Targets(1,[2 4 6 8]),Targets(2,[2 4 6 8]),'bo','MarkerSize',2*TR,'LineWidth',2,'MarkerEdgeColor','b');
        hold on
        title(['Session',num2str(sess)])
        xlabel('X axis')
        ylabel('Y axis')
        axis equal
        ylim([0 768])
        xlim([0 1024])
        box off
        if isempty(MT{subj,sess,3})
            continue
        end
                crossseq{subj,sess} = nan*ones(1,length(start{subj,sess,3}));
        for trial=1:length(start{subj,sess,3})
            
            %Cross
            
            
            if ~isnan(reach_mov{subj,sess,3}(start{subj,sess,3}(trial):stop{subj,sess,3}(trial),1))
                 [~,crossseq{subj,sess}(trial)] = min(sqrt(sum((repmat(reach_mov{subj,sess,3}(stop{subj,sess,3}(trial),[2 3])',1,4)-Targets(:,[2 4 6 8])).^2)));

                %                                     if isnan(newMT1(trial))
                %                                         plot(reach_mov{subj,sess,1}(1,start{subj,sess,1}(trial):stop{subj,sess,1}(trial)),reach_mov{subj,sess,1}(2,start{subj,sess,1}(trial):stop{subj,sess,1}(trial)),'co')
                %                                     else
                if ~isnan(MT{subj,sess,3}(trial))
                    try
                        %                     plot(reach_mov{subj,sess,3}(start2{subj,sess,3}(trial):stop2{subj,sess,3}(trial),2),reach_mov{subj,sess,3}(start2{subj,sess,3}(trial):stop2{subj,sess,3}(trial),3),'go')
                    catch
                        keyboard
                    end
                    plot(reach_mov{subj,sess,3}(start{subj,sess,3}(trial):stop{subj,sess,3}(trial),2),reach_mov{subj,sess,3}(start{subj,sess,3}(trial):stop{subj,sess,3}(trial),3),'ro')
                    
                end
            end
            
        end
        
    end
    
    
    saveas(h1,['figs',filesep,soggetti{subj},'_crosreach'],'png')
    
    close all
    
    
end

save(['mats',filesep,'targetseq'],'vertseq','horizseq','crossseq')