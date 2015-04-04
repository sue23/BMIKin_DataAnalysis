function CursorVariability(datadir)
%Questa funzione parte dai segnali del kinect e ricostruisce caricando la mappa i movimenti del cursore
%ORGANIZZAZIONE VARIABILI NELLA MATRICE DATA
% Data rows:
% 1- Simulink time
% 2- CPU time
% 3-Cursor-X
% 4- Cursor-Y
% 5- Main Menu State
% 6- Reaching State
% 7- Game State
% 8- Ball-X
% 9- Ball-Y
% 10- Number of hits
% 11- Ball-X rot
% 12 Ball-Y rot
% 13 Number of hits rot
% 14- Tetris Lines
% 15- Control ( 1=subject 0=experimenter)
% 16- Previous Game State
% 17-tracking
% 18:78- marker kinect
% 79- busto
% 80-spalle
% 81-thbusto
% 82-thx
% 83-thy
% 84-thz
choice = questdlg('Vuoi graficare andamento nel training?', ...
    '', ...
    'Si','No','No');
switch choice
    case 'No'
        training = 0;
    case 'Si'
        training = 1;
end
%nella cartella datadir c'? una cartella per ogni soggetto che contiene
%tutti i dati
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
var = load(['mats',filesep,'varcur']);
varcuro_x=var.ind.andate_x(:,:,1);
varcuro_x(varcuro_x==0)=nan;
varcuro_y=var.ind.andate_y(:,:,1);
varcuro_y(varcuro_y==0)=nan;
varcurv_x=var.ind.andate_x(:,:,2);
varcurv_x(varcurv_x==0)=nan;
varcurv_y=var.ind.andate_y(:,:,2);
varcurv_y(varcurv_y==0)=nan;
varcurc_x=var.ind.andate_x(:,:,3);
varcurc_x(varcurc_x==0)=nan;
varcurc_y=var.ind.andate_y(:,:,3);
varcurc_y(varcurc_y==0)=nan;
last=[1 7;2 10;3 6]
keyboard
horz = varcuro_y./ varcuro_x;
vert = varcurv_x./ varcurv_y;

h=figure;
for subj=1:3%length(soggetti)
    %similmente a prima dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    ho(subj,:) = horz([1 maxsess],subj)';
    ve(subj,:) = vert([1 maxsess],subj)';
   
    
    
    if maxsess>10
        display('WARNING! Sessions more than 10');
        keyboard
    end
    
    if training
        [threshold{subj}]=importThresholds(soggetti{subj});
        %     for sess=1:maxsess
        %
        %
        %     end %of sess
        
        rows_x =find(diff(threshold{subj}(:,1))~=0);
        rows_y =find(diff(threshold{subj}(:,2))~=0);
        rows_z =find(diff(threshold{subj}(:,3))~=0);
        h1=figure;
        subplot(1,2,1)
        bar(varcuro_x(:,subj))
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(varcuro_x(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(varcuro_x(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(varcuro_x(:,subj))],'col','k')
        end
        title('var(x) reaching Horiz')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(varcuro_y(:,subj))
        if isempty(rows_x)==0
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(varcuro_y(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(varcuro_y(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(varcuro_y(:,subj))],'col','k')
        end
        title('var(y) reaching Horiz')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        h2=figure;
        subplot(1,2,1)
        bar(varcurv_x(:,subj))
        if isempty(rows_x)==0
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(varcurv_x(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(varcurv_x(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(varcurv_x(:,subj))],'col','k')
        end
        title('var(x) reaching vert')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(varcurv_y(:,subj))
        if isempty(rows_x)==0
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(varcurv_y(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(varcurv_y(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(varcurv_y(:,subj))],'col','k')
        end
        title('var(y) reaching vert')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        h3=figure;
        subplot(1,2,1)
        bar(varcurc_x(:,subj))
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(varcurc_x(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(varcurc_x(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(varcurc_x(:,subj))],'col','k')
        end
        title('var(x) reaching cross')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(varcurc_y(:,subj))
        if isempty(rows_x)==0
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(varcurc_y(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(varcurc_y(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(varcurc_y(:,subj))],'col','k')
        end
        title('var(y) reaching cross')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
    else
        first = min(find(~isnan(varcuro_x(:,subj))));
        last = max(find(~isnan(varcuro_x(:,subj))));
        h1=figure;
        subplot(1,2,1)
        bar(varcuro_x([first last],subj))
        title('var(x) reaching Horiz')
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(varcuro_y([first last],subj))
        title('var(y) reaching Horiz')
        xlabel('Sessions')
        box off
        
        %% VERTICAL Reaching
        first = min(find(~isnan(varcurv_x(:,subj))));
        last = max(find(~isnan(varcurv_x(:,subj))));
        h2=figure;
        subplot(1,2,1)
        bar(varcurv_x([first last],subj))
        title('var(x) reaching vert')
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(varcurv_y([first last],subj))
        title('var(y) reaching vert')
        xlabel('Sessions')
        box off
        
        
%% CROSS REACHING
        first = min(find(~isnan(varcurc_x(:,subj))));
        last = max(find(~isnan(varcurc_x(:,subj))));
        h3=figure;
        subplot(1,2,1)
        bar(varcurc_x([first last],subj))
        title('var(x) reaching cross')
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(varcurc_y([first last],subj))
        title('var(y) reaching cross')
        xlabel('Sessions')
        box off
    end
    saveas(h1,['figs',filesep,'cursorvar',filesep,soggetti{subj},'hHorizontal_varcoordinate',num2str(training)],'png')
    saveas(h2,['figs',filesep,'cursorvar',filesep,soggetti{subj},'vertical_varcoordinate',num2str(training)],'png')
    saveas(h3,['figs',filesep,'cursorvar',filesep,soggetti{subj},'cross_varcoordinate',num2str(training)],'png')
    
    close(h1)
    close(h2)
    close(h3)
end %end subj
 figure(h)
    subplot(2,1,1)
    bar(ho);
    set(gca,'XTick',[1 2 3],'XTickLabel',{'Sabject 1','Subject 2','Subject 3'});
    legend('First session','Last session')
    legend boxoff
    box off
    title('Horizontal')
    subplot(2,1,2)
    bar(ve)
    set(gca,'XTick',[1 2 3],'XTickLabel',{'Sabject 1','Subject 2','Subject 3'});
    legend('First session','Last session')
    legend boxoff
    box off
    title('Vertical')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
