function  [vertseq,horizseq]=plotReconstructedTrajByTraj(reach_mov,start,stop,start2,stop2,MT,soggetti)
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
    h3=figure;
    set(h3,'pos',[1   286   560   420])
    h2=figure;
    set(h2,'pos',[1   286   560   420])
    for sess=1:size(reach_mov,2)

        %Horizontal
        figure(h1)
        subplot(2,5,sess)
        plot(Targets(1,[4 8]),Targets(2,[4 8]),'bo','MarkerSize',2*TR,'LineWidth',2,'MarkerEdgeColor','b');
        hold on
        title(['Session',num2str(sess)])
        xlabel('X axis')
        ylabel('Y axis')
        axis equal
        ylim([0 768])
        xlim([0 1024])
        box off
        if isempty(MT{subj,sess,1})
            continue
        end
        
        horizseq{subj,sess} = nan*ones(1,length(start{subj,sess,1}));
        vertseq{subj,sess} = nan*ones(1,length(start{subj,sess,2}));
        for trial=1:length(start{subj,sess,1})
            
            
            
            if ~isnan(reach_mov{subj,sess,1}(1,start{subj,sess,1}(trial):stop{subj,sess,1}(trial)))
     
                [~,horizseq{subj,sess}(trial)] = min(sqrt(sum((repmat(reach_mov{subj,sess,1}(:,stop{subj,sess,1}(trial)),1,2)-Targets(:,[4 8])).^2)));
                %                                     if isnan(newMT1(trial))
                %                                         plot(reach_mov{subj,sess,1}(1,start{subj,sess,1}(trial):stop{subj,sess,1}(trial)),reach_mov{subj,sess,1}(2,start{subj,sess,1}(trial):stop{subj,sess,1}(trial)),'co')
                %                                     else
                if ~isnan(MT{subj,sess,1}(trial))
                    try
                        %                     plot(reach_mov{subj,sess,1}(1,start2{subj,sess,1}(trial):stop2{subj,sess,1}(trial)),reach_mov{subj,sess,1}(2,start2{subj,sess,1}(trial):stop2{subj,sess,1}(trial)),'go')
                    catch
                        keyboard
                    end
                    plot(reach_mov{subj,sess,1}(1,start{subj,sess,1}(trial):stop{subj,sess,1}(trial)),reach_mov{subj,sess,1}(2,start{subj,sess,1}(trial):stop{subj,sess,1}(trial)),'ro')
                    
                end
            end
            
        end
        
        figure(h3)
        subplot(2,5,sess)
        plot(Targets(1,[2 6]),Targets(2,[2 6]),'bo','MarkerSize',2*TR,'LineWidth',2,'MarkerEdgeColor','b');
        hold on
        title(['Session',num2str(sess)])
        xlabel('X axis')
        ylabel('Y axis')
        axis equal
        ylim([0 768])
        xlim([0 1024])
        box off
        if  isempty(MT{subj,sess,2})
            continue
        end
        for trial=1:length(start{subj,sess,2})
            
            if ~isnan(reach_mov{subj,sess,2}(1,start{subj,sess,2}(trial):stop{subj,sess,2}(trial)))
                [~,vertseq{subj,sess}(trial)] = min(sqrt(sum((repmat(reach_mov{subj,sess,2}(:,stop{subj,sess,2}(trial)),1,2)-Targets(:,[2 6])).^2)));

                %                                 if isnan(newMT2(trial))
                %                                     plot(reach_mov{subj,sess,2}(1,start{subj,sess,2}(trial):stop{subj,sess,2}(trial)),reach_mov{subj,sess,2}(2,start{subj,sess,2}(trial):stop{subj,sess,2}(trial)),'co')
                %                                 else
                if ~isnan(MT{subj,sess,2}(trial))
                    %                     plot(reach_mov{subj,sess,2}(1,start2{subj,sess,2}(trial):stop2{subj,sess,2}(trial)),reach_mov{subj,sess,2}(2,start2{subj,sess,2}(trial):stop2{subj,sess,2}(trial)),'go')
                    plot(reach_mov{subj,sess,2}(1,start{subj,sess,2}(trial):stop{subj,sess,2}(trial)),reach_mov{subj,sess,2}(2,start{subj,sess,2}(trial):stop{subj,sess,2}(trial)),'ro')
                    
                end
            end
            
            
        end
        
    end
    
%     saveas(h1,['figs',filesep,soggetti{subj},'_horizontalreconstruction'],'png')
%     saveas(h3,['figs',filesep,soggetti{subj},'_verticalreconstruction'],'png')
    close all
    
end


