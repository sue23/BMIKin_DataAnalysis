function BodyVariability(datadir)
%This function generates plots of shoulders and pelvis variability during
%the three reaching exercises: horizontal, vertical and cross
choice = questdlg('Vuoi graficare bodyvar di ogni componente oppure il ratio tra sh e hip?', ...
    '', ...
    'bodyvar','ratio','ratio');
switch choice
    case 'bodyvar'
        ratio = 0;
    case 'ratio'
        ratio = 1;
end

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
varshouldL = load(['mats',filesep,'varshouldL']);
varshouldR = load(['mats',filesep,'varshouldR']);
varpelvisL = load(['mats',filesep,'varpelvisL']);
varpelvisR = load(['mats',filesep,'varpelvisR']);

%%% Left Perlvis HORIZONTAL
v.varpelvisL_xo=varpelvisL.ind.andate_x(:,:,1);
v.varpelvisL_xo(v.varpelvisL_xo==0)=nan;
v.varpelvisL_yo=varpelvisL.ind.andate_y(:,:,1);
v.varpelvisL_yo(v.varpelvisL_yo==0)=nan;
v.varpelvisL_zo=varpelvisL.ind.andate_z(:,:,1);
v.varpelvisL_zo(v.varpelvisL_zo==0)=nan;
%%% Left Pelvis VERTICAL
v.varpelvisL_xv=varpelvisL.ind.andate_x(:,:,2);
v.varpelvisL_xv(v.varpelvisL_xv==0)=nan;
v.varpelvisL_yv=varpelvisL.ind.andate_y(:,:,2);
v.varpelvisL_yv(v.varpelvisL_yv==0)=nan;
v.varpelvisL_zv=varpelvisL.ind.andate_z(:,:,2);
v.varpelvisL_zv(v.varpelvisL_zv==0)=nan;
%%% Left Pelvis CROSS
v.varpelvisL_xc=varpelvisL.ind.andate_x(:,:,3);
v.varpelvisL_xc(v.varpelvisL_xc==0)=nan;
v.varpelvisL_yc=varpelvisL.ind.andate_y(:,:,3);
v.varpelvisL_yc(v.varpelvisL_yc==0)=nan;
v.varpelvisL_zc=varpelvisL.ind.andate_z(:,:,3);
v.varpelvisL_zc(v.varpelvisL_zc==0)=nan;
%%% Right Perlvis HORIZONTAL
v.varpelvisR_xo=varpelvisR.ind.andate_x(:,:,1);
v.varpelvisR_xo(v.varpelvisR_xo==0)=nan;
v.varpelvisR_yo=varpelvisR.ind.andate_y(:,:,1);
v.varpelvisR_yo(v.varpelvisR_yo==0)=nan;
v.varpelvisR_zo=varpelvisR.ind.andate_z(:,:,1);
v.varpelvisR_zo(v.varpelvisR_zo==0)=nan;
%%% Right Pelvis VERTICAL
v.varpelvisR_xv=varpelvisR.ind.andate_x(:,:,2);
v.varpelvisR_xv(v.varpelvisR_xv==0)=nan;
v.varpelvisR_yv=varpelvisR.ind.andate_y(:,:,2);
v.varpelvisR_yv(v.varpelvisR_yv==0)=nan;
v.varpelvisR_zv=varpelvisR.ind.andate_z(:,:,2);
v.varpelvisR_zv(v.varpelvisR_zv==0)=nan;
%%% Right Pelvis CROSS
v.varpelvisR_xc=varpelvisR.ind.andate_x(:,:,3);
v.varpelvisR_xc(v.varpelvisR_xc==0)=nan;
v.varpelvisR_yc=varpelvisR.ind.andate_y(:,:,3);
v.varpelvisR_yc(v.varpelvisR_yc==0)=nan;
v.varpelvisR_zc=varpelvisR.ind.andate_z(:,:,3);
v.varpelvisR_zc(v.varpelvisR_zc==0)=nan;
%%% Left Shoulder HORIZONTAL
v.varshL_xo=varshouldL.ind.andate_x(:,:,1);
v.varshL_xo(v.varshL_xo==0)=nan;
v.varshL_yo=varshouldL.ind.andate_y(:,:,1);
v.varshL_yo(v.varshL_yo==0)=nan;
v.varshL_zo=varshouldL.ind.andate_z(:,:,1);
v.varshL_zo(v.varshL_zo==0)=nan;
%%% Left Shoulder VERTICAL
v.varshL_xv=varshouldL.ind.andate_x(:,:,2);
v.varshL_xv(v.varshL_xv==0)=nan;
v.varshL_yv=varshouldL.ind.andate_y(:,:,2);
v.varshL_yv(v.varshL_yv==0)=nan;
v.varshL_zv=varshouldL.ind.andate_z(:,:,2);
v.varshL_zv(v.varshL_zv==0)=nan;
%%% Left Shoulder CROSS
v.varshL_xc=varshouldL.ind.andate_x(:,:,3);
v.varshL_xc(v.varshL_xc==0)=nan;
v.varshL_yc=varshouldL.ind.andate_y(:,:,3);
v.varshL_yc(v.varshL_yc==0)=nan;
v.varshL_zc=varshouldL.ind.andate_z(:,:,3);
v.varshL_zc(v.varshL_zc==0)=nan;
%%% Right Shoulder HORIZONTAL
v.varshR_xo=varshouldR.ind.andate_x(:,:,1);
v.varshR_xo(v.varshR_xo==0)=nan;
v.varshR_yo=varshouldR.ind.andate_y(:,:,1);
v.varshR_yo(v.varshR_yo==0)=nan;
v.varshR_zo=varshouldR.ind.andate_z(:,:,1);
v.varshR_zo(v.varshR_zo==0)=nan;
%%% Right Shoulder VERTICAL
v.varshR_xv=varshouldR.ind.andate_x(:,:,2);
v.varshR_xv(v.varshR_xv==0)=nan;
v.varshR_yv=varshouldR.ind.andate_y(:,:,2);
v.varshR_yv(v.varshR_yv==0)=nan;
v.varshR_zv=varshouldR.ind.andate_z(:,:,2);
v.varshR_zv(v.varshR_zv==0)=nan;
%%% Right Shoulder CROSS
v.varshR_xc=varshouldR.ind.andate_x(:,:,3);
v.varshR_xc(v.varshR_xc==0)=nan;
v.varshR_yc=varshouldR.ind.andate_y(:,:,3);
v.varshR_yc(v.varshR_yc==0)=nan;
v.varshR_zc=varshouldR.ind.andate_z(:,:,3);
v.varshR_zc(v.varshR_zc==0)=nan;

%%%%%VAR RATIO%%%%%%%%%
%%% Left Shoulder/hips HORIZONTAL
r.ratioL_xo=v.varshL_xo./v.varpelvisL_xo;
r.ratioL_yo=v.varshL_yo./v.varpelvisL_yo;
r.ratioL_zo=v.varshL_zo./v.varpelvisL_zo;

%%% Left Shoulder/hip VERTICAL
r.ratioL_xv=v.varshL_xv./v.varpelvisL_xv;
r.ratioL_yv=v.varshL_yv./v.varpelvisL_yv;
r.ratioL_zv=v.varshL_zv./v.varpelvisL_zv;

%%% Left Shoulder/hip CROSS
r.ratioL_xc=v.varshL_xc./v.varpelvisL_xc;
r.ratioL_yc=v.varshL_yc./v.varpelvisL_yc;
r.ratioL_zc=v.varshL_zc./v.varpelvisL_zc;

%%% Right Shoulder/hip HORIZONTAL
r.ratioR_xo=v.varshR_xo./v.varpelvisR_xo;
r.ratioR_yo=v.varshR_yo./v.varpelvisR_yo;
r.ratioR_zo=v.varshR_zo./v.varpelvisR_zo;

%%% Right Shoulder/hip VERTICAL
r.ratioR_xv=v.varshR_xv./v.varpelvisR_xv;
r.ratioR_yv=v.varshR_yv./v.varpelvisR_yv;
r.ratioR_zv=v.varshR_zv./v.varpelvisR_zv;

%%% Right Shoulder/hip CROSS
r.ratioR_xc=v.varshR_xc./v.varpelvisR_xc;
r.ratioR_yc=v.varshR_yc./v.varpelvisR_yc;
r.ratioR_zc=v.varshR_zc./v.varpelvisR_zc;

% horz = varcuro_y./ varcuro_x;
% vert = varcurv_x./ varcurv_y;

for subj=1:length(soggetti)
    %similmente a prima dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
    if maxsess>10 | maxsess<5
        display('WARNING! Sessions more than 10');
        keyboard
    end
    
    if training
        [threshold{subj}]=importThresholds(soggetti{subj});
        
        rows.x =find(diff(threshold{subj}(:,1))~=0);
        rows.y =find(diff(threshold{subj}(:,2))~=0);
        rows.z =find(diff(threshold{subj}(:,3))~=0);
        if ~ratio
            [ h1,h2,h3,h4,h5,h6 ] = Plot_bodyVar_training( v,subj,rows );
        else
            [ h1,h2,h3 ] = Plot_ratioVar_training( r,subj,rows );
        end
        %%
    else
        if ~ratio
            [ h1,h2,h3,h4,h5,h6 ] = Plot_bodyVar_PrePost( v,subj,maxsess );
        else
            [ h1,h2,h3 ] = Plot_ratioVar_PrePost( r,subj,maxsess );
        end
    end
    %%% save figures
    if ~ratio
        saveas(h1,['figs',filesep,'bodyvar',filesep,soggetti{subj},'horizontalReach_shouldvar',num2str(training)],'png')
        saveas(h2,['figs',filesep,'bodyvar',filesep,soggetti{subj},'verticalReach_shouldvar',num2str(training)],'png')
        saveas(h3,['figs',filesep,'bodyvar',filesep,soggetti{subj},'horizontalReach_pelvisvar',num2str(training)],'png')
        saveas(h4,['figs',filesep,'bodyvar',filesep,soggetti{subj},'verticalReach_pelvisvar',num2str(training)],'png')
        saveas(h5,['figs',filesep,'bodyvar',filesep,soggetti{subj},'crossReach_shouldvar',num2str(training)],'png')
        saveas(h6,['figs',filesep,'bodyvar',filesep,soggetti{subj},'crossReach_pelvisvar',num2str(training)],'png')
    else
        saveas(h1,['figs',filesep,'bodyvar',filesep,soggetti{subj},'horizontalReach_ratiovar',num2str(training)],'png')
        saveas(h2,['figs',filesep,'bodyvar',filesep,soggetti{subj},'verticalReach_ratiovar',num2str(training)],'png')
        saveas(h3,['figs',filesep,'bodyvar',filesep,soggetti{subj},'horizontalReach_ratiovar',num2str(training)],'png')
    end
    close all
end %end subj
