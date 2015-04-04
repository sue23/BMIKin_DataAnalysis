function  plotReconstructedTraj(cursor_mov,reach_mov,soggetti)
%plotReconstructedTraj
%   cursor mov: il movimento del cursore reale
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
% switch g
%     case 1
%         Target=Targets(:,[4,8])';
%     case 2
%         Target=Targets(:,[2,6])';
%     case 3
%         Target=Targets(:,[2 4 6 8])';
%     case 4
%         Target=Targets';
% end

for subj=1:size(cursor_mov,1)
    h1=figure;
    set(h1,'pos',[1   286   560   420])
    h2=figure;
    set(h2,'pos',[1   286   560   420])
    Target=Targets(:,[4,8])';
    for sess=1:size(cursor_mov,2)
        %Horizontal
        figure(h1)
        subplot(2,5,sess)
        if sum(~isnan(cursor_mov{subj,sess,1}),2)<=size(~isnan(cursor_mov{subj,sess,1}),2)%
            if size(cursor_mov{subj,sess,1},2)>1
                
                plot(reach_mov{subj,sess,1}(1,:),reach_mov{subj,sess,1}(2,:),'ro')
            end
        end
        hold on
        if sum(~isnan(cursor_mov{subj,sess,1}),1)<=size(~isnan(cursor_mov{subj,sess,1}),1)
            if  size(cursor_mov{subj,sess,1})>1
                plot(cursor_mov{subj,sess,1}(:,2),cursor_mov{subj,sess,1}(:,3),'go')
            end
        end
        plot(Target(:,1),Target(:,2),'bo','MarkerSize',2*TR,'LineWidth',2,'MarkerEdgeColor','b');
        title(['Sessione',num2str(sess)])
        xlabel('X axis')
        ylabel('Y axis')
        axis equal
        ylim([0 768])
        xlim([0 1024])
        box off
        
        figure(h2)
        subplot(2,5,sess)
        if sum(~isnan(cursor_mov{subj,sess,1}),2)<=size(~isnan(cursor_mov{subj,sess,1}),2)%
            if size(cursor_mov{subj,sess,1},2)>1
                plot(reach_mov{subj,sess,1}(1,:),'go')
            end
        end
        %         reach_mov(2,end);
        hold on
        if sum(~isnan(cursor_mov{subj,sess,1}),1)<=size(~isnan(cursor_mov{subj,sess,1}),1)
            if  size(cursor_mov{subj,sess,1})>1
                plot(cursor_mov{subj,sess,1}(:,2),'ro')
            end
        end
        xlabel('Time')
        ylabel('X coordinate')
        legend('Reconstructed','Real')
        
        box off
        title(['session',num2str(sess)])
    end
    
    
    h3=figure;
    set(h3,'pos',[1   286   560   420])
    h4=figure;
    set(h4,'pos',[1   286   560   420])
    Target=Targets(:,[2,6])';
    for sess=1:size(cursor_mov,2)
        figure(h3)
        subplot(2,5,sess)
        if sum(~isnan(cursor_mov{subj,sess,2}),2)<=size(~isnan(cursor_mov{subj,sess,2}),2)
            if  size(cursor_mov{subj,sess,2})>1
                
                plot(reach_mov{subj,sess,2}(1,:),reach_mov{subj,sess,2}(2,:),'ro')
            end
        end
        hold on
        if sum(~isnan(cursor_mov{subj,sess,2}),1)<=size(~isnan(cursor_mov{subj,sess,2}),1)
            if  size(cursor_mov{subj,sess,2})>1
                plot(cursor_mov{subj,sess,2}(:,2),cursor_mov{subj,sess,2}(:,3),'go')
            end
        end
        plot(Target(:,1),Target(:,2),'bo','MarkerSize',2*TR,'LineWidth',2,'MarkerEdgeColor','b');
        title(['Sessione',num2str(sess)])
        xlabel('X axis')
        ylabel('Y axis')
        axis equal
        ylim([0 768])
        xlim([0 1024])
        box off
        
        figure(h4)
        subplot(2,5,sess)
        if sum(~isnan(cursor_mov{subj,sess,2}),2)<=size(~isnan(cursor_mov{subj,sess,2}),2)
            if  size(cursor_mov{subj,sess,2})>1
                plot(reach_mov{subj,sess,2}(2,:),'go')
            end
        end
        %         reach_mov(2,end);
        hold on
        if sum(~isnan(cursor_mov{subj,sess,2}),1)<=size(~isnan(cursor_mov{subj,sess,2}),1)
            if  size(cursor_mov{subj,sess,2})>1
                plot(cursor_mov{subj,sess,2}(:,3),'ro')
            end
        end
        xlabel('Time')
        ylabel('Y coordinate')
        legend('Reconstructed','Real')
        
        box off
        title(['session',num2str(sess)])
    end
    saveas(h1,['figs',filesep,soggetti{subj},'_horizontalreconstruction'],'png')
    saveas(h3,['figs',filesep,soggetti{subj},'_verticalreconstruction'],'png')
    %     figure(h2)
    %     suptitle(['Soggetto: ',soggetti{subj}])
    %     saveas(h2,['figs',filesep,soggetti{subj},'_TimeTrendofX-coordinate'],'png')
    %     figure(h4)
    %     suptitle(['Soggetto: ',soggetti{subj}])
    %     saveas(h4,['figs',filesep,soggetti{subj},'_TimeTrendofY-coordinate'],'png')
    close all
end

