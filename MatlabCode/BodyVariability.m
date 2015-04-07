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

ReachKinectData = load(['mats',filesep,'ReachKinectData']);
outlier = load(['mats',filesep,'outliers']);
% inizializzo matrici
%%% Left Perlvis HORIZONTAL
v.varpelvisL_xo=ones(10,3).*nan;
v.varpelvisL_yo=ones(10,3).*nan;
v.varpelvisL_zo=ones(10,3).*nan;
%%% Left Pelvis VERTICAL
v.varpelvisL_xv=ones(10,3).*nan;
v.varpelvisL_yv=ones(10,3).*nan;
v.varpelvisL_zv=ones(10,3).*nan;
%%% Left Pelvis CROSS
v.varpelvisL_xc=ones(10,3).*nan;
v.varpelvisL_yc=ones(10,3).*nan;
v.varpelvisL_zc=ones(10,3).*nan;
%%% Right Perlvis HORIZONTAL
v.varpelvisR_xo=ones(10,3).*nan;
v.varpelvisR_yo=ones(10,3).*nan;
v.varpelvisR_zo=ones(10,3).*nan;
%%% Right Pelvis VERTICAL
v.varpelvisR_xv=ones(10,3).*nan;
v.varpelvisR_yv=ones(10,3).*nan;
v.varpelvisR_zv=ones(10,3).*nan;
%%% Right Pelvis CROSS
v.varpelvisR_xc=ones(10,3).*nan;
v.varpelvisR_yc=ones(10,3).*nan;
v.varpelvisR_zc=ones(10,3).*nan;
%%% Left Shoulder HORIZONTAL
v.varshL_xo=ones(10,3).*nan;
v.varshL_yo=ones(10,3).*nan;
v.varshL_zo=ones(10,3).*nan;
%%% Left Shoulder VERTICAL
v.varshL_xv=ones(10,3).*nan;
v.varshL_yv=ones(10,3).*nan;
v.varshL_zv=ones(10,3).*nan;
%%% Left Shoulder CROSS
v.varshL_xc=ones(10,3).*nan;
v.varshL_yc=ones(10,3).*nan;
v.varshL_zc=ones(10,3).*nan;
%%% Right Shoulder HORIZONTAL
v.varshR_xo=ones(10,3).*nan;
v.varshR_yo=ones(10,3).*nan;
v.varshR_zo=ones(10,3).*nan;
%%% Right Shoulder VERTICAL
v.varshR_xv=ones(10,3).*nan;
v.varshR_yv=ones(10,3).*nan;
v.varshR_zv=ones(10,3).*nan;
%%% Right Shoulder CROSS
v.varshR_xc=ones(10,3).*nan;
v.varshR_yc=ones(10,3).*nan;
v.varshR_zc=ones(10,3).*nan;


for subj=1:length(soggetti)-1
    %similmente a prima dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
    if maxsess>10 | maxsess<5
        display('WARNING! Sessions more than 10');
        keyboard
    end
    for g=1:3
        for sess=1:maxsess
            try
                var = getBodyvar(ReachKinectData.ind{subj,sess,g},outlier.ind{subj,sess,g});
            catch
                keyboard
            end
            if g==1
                %%% Left Shoulder HORIZONTAL
                v.varshL_xo(sess,subj)=var.shouldL.andate_x;
                v.varshL_yo(sess,subj)=var.shouldL.andate_y;
                v.varshL_zo(sess,subj)=var.shouldL.andate_z;
                %%% Right Shoulder HORIZONTAL
                v.varshR_xo(sess,subj)=var.shouldR.andate_x;
                v.varshR_yo(sess,subj)=var.shouldR.andate_y;
                v.varshR_zo(sess,subj)=var.shouldR.andate_z;
                %%% Right Perlvis HORIZONTAL
                v.varpelvisR_xo(sess,subj)=var.pelvisR.andate_x;
                v.varpelvisR_yo(sess,subj)=var.pelvisR.andate_y;
                v.varpelvisR_zo(sess,subj)=var.pelvisR.andate_z;
                %%% Left Perlvis HORIZONTAL
                v.varpelvisL_xo(sess,subj)=var.pelvisL.andate_x;
                v.varpelvisL_yo(sess,subj)=var.pelvisL.andate_y;
                v.varpelvisL_zo(sess,subj)=var.pelvisL.andate_z;
            elseif g==2
                %%% Left Shoulder VERTICAL
                v.varshL_xv(sess,subj)=var.shouldL.andate_x;
                v.varshL_yv(sess,subj)=var.shouldL.andate_y;
                v.varshL_zv(sess,subj)=var.shouldL.andate_z;
                %%% Right Shoulder VERTICAL
                v.varshR_xv(sess,subj)=var.shouldR.andate_x;
                v.varshR_yv(sess,subj)=var.shouldR.andate_y;
                v.varshR_zv(sess,subj)=var.shouldR.andate_z;
                %%% Right Pelvis VERTICAL
                v.varpelvisR_xv(sess,subj)=var.pelvisR.andate_x;
                v.varpelvisR_yv(sess,subj)=var.pelvisR.andate_y;
                v.varpelvisR_zv(sess,subj)=var.pelvisR.andate_z;
                %%% Left Pelvis VERTICAL
                v.varpelvisL_xv(sess,subj)=var.pelvisL.andate_x;
                v.varpelvisL_yv(sess,subj)=var.pelvisL.andate_y;
                v.varpelvisL_zv(sess,subj)=var.pelvisL.andate_z;
            else
                %%% Left Shoulder CROSS
                v.varshL_xc(sess,subj)=var.shouldL.andate_x;
                v.varshL_yc(sess,subj)=var.shouldL.andate_y;
                v.varshL_zc(sess,subj)=var.shouldL.andate_z;
                %%% Right Shoulder CROSS
                v.varshR_xc(sess,subj)=var.shouldR.andate_x;
                v.varshR_yc(sess,subj)=var.shouldR.andate_y;
                v.varshR_zc(sess,subj)=var.shouldR.andate_z;
                %%% Right Pelvis CROSS
                v.varpelvisR_xc(sess,subj)=var.pelvisR.andate_x;
                v.varpelvisR_yc(sess,subj)=var.pelvisR.andate_y;
                v.varpelvisR_zc(sess,subj)=var.pelvisR.andate_z;
                %%% Left Pelvis CROSS
                v.varpelvisL_xc(sess,subj)=var.pelvisL.andate_x;
                v.varpelvisL_yc(sess,subj)=var.pelvisL.andate_y;
                v.varpelvisL_zc(sess,subj)=var.pelvisL.andate_z;
            end
        end %sess
        
    end %g
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
