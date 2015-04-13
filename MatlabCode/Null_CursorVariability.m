function Null_CursorVariability(datadir)
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
var = load([pwd,filesep,'mats',filesep,'Tvarcur']);
tvarcuro_x=var.ind.andate(:,:,1);
totvar = sum(tvarcuro_x);
tvarcuro_x(tvarcuro_x==0)=nan;
% tvarcuro_x=tvarcuro_x./repmat(totvar,size(tvarcuro_x,1),1)

tvarcurv_y=var.ind.andate(:,:,2);
totvar = sum(tvarcurv_y);
tvarcurv_y(tvarcurv_y==0)=nan;
% tvarcurv_y=tvarcurv_y./repmat(totvar,size(tvarcurv_y,1),1)


tvarcurc_c=var.ind.andate(:,:,3);
totvar = sum(tvarcurc_c);
tvarcurc_c(tvarcurc_c==0)=nan;
% tvarcurc_c=tvarcurc_c./repmat(totvar,size(tvarcurc_c,1),1)




var = load(['mats',filesep,'Nvarcur']);
nvarcuro_x=var.ind.andate(:,:,1);
totvar = sum(nvarcuro_x);
nvarcuro_x(nvarcuro_x==0)=nan;
% nvarcuro_x=nvarcuro_x./repmat(totvar,size(nvarcuro_x,1),1)


nvarcurv_y=var.ind.andate(:,:,2);
totvar = sum(nvarcurv_y);
nvarcurv_y(nvarcurv_y==0)=nan;
% nvarcurv_y=nvarcurv_y./repmat(totvar,size(nvarcurv_y,1),1)


nvarcurc_c=var.ind.andate(:,:,3);
totvar = sum(nvarcurc_c);
nvarcurc_c(nvarcurc_c==0)=nan;
% nvarcurc_c=nvarcurc_c./repmat(totvar,size(nvarcurc_c,1),1)



for subj=1:length(soggetti)
    %similmente a prima dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
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
        bar(tvarcuro_x(:,subj))
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(tvarcuro_x(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(tvarcuro_x(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(tvarcuro_x(:,subj))],'col','k')
        end
        title('Tasl var(x) reaching Horiz')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        
        subplot(1,2,2)
        bar(nvarcuro_x(:,subj))
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(nvarcuro_x(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(nvarcuro_x(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(nvarcuro_x(:,subj))],'col','k')
        end
        title('Null var(x) reaching Horiz')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        
        % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        h2=figure;
        subplot(1,2,1)
        bar(tvarcurv_y(:,subj))
        if isempty(rows_x)==0
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(tvarcurv_y(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(tvarcurv_y(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(tvarcurv_y(:,subj))],'col','k')
        end
        title('Task var(x) reaching vert')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(nvarcurv_y(:,subj))
        if isempty(rows_x)==0
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(nvarcurv_y(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(nvarcurv_y(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(nvarcurv_y(:,subj))],'col','k')
        end
        title('Null var(y) reaching vert')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        
        h3=figure;
        subplot(1,2,1)
        bar(tvarcurc_c(:,subj))
        if isempty(rows_x)==0
            if length(rows_x)==2
                rows_x=[rows_x;nan];
            end
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(tvarcurc_c(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            if length(rows_y)==2
                rows_y=[rows_y;nan];
            end
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(tvarcurc_c(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            if length(rows_z)==2
                rows_z=[rows_z;nan];
            end
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(tvarcurc_c(:,subj))],'col','k')
        end
        title('Task var(x) reaching cross')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(nvarcurc_c(:,subj))
        if isempty(rows_x)==0
            hr=line([rows_x+0.4 rows_x+0.4],[0 max(nvarcurc_c(:,subj))],'col','r')
        end
        if isempty(rows_y)==0
            hg=line([rows_y+0.5 rows_y+0.5],[0 max(nvarcurc_c(:,subj))],'col','g')
        end
        if isempty(rows_z)==0
            hk=line([rows_z+0.6 rows_z+0.6],[0 max(nvarcurc_c(:,subj))],'col','k')
        end
        title('Null var(y) reaching cross')
        legend([hr(1) hg(1) hk(1)],{'x','y','z'})
        xlabel('Sessions')
        box off
    else
        %% HORIZONTAL Reaching
        first = min(find(~isnan(tvarcuro_x(:,subj))));
        last = max(find(~isnan(tvarcuro_x(:,subj))));
        h1=figure;
        subplot(1,2,1)
        bar(tvarcuro_x([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Var in Task Space Reaching Horizontal')
        xlabel('Sessions')
        box off
        
        subplot(1,2,2)
        bar(nvarcuro_x([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Var in Null Space Reaching Horizontal')
        xlabel('Sessions')
        box off
        
 %% VERTICAL Reacing
 % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        first = min(find(~isnan(tvarcurv_y(:,subj))));
        last = max(find(~isnan(tvarcurv_y(:,subj))));
        h2=figure;
        subplot(1,2,1)
        bar(tvarcurv_y([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Var in Task Space Reaching Vertical')
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(nvarcurv_y([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Var in Null Space Reaching Vertical')
        xlabel('Sessions')
        box off
      %% CROSS Reaching
      first = min(find(~isnan(tvarcurc_c(:,subj))));
        last = max(find(~isnan(tvarcurc_c(:,subj))));
        h3=figure;
        subplot(1,2,1)
        bar(tvarcurc_c([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Var in Task Space reaching cross')
        xlabel('Sessions')
        box off
        subplot(1,2,2)
        bar(nvarcurc_c([first last],subj))
        ax = gca;
        ax.XTickLabel = {'Pre','Post'};
        title('Var in Null Space reaching cross')
        xlabel('Sessions')
        box off
    end
    saveas(h1,['figs',filesep,'cursorvar',filesep,soggetti{subj},'hHorizontal_varnull',num2str(training)],'png')
    saveas(h2,['figs',filesep,'cursorvar',filesep,soggetti{subj},'vertical_varnull',num2str(training)],'png')
    saveas(h3,['figs',filesep,'cursorvar',filesep,soggetti{subj},'cross_varnull',num2str(training)],'png')
    
    close all
end %end subj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
