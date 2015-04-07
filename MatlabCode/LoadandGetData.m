function LoadandGetData(datadir)
%Questa funzione parte dai segnali del kinect e ricostruisce caricando la mappa i movimenti del cursore
%ORGANIZZAZIONE VARIABILI NELLA MATRICE DATA
% Data rows:
% 1- Simulink time
% 2- CPU time
% 3-Cursor-X
% 4- Cursor-Y
% 5- Main Menu State
% 6- Reaching State
%%6. Horizontal reaching
%7. Vertical reaching
%8. Cross reaching
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

%nella cartella datadir c'? una cartella per ogni soggetto che contiene
%tutti i dati
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
ng=3;
ReachCompleteData=repmat({NaN},length(soggetti),10,ng);
ReachKinectData=repmat({NaN},length(soggetti),10,ng);
Rec_cursor=repmat({NaN},length(soggetti),10,ng);
Null_cursor=repmat({NaN},length(soggetti),10,ng);

for subj=1:length(soggetti)-1
    %similmente a prima dentro ad ogni cartella del soggetto c'? una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
    if maxsess>10
        display('WARNING! Sessions more than 10');
        keyboard
    end
    for sess=1:maxsess
        
        %load data
        [Mappe{sess,subj},Custom{sess,subj},Data{sess,subj}]=loadData(soggetti,subj,sess,datadir);
        
        
%%        
        %analizzo prima il REACHING ORIZZONTALE = 6
        if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
            oldData = Data{sess,subj}.Data_o;
            A = Mappe{sess,subj}.A_o;
            A_posture = Mappe{sess,subj}.A_oPosture;
            Offset = Custom{sess,subj}.Offset_o;
            Gain = Custom{sess,subj}.Gain_o;
            Rotation = Custom{sess,subj}.Rotation_o;
            KinOffset = Custom{sess,subj}.KinOffset_o;
        else
            oldData = Data{sess,subj}.Data;
            A = Mappe{sess,subj}.A;
            A_posture = Mappe{sess,subj}.APosture;
            Offset = Custom{sess,subj}.Offset;
            Gain = Custom{sess,subj}.Gain;
            Rotation = Custom{sess,subj}.Rotation;
            KinOffset = Custom{sess,subj}.KinOffset;
        end
        [ startIndx_o,stopIndx_o,Datao,g ] = Select_task( oldData,'reachH' );
        
        % % % % % % % % % % % % % % % %         lavoro sul task
        nepochs=length(stopIndx_o);
        for kk = 1:nepochs % per block in each session
            %il primo reaching verticale che fa la cinti probabilmente ? da buttare in realt?
            %nella cartella misteriosamente ci sono 4 file targetseq ma
            %plottando il reachingstate ha fatto 1 orizzontale e 2
            %verticali
            if strcmp(soggetti{subj},'pg') & sess==2 & kk==2
                break
            end
            [out_findmovement]=findmovement(stopIndx_o(kk),startIndx_o(kk),Datao,subj,sess,soggetti,g,kk,A,Rotation,Gain,Offset);
            if length(out_findmovement.reachcompletedata)>1%~isnan(out_findmovement.reachcompletedata)
                
                ReachCompleteData{subj,sess,g}=out_findmovement.reachcompletedata;
                ReachKinectData{subj,sess,g}=out_findmovement.reachkinectdata;
                Null_cursor{subj,sess,g}=out_findmovement.nullcursor;
                Rec_cursor{subj,sess,g}=out_findmovement.reconstructedcursordata;


                
                [out_computereachmetrics]=computereachmetrics(out_findmovement,g);
                % this is to compute reach metrics also for the
                % reconstructed trajectories
%               
                [rec_computereachmetrics]=computereachmetrics(out_findmovement,g,Rec_cursor{subj,sess,g});
                
                [dur,~]=remove_outliers('STD',[out_findmovement.dur]);
                [plrec,~]=remove_outliers('STD',rec_computereachmetrics.PathLength);
                outliers{subj,sess,g} = (isnan(dur)|isnan(plrec));
                
%                 [ vargo_should_l,varshould_l ] = getvar(ReachKinectData{subj,sess,g}(:,13:15)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ vargo_should_r,varshould_r ] = getvar(ReachKinectData{subj,sess,g}(:,25:27)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ vargo_pelvis_l,varpelvis_l ] = getvar(ReachKinectData{subj,sess,g}(:,37:39)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ vargo_pelvis_r,varpelvis_r ] = getvar(ReachKinectData{subj,sess,g}(:,49:51)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
% %                 [ vargo_curs_o,varcurs_o ] = getvar(cursor{subj,sess,g},out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
% %                 [ Nvargo_curs_o,Nvarcurs_o ] = getvar(Null_cursor{subj,sess,g},out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
% %                 
%                 dur(isnan(dur)|isnan(plrec))=nan;
%                 plrec(isnan(dur)|isnan(plrec))=nan;
%                 out_findmovement.rtime(isnan(dur)|isnan(plrec))=nan;
%                 out_findmovement.numpeaks(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.PathLength(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.StLineDist(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.EucError_1s(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.AspectRatio(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.DimJerk(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.LinIndx(isnan(dur)|isnan(plrec))=nan;
%                 
%                 ReachMetrics.MT{subj,sess,g}=[dur];
%                 Reach.MT(:,subj,sess,g)=[nanmean(dur) nanstd(dur)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.NP{subj,sess,g}=[out_findmovement.numpeaks];
%                 Reach.NP(:,subj,sess,g)=[nanmean(out_findmovement.numpeaks) nanstd(out_findmovement.numpeaks)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.RT{subj,sess,g}=[out_findmovement.rtime];
%                 Reach.RT(:,subj,sess,g)=[nanmean(out_findmovement.rtime) nanstd(out_findmovement.rtime)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.StLineDist{subj,sess,g}=out_computereachmetrics.StLineDist;
%                 Reach.MA(:,subj,sess,g)=[nanmean(out_computereachmetrics.StLineDist) nanstd(out_computereachmetrics.StLineDist)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.EucError_1s{subj,sess,g}=out_computereachmetrics.EucError_1s;
%                 Reach.EndPointErr(:,subj,sess,g)=[nanmean(out_computereachmetrics.EucError_1s) nanstd(out_computereachmetrics.EucError_1s)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.PathLength{subj,sess,g}=out_computereachmetrics.PathLength;
%                 Reach.PL(:,subj,sess,g)=[nanmean(out_computereachmetrics.PathLength) nanstd(out_computereachmetrics.PathLength)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.AspectRatio{subj,sess,g}=out_computereachmetrics.AspectRatio;
%                 Reach.AR(:,subj,sess,g)=[nanmean(out_computereachmetrics.AspectRatio) nanstd(out_computereachmetrics.AspectRatio)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.DimJerk{subj,sess,g}=out_computereachmetrics.DimJerk;
%                 Reach.DJ(:,subj,sess,g)=[nanmean(out_computereachmetrics.DimJerk) nanstd(out_computereachmetrics.DimJerk)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.LinIndx{subj,sess,g}=out_computereachmetrics.LinIndx;
%                 Reach.LI(:,subj,sess,g)=[nanmean(out_computereachmetrics.LinIndx) nanstd(out_computereachmetrics.LinIndx)./sqrt(length(find(~isnan(dur))))];
%                 
%                 %               reconstructed
%                 numpeaksrec = numpeaksvel(rec);
%                 numpeaksrec(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.StLineDist(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.EucError_1s(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.AspectRatio(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.DimJerk(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.LinIndx(isnan(dur)|isnan(plrec))=nan;
%                 
%                 RecMetrics.MT{subj,sess,g}=[dur];
%                 Rec.MT(:,subj,sess,g)=[nanmean(dur) nanstd(dur)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.RT{subj,sess,g}=[out_findmovement.rtime];
%                 Rec.RT(:,subj,sess,g)=[nanmean(out_findmovement.rtime) nanstd(out_findmovement.rtime)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.StLineDist{subj,sess,g}=rec_computereachmetrics.StLineDist;
%                 Rec.MA(:,subj,sess,g)=[nanmean(rec_computereachmetrics.StLineDist) nanstd(rec_computereachmetrics.StLineDist)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.EucError_1s{subj,sess,g}=rec_computereachmetrics.EucError_1s;
%                 Rec.EndPointErr(:,subj,sess,g)=[nanmean(rec_computereachmetrics.EucError_1s) nanstd(rec_computereachmetrics.EucError_1s)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.PathLength{subj,sess,g}=plrec;
%                 Rec.PL(:,subj,sess,g)=[nanmean(plrec) nanstd(plrec)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.AspectRatio{subj,sess,g}=rec_computereachmetrics.AspectRatio;
%                 Rec.AR(:,subj,sess,g)=[nanmean(rec_computereachmetrics.AspectRatio) nanstd(rec_computereachmetrics.AspectRatio)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.DimJerk{subj,sess,g}=rec_computereachmetrics.DimJerk;
%                 Rec.DJ(:,subj,sess,g)=[nanmean(rec_computereachmetrics.DimJerk) nanstd(rec_computereachmetrics.DimJerk)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.LinIndx{subj,sess,g}=rec_computereachmetrics.LinIndx;
%                 Rec.LI(:,subj,sess,g)=[nanmean(rec_computereachmetrics.LinIndx) nanstd(rec_computereachmetrics.LinIndx)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.NP{subj,sess,g}=numpeaksrec;
%                 Rec.NP(:,subj,sess,g)=[nanmean(numpeaksrec) nanstd(numpeaksrec)./sqrt(length(find(~isnan(dur))))];
%                 %%%%%%%%%%%%%%%%% End metrics rec traj %%%%%%%%%%%%%%%
%                 
%                 
%                 
%                 %nulletask cursor variability
%                 Tvarcur.andate(sess,subj,g) = sum(vargo_curs_o)/(sum(vargo_curs_o)+sum(Nvargo_curs_o));
%                 Tvarcur.allmov(sess,subj,g) = sum(varcurs_o)/(sum(varcurs_o)+sum(Nvarcurs_o));
%                 
%                 Nvarcur.andate(sess,subj,g) = sum(Nvargo_curs_o)/(sum(vargo_curs_o)+sum(Nvargo_curs_o));
%                 Nvarcur.allmov(sess,subj,g) = sum(Nvarcurs_o)/(sum(varcurs_o)+sum(Nvarcurs_o));
%                 
%                 % shoulders variability
%                 varshouldL.andate_x(sess,subj,g) = vargo_should_l(1,1);
%                 varshouldL.andate_y(sess,subj,g) = vargo_should_l(2,1);
%                 varshouldL.andate_z(sess,subj,g) = vargo_should_l(3,1);
%                 varshouldL.allmov_x(sess,subj,g) = varshould_l(1,1);
%                 varshouldL.allmov_y(sess,subj,g) = varshould_l(2,1);
%                 varshouldL.allmov_z(sess,subj,g) = varshould_l(3,1);
%                 varshouldR.andate_x(sess,subj,g) = vargo_should_r(1,1);
%                 varshouldR.andate_y(sess,subj,g) = vargo_should_r(2,1);
%                 varshouldR.andate_z(sess,subj,g) = vargo_should_r(3,1);
%                 varshouldR.allmov_x(sess,subj,g) = varshould_r(1,1);
%                 varshouldR.allmov_y(sess,subj,g) = varshould_r(2,1);
%                 varshouldR.allmov_z(sess,subj,g) = varshould_r(3,1);
%                 % pelvis variability
%                 varpelvisL.andate_x(sess,subj,g) = vargo_pelvis_l(1,1);
%                 varpelvisL.andate_y(sess,subj,g) = vargo_pelvis_l(2,1);
%                 varpelvisL.andate_z(sess,subj,g) = vargo_pelvis_l(3,1);
%                 varpelvisL.allmov_x(sess,subj,g) = varpelvis_l(1,1);
%                 varpelvisL.allmov_y(sess,subj,g) = varpelvis_l(2,1);
%                 varpelvisL.allmov_z(sess,subj,g) = varpelvis_l(3,1);
%                 varpelvisR.andate_x(sess,subj,g) = vargo_pelvis_r(1,1);
%                 varpelvisR.andate_y(sess,subj,g) = vargo_pelvis_r(2,1);
%                 varpelvisR.andate_z(sess,subj,g) = vargo_pelvis_r(3,1);
%                 varpelvisR.allmov_x(sess,subj,g) = varpelvis_r(1,1);
%                 varpelvisR.allmov_y(sess,subj,g) = varpelvis_r(2,1);
%                 varpelvisR.allmov_z(sess,subj,g) = varpelvis_r(3,1);
                
            else
                
%                 ReachMetrics.MT{subj,sess,g}=nan;
%                 Reach.MT(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.NP{subj,sess,g}=nan;
%                 Reach.NP(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.RT{subj,sess,g}=nan;
%                 Reach.RT(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.StLineDist{subj,sess,g}=nan;
%                 Reach.MA(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.EucError_1s{subj,sess,g}=nan;
%                 Reach.EndPointErr(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.PathLength{subj,sess,g}=nan;
%                 Reach.PL(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.AspectRatio{subj,sess,g}=nan;
%                 Reach.AR(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.DimJerk{subj,sess,g}=nan;
%                 Reach.DJ(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.LinIndx{subj,sess,g}=nan;
%                 Reach.LI(:,subj,sess,g)=[nan nan];
%                 
%                 
%                 RecMetrics.MT{subj,sess,g}=nan;
%                 Rec.MT(:,subj,sess,g)=[nan nan];
%                 RecMetrics.RT{subj,sess,g}=nan;
%                 Rec.RT(:,subj,sess,g)=[nan nan];
%                 RecMetrics.StLineDist{subj,sess,g}=nan;
%                 Rec.MA(:,subj,sess,g)=[nan nan];
%                 RecMetrics.EucError_1s{subj,sess,g}=nan;
%                 Rec.EndPointErr(:,subj,sess,g)=[nan nan];
%                 RecMetrics.PathLength{subj,sess,g}=nan;
%                 Rec.PL(:,subj,sess,g)=[nan nan];
%                 RecMetrics.AspectRatio{subj,sess,g}=nan;
%                 Rec.AR(:,subj,sess,g)=[nan nan];
%                 RecMetrics.DimJerk{subj,sess,g}=nan;
%                 Rec.DJ(:,subj,sess,g)=[nan nan];
%                 RecMetrics.LinIndx{subj,sess,g}=nan;
%                 Rec.LI(:,subj,sess,g)=[nan nan];
%                 RecMetrics.NP{subj,sess,g}=nan;
%                 Rec.NP(:,subj,sess,g)=[nan nan];
%                 
%                 varcur.andate_x(sess,subj,g) = nan;
%                 varcur.andate_y(sess,subj,g) = nan;
%                 varcur.allmov_x(sess,subj,g) = nan;
%                 varcur.allmov_y(sess,subj,g) = nan;
%                 
%                 Nvarcur.andate_x(sess,subj,g) = nan;
%                 Nvarcur.andate_y(sess,subj,g) = nan;
%                 Nvarcur.allmov_x(sess,subj,g) = nan;
%                 Nvarcur.allmov_y(sess,subj,g) = nan;
%                 
%                 % shoulders variability
%                 varshouldL.andate_x(sess,subj,g) = nan;
%                 varshouldL.andate_y(sess,subj,g) = nan;
%                 varshouldL.andate_z(sess,subj,g) = nan;
%                 varshouldL.allmov_x(sess,subj,g) = nan;
%                 varshouldL.allmov_y(sess,subj,g) = nan;
%                 varshouldL.allmov_z(sess,subj,g) = nan;
%                 varshouldR.andate_x(sess,subj,g) = nan;
%                 varshouldR.andate_y(sess,subj,g) = nan;
%                 varshouldR.andate_z(sess,subj,g) = nan;
%                 varshouldR.allmov_x(sess,subj,g) = nan;
%                 varshouldR.allmov_y(sess,subj,g) = nan;
%                 varshouldR.allmov_z(sess,subj,g) = nan;
%                 % pelvis variability
%                 varpelvisL.andate_x(sess,subj,g) = nan;
%                 varpelvisL.andate_y(sess,subj,g) = nan;
%                 varpelvisL.andate_z(sess,subj,g) = nan;
%                 varpelvisL.allmov_x(sess,subj,g) = nan;
%                 varpelvisL.allmov_y(sess,subj,g) = nan;
%                 varpelvisL.allmov_z(sess,subj,g) = nan;
%                 varpelvisR.andate_x(sess,subj,g) = nan;
%                 varpelvisR.andate_y(sess,subj,g) = nan;
%                 varpelvisR.andate_z(sess,subj,g) = nan;
%                 varpelvisR.allmov_x(sess,subj,g) = nan;
%                 varpelvisR.allmov_y(sess,subj,g) = nan;
%                 varpelvisR.allmov_z(sess,subj,g) = nan;
            end
            clear out_findmovement rec
        end
        
%%        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        %analizzo prima il REACHING VERTICALE = 7
        if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
            oldData = Data{sess,subj}.Data_v;
            A = Mappe{sess,subj}.A_v;
            A_posture = Mappe{sess,subj}.A_vPosture;
            Offset = Custom{sess,subj}.Offset_v;
            Gain = Custom{sess,subj}.Gain_v;
            Rotation = Custom{sess,subj}.Rotation_v;
            KinOffset = Custom{sess,subj}.KinOffset_v;
        else
            oldData = Data{sess,subj}.Data;
            A = Mappe{sess,subj}.A;
            A_posture = Mappe{sess,subj}.APosture;
            Offset = Custom{sess,subj}.Offset;
            Gain = Custom{sess,subj}.Gain;
            Rotation = Custom{sess,subj}.Rotation;
            KinOffset = Custom{sess,subj}.KinOffset;
        end
        [ startIndx_v,stopIndx_v,Datav,g ] = Select_task( oldData,'reachV' );
        % % % % % % % % % % % % % % % % % %         fine LOAD verticale
        
        % % % % % % % % % % % % % % % %         lavoro sul task
        nepochs=length(stopIndx_v);
        for kk = 1:nepochs % per block in each session
            %il primo reaching verticale che fa la cinti probabilmente ? da buttare in realt?
            %nella cartella misteriosamente ci sono 4 file targetseq ma
            %plottando il reachingstate ha fatto 1 orizzontale e 2
            %verticali
            if strcmp(soggetti{subj},'pg') & sess==2 & (kk==2 | kk==3)
                break
            end
            if strcmp(soggetti{subj},'gr') & sess==3 & kk==1
                continue
                %il reach verticale viene eseguito due volte ma la prima
                %volta fa solo 12 movimenti invece la seconda li fa tutti
            end
            [out_findmovement]=findmovement(stopIndx_v(kk),startIndx_v(kk),Datav,subj,sess,soggetti,g,kk,A,Rotation,Gain,Offset);
            
            if length(out_findmovement.reachcompletedata)>1%~isnan(out_findmovement.reachcompletedata)

                [out_computereachmetrics]=computereachmetrics(out_findmovement,g);
                
                ReachCompleteData{subj,sess,g}=out_findmovement.reachcompletedata;
                ReachKinectData{subj,sess,g}=out_findmovement.reachkinectdata;
                Null_cursor{subj,sess,g}=out_findmovement.nullcursor;
                Rec_cursor{subj,sess,g}=out_findmovement.reconstructedcursordata;
                % this is to compute reach metrics also for the
                % reconstructed trajectories
                
                [rec_computereachmetrics]=computereachmetrics(out_findmovement,g,Rec_cursor{subj,sess,g});
                
                [dur,~]=remove_outliers('STD',[out_findmovement.dur]);
                [plrec,~]=remove_outliers('STD',rec_computereachmetrics.PathLength);
                outliers{subj,sess,g} = (isnan(dur)|isnan(plrec));
                
%                 [ vargo_should_l,varshould_l ] = getvar(ReachKinectData{subj,sess,g}(:,13:15)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ vargo_should_r,varshould_r ] = getvar(ReachKinectData{subj,sess,g}(:,25:27)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ vargo_pelvis_l,varpelvis_l ] = getvar(ReachKinectData{subj,sess,g}(:,37:39)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ vargo_pelvis_r,varpelvis_r ] = getvar(ReachKinectData{subj,sess,g}(:,49:51)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ vargo_curs_v,varcurs_v ] = getvar(cursor{subj,sess,g},out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 [ Nvargo_curs_v,Nvarcurs_v ] = getvar(Null_cursor{subj,sess,g},out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(plrec)));
%                 
%                 dur(isnan(dur)|isnan(plrec))=nan;
%                 plrec(isnan(dur)|isnan(plrec))=nan;
%                 out_findmovement.rtime(isnan(dur)|isnan(plrec))=nan;
%                 out_findmovement.numpeaks(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.PathLength(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.StLineDist(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.EucError_1s(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.AspectRatio(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.DimJerk(isnan(dur)|isnan(plrec))=nan;
%                 out_computereachmetrics.LinIndx(isnan(dur)|isnan(plrec))=nan;
%                 
%                 ReachMetrics.MT{subj,sess,g}=[dur];
%                 Reach.MT(:,subj,sess,g)=[nanmean(dur) nanstd(dur)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.NP{subj,sess,g}=[out_findmovement.numpeaks];
%                 Reach.NP(:,subj,sess,g)=[nanmean(out_findmovement.numpeaks) nanstd(out_findmovement.numpeaks)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.RT{subj,sess,g}=[out_findmovement.rtime];
%                 Reach.RT(:,subj,sess,g)=[nanmean(out_findmovement.rtime) nanstd(out_findmovement.rtime)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.StLineDist{subj,sess,g}=out_computereachmetrics.StLineDist;
%                 Reach.MA(:,subj,sess,g)=[nanmean(out_computereachmetrics.StLineDist) nanstd(out_computereachmetrics.StLineDist)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.EucError_1s{subj,sess,g}=out_computereachmetrics.EucError_1s;
%                 Reach.EndPointErr(:,subj,sess,g)=[nanmean(out_computereachmetrics.EucError_1s) nanstd(out_computereachmetrics.EucError_1s)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.PathLength{subj,sess,g}=out_computereachmetrics.PathLength;
%                 Reach.PL(:,subj,sess,g)=[nanmean(out_computereachmetrics.PathLength) nanstd(out_computereachmetrics.PathLength)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.AspectRatio{subj,sess,g}=out_computereachmetrics.AspectRatio;
%                 Reach.AR(:,subj,sess,g)=[nanmean(out_computereachmetrics.AspectRatio) nanstd(out_computereachmetrics.AspectRatio)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.DimJerk{subj,sess,g}=out_computereachmetrics.DimJerk;
%                 Reach.DJ(:,subj,sess,g)=[nanmean(out_computereachmetrics.DimJerk) nanstd(out_computereachmetrics.DimJerk)./sqrt(length(find(~isnan(dur))))];
%                 ReachMetrics.LinIndx{subj,sess,g}=out_computereachmetrics.LinIndx;
%                 Reach.LI(:,subj,sess,g)=[nanmean(out_computereachmetrics.LinIndx) nanstd(out_computereachmetrics.LinIndx)./sqrt(length(find(~isnan(dur))))];
%                 
%                 %               reconstructed
%                 numpeaksrec = numpeaksvel(rec);
%                 numpeaksrec(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.StLineDist(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.EucError_1s(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.AspectRatio(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.DimJerk(isnan(dur)|isnan(plrec))=nan;
%                 rec_computereachmetrics.LinIndx(isnan(dur)|isnan(plrec))=nan;
%                 
%                 RecMetrics.MT{subj,sess,g}=[dur];
%                 Rec.MT(:,subj,sess,g)=[nanmean(dur) nanstd(dur)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.RT{subj,sess,g}=[out_findmovement.rtime];
%                 Rec.RT(:,subj,sess,g)=[nanmean(out_findmovement.rtime) nanstd(out_findmovement.rtime)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.StLineDist{subj,sess,g}=rec_computereachmetrics.StLineDist;
%                 Rec.MA(:,subj,sess,g)=[nanmean(rec_computereachmetrics.StLineDist) nanstd(rec_computereachmetrics.StLineDist)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.EucError_1s{subj,sess,g}=rec_computereachmetrics.EucError_1s;
%                 Rec.EndPointErr(:,subj,sess,g)=[nanmean(rec_computereachmetrics.EucError_1s) nanstd(rec_computereachmetrics.EucError_1s)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.PathLength{subj,sess,g}=plrec;
%                 Rec.PL(:,subj,sess,g)=[nanmean(plrec) nanstd(plrec)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.AspectRatio{subj,sess,g}=rec_computereachmetrics.AspectRatio;
%                 Rec.AR(:,subj,sess,g)=[nanmean(rec_computereachmetrics.AspectRatio) nanstd(rec_computereachmetrics.AspectRatio)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.DimJerk{subj,sess,g}=rec_computereachmetrics.DimJerk;
%                 Rec.DJ(:,subj,sess,g)=[nanmean(rec_computereachmetrics.DimJerk) nanstd(rec_computereachmetrics.DimJerk)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.LinIndx{subj,sess,g}=rec_computereachmetrics.LinIndx;
%                 Rec.LI(:,subj,sess,g)=[nanmean(rec_computereachmetrics.LinIndx) nanstd(rec_computereachmetrics.LinIndx)./sqrt(length(find(~isnan(dur))))];
%                 RecMetrics.NP{subj,sess,g}=numpeaksrec;
%                 Rec.NP(:,subj,sess,g)=[nanmean(numpeaksrec) nanstd(numpeaksrec)./sqrt(length(find(~isnan(dur))))];
%                 %%%%%%%%%%%%%%%%% End metrics rec traj %%%%%%%%%%%%%%%
%                 
%                 % cursor variability
%                 varcur.andate_x(sess,subj,g) = vargo_curs_v(1,1)/Gain;
%                 varcur.andate_y(sess,subj,g) = vargo_curs_v(2,1)/Gain;
%                 varcur.allmov_x(sess,subj,g) = varcurs_v(1,1)/Gain;
%                 varcur.allmov_y(sess,subj,g) = varcurs_v(2,1)/Gain;
%                 
%                 Tvarcur.andate(sess,subj,g) = sum(vargo_curs_v)/(sum(varcurs_v)+sum(Nvarcurs_v));;
%                 Tvarcur.allmov(sess,subj,g) = sum(varcurs_v)/(sum(varcurs_v)+sum(Nvarcurs_v));;
%                                
%                 Nvarcur.andate(sess,subj,g) = sum(Nvargo_curs_v)/(sum(varcurs_v)+sum(Nvarcurs_v));;
%                 Nvarcur.allmov(sess,subj,g) = sum(Nvarcurs_v)/(sum(varcurs_v)+sum(Nvarcurs_v));;
%                 
%                 % shoulders variability
%                 varshouldL.andate_x(sess,subj,g) = vargo_should_l(1,1);
%                 varshouldL.andate_y(sess,subj,g) = vargo_should_l(2,1);
%                 varshouldL.andate_z(sess,subj,g) = vargo_should_l(3,1);
%                 varshouldL.allmov_x(sess,subj,g) = varshould_l(1,1);
%                 varshouldL.allmov_y(sess,subj,g) = varshould_l(2,1);
%                 varshouldL.allmov_z(sess,subj,g) = varshould_l(3,1);
%                 varshouldR.andate_x(sess,subj,g) = vargo_should_r(1,1);
%                 varshouldR.andate_y(sess,subj,g) = vargo_should_r(2,1);
%                 varshouldR.andate_z(sess,subj,g) = vargo_should_r(3,1);
%                 varshouldR.allmov_x(sess,subj,g) = varshould_r(1,1);
%                 varshouldR.allmov_y(sess,subj,g) = varshould_r(2,1);
%                 varshouldR.allmov_z(sess,subj,g) = varshould_r(3,1);
%                 % pelvis variability
%                 varpelvisL.andate_x(sess,subj,g) = vargo_pelvis_l(1,1);
%                 varpelvisL.andate_y(sess,subj,g) = vargo_pelvis_l(2,1);
%                 varpelvisL.andate_z(sess,subj,g) = vargo_pelvis_l(3,1);
%                 varpelvisL.allmov_x(sess,subj,g) = varpelvis_l(1,1);
%                 varpelvisL.allmov_y(sess,subj,g) = varpelvis_l(2,1);
%                 varpelvisL.allmov_z(sess,subj,g) = varpelvis_l(3,1);
%                 varpelvisR.andate_x(sess,subj,g) = vargo_pelvis_r(1,1);
%                 varpelvisR.andate_y(sess,subj,g) = vargo_pelvis_r(2,1);
%                 varpelvisR.andate_z(sess,subj,g) = vargo_pelvis_r(3,1);
%                 varpelvisR.allmov_x(sess,subj,g) = varpelvis_r(1,1);
%                 varpelvisR.allmov_y(sess,subj,g) = varpelvis_r(2,1);
%                 varpelvisR.allmov_z(sess,subj,g) = varpelvis_r(3,1);
                
            else
                
%                 ReachMetrics.MT{subj,sess,g}=nan;
%                 Reach.MT(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.NP{subj,sess,g}=nan;
%                 Reach.NP(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.RT{subj,sess,g}=nan;
%                 Reach.RT(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.StLineDist{subj,sess,g}=nan;
%                 Reach.MA(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.EucError_1s{subj,sess,g}=nan;
%                 Reach.EndPointErr(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.PathLength{subj,sess,g}=nan;
%                 Reach.PL(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.AspectRatio{subj,sess,g}=nan;
%                 Reach.AR(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.DimJerk{subj,sess,g}=nan;
%                 Reach.DJ(:,subj,sess,g)=[nan nan];
%                 ReachMetrics.LinIndx{subj,sess,g}=nan;
%                 Reach.LI(:,subj,sess,g)=[nan nan];
%                 
%                 
%                 RecMetrics.MT{subj,sess,g}=nan;
%                 Rec.MT(:,subj,sess,g)=[nan nan];
%                 RecMetrics.RT{subj,sess,g}=nan;
%                 Rec.RT(:,subj,sess,g)=[nan nan];
%                 RecMetrics.StLineDist{subj,sess,g}=nan;
%                 Rec.MA(:,subj,sess,g)=[nan nan];
%                 RecMetrics.EucError_1s{subj,sess,g}=nan;
%                 Rec.EndPointErr(:,subj,sess,g)=[nan nan];
%                 RecMetrics.PathLength{subj,sess,g}=nan;
%                 Rec.PL(:,subj,sess,g)=[nan nan];
%                 RecMetrics.AspectRatio{subj,sess,g}=nan;
%                 Rec.AR(:,subj,sess,g)=[nan nan];
%                 RecMetrics.DimJerk{subj,sess,g}=nan;
%                 Rec.DJ(:,subj,sess,g)=[nan nan];
%                 RecMetrics.LinIndx{subj,sess,g}=nan;
%                 Rec.LI(:,subj,sess,g)=[nan nan];
%                 RecMetrics.NP{subj,sess,g}=nan;
%                 Rec.NP(:,subj,sess,g)=[nan nan];
%                 
%                 varcur.andate_x(sess,subj,g) = nan;
%                 varcur.andate_y(sess,subj,g) = nan;
%                 varcur.allmov_x(sess,subj,g) = nan;
%                 varcur.allmov_y(sess,subj,g) = nan;
%                 
%                 Nvarcur.andate_x(sess,subj,g) = nan;
%                 Nvarcur.andate_y(sess,subj,g) = nan;
%                 Nvarcur.allmov_x(sess,subj,g) = nan;
%                 Nvarcur.allmov_y(sess,subj,g) = nan;
%                 % shoulders variability
%                 varshouldL.andate_x(sess,subj,g) = nan;
%                 varshouldL.andate_y(sess,subj,g) = nan;
%                 varshouldL.andate_z(sess,subj,g) = nan;
%                 varshouldL.allmov_x(sess,subj,g) = nan;
%                 varshouldL.allmov_y(sess,subj,g) = nan;
%                 varshouldL.allmov_z(sess,subj,g) = nan;
%                 varshouldR.andate_x(sess,subj,g) = nan;
%                 varshouldR.andate_y(sess,subj,g) = nan;
%                 varshouldR.andate_z(sess,subj,g) = nan;
%                 varshouldR.allmov_x(sess,subj,g) = nan;
%                 varshouldR.allmov_y(sess,subj,g) = nan;
%                 varshouldR.allmov_z(sess,subj,g) = nan;
%                 % pelvis variability
%                 varpelvisL.andate_x(sess,subj,g) = nan;
%                 varpelvisL.andate_y(sess,subj,g) = nan;
%                 varpelvisL.andate_z(sess,subj,g) = nan;
%                 varpelvisL.allmov_x(sess,subj,g) = nan;
%                 varpelvisL.allmov_y(sess,subj,g) = nan;
%                 varpelvisL.allmov_z(sess,subj,g) = nan;
%                 varpelvisR.andate_x(sess,subj,g) = nan;
%                 varpelvisR.andate_y(sess,subj,g) = nan;
%                 varpelvisR.andate_z(sess,subj,g) = nan;
%                 varpelvisR.allmov_x(sess,subj,g) = nan;
%                 varpelvisR.allmov_y(sess,subj,g) = nan;
%                 varpelvisR.allmov_z(sess,subj,g) = nan;
            end
            
            clear out_findmovement rec
        end
        
        
 %%       % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
        %analizzo prima il CROSS REACHING  = 8
        
        [ startIndx_c,stopIndx_c,Datac,g ] = Select_task( oldData,'reachC' );
        if (strcmp(soggetti{subj},'gg') & sess==7 )
            Gain=1.2;
        end
        if ~isempty(startIndx_c)
            
            
            % % % % % % % % % % % % % % % %         lavoro sul task
            nepochs=length(stopIndx_c);
            for kk = 1:nepochs % per block in each session
                %il primo reaching verticale che fa la cinti probabilmente ? da buttare in realt?
                %nella cartella misteriosamente ci sono 4 file targetseq ma
                %plottando il reachingstate ha fatto 1 orizzontale e 2
                %verticali
                if (strcmp(soggetti{subj},'pg') & sess==8 & kk==1) | (strcmp(soggetti{subj},'gg') & sess==4 & (kk==1))
                    break
                end
                [out_findmovement]=findmovement(stopIndx_c(kk),startIndx_c(kk),Datac,subj,sess,soggetti,g,kk,A,Rotation,Gain,Offset);
                
                if length(out_findmovement.reachcompletedata)>1%~isnan(out_findmovement.reachcompletedata)
                    
                    
                                    
                    ReachCompleteData{subj,sess,g}=out_findmovement.reachcompletedata;
                    ReachKinectData{subj,sess,g}=out_findmovement.reachkinectdata;
                    Null_cursor{subj,sess,g}=out_findmovement.nullcursor;
                    Rec_cursor{subj,sess,g}=out_findmovement.reconstructedcursordata;
                    [out_computereachmetrics]=computereachmetrics(out_findmovement,g);
                    [rec_computereachmetrics]=computereachmetrics(out_findmovement,g,Rec_cursor{subj,sess,g});

                    [dur,~]=remove_outliers('STD',[out_findmovement.dur]);
                    [pl,~]=remove_outliers('STD',out_computereachmetrics.PathLength);
                    outliers{subj,sess,g} = (isnan(dur)|isnan(pl));
                    
%                     [ vargo_should_l,varshould_l ] = getvar(ReachKinectData{subj,sess,g}(:,13:15)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(pl)));
%                     [ vargo_should_r,varshould_r ] = getvar(ReachKinectData{subj,sess,g}(:,25:27)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(pl)));
%                     [ vargo_pelvis_l,varpelvis_l ] = getvar(ReachKinectData{subj,sess,g}(:,37:39)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(pl)));
%                     [ vargo_pelvis_r,varpelvis_r ] = getvar(ReachKinectData{subj,sess,g}(:,49:51)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(pl)));
%                     [ vargo_curs_c,varcurs_c ] = getvar(ReachCompleteData{subj,sess,g}(:,2:3)',out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(pl)));
%                     try
%                     [ Nvargo_curs_c,Nvarcurs_c ] = getvar(Null_cursor{subj,sess,g},out_findmovement.start, out_findmovement.stop,(isnan(dur)|isnan(pl)));
%                     catch
%                         keyboard
%                     end
%                     dur(isnan(dur)|isnan(pl))=nan;
%                     pl(isnan(dur)|isnan(pl))=nan;
%                     out_findmovement.rtime(isnan(dur)|isnan(pl))=nan;
%                     out_findmovement.numpeaks(isnan(dur)|isnan(pl))=nan;
%                     out_computereachmetrics.StLineDist(isnan(dur)|isnan(pl))=nan;
%                     out_computereachmetrics.EucError_1s(isnan(dur)|isnan(pl))=nan;
%                     out_computereachmetrics.AspectRatio(isnan(dur)|isnan(pl))=nan;
%                     out_computereachmetrics.DimJerk(isnan(dur)|isnan(pl))=nan;
%                     out_computereachmetrics.LinIndx(isnan(dur)|isnan(pl))=nan;
%                     
%                     ReachMetrics.MT{subj,sess,g}=[dur];
%                     Reach.MT(:,subj,sess,g)=[nanmean(dur) nanstd(dur)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.NP{subj,sess,g}=[out_findmovement.numpeaks];
%                     Reach.NP(:,subj,sess,g)=[nanmean(out_findmovement.numpeaks) nanstd(out_findmovement.numpeaks)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.RT{subj,sess,g}=[out_findmovement.rtime];
%                     Reach.RT(:,subj,sess,g)=[nanmean(out_findmovement.rtime) nanstd(out_findmovement.rtime)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.StLineDist{subj,sess,g}=out_computereachmetrics.StLineDist;
%                     Reach.MA(:,subj,sess,g)=[nanmean(out_computereachmetrics.StLineDist) nanstd(out_computereachmetrics.StLineDist)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.EucError_1s{subj,sess,g}=out_computereachmetrics.EucError_1s;
%                     Reach.EndPointErr(:,subj,sess,g)=[nanmean(out_computereachmetrics.EucError_1s) nanstd(out_computereachmetrics.EucError_1s)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.PathLength{subj,sess,g}=pl;
%                     Reach.PL(:,subj,sess,g)=[nanmean(pl) nanstd(pl)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.AspectRatio{subj,sess,g}=out_computereachmetrics.AspectRatio;
%                     Reach.AR(:,subj,sess,g)=[nanmean(out_computereachmetrics.AspectRatio) nanstd(out_computereachmetrics.AspectRatio)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.DimJerk{subj,sess,g}=out_computereachmetrics.DimJerk;
%                     Reach.DJ(:,subj,sess,g)=[nanmean(out_computereachmetrics.DimJerk) nanstd(out_computereachmetrics.DimJerk)./sqrt(length(find(~isnan(dur))))];
%                     ReachMetrics.LinIndx{subj,sess,g}=out_computereachmetrics.LinIndx;
%                     Reach.LI(:,subj,sess,g)=[nanmean(out_computereachmetrics.LinIndx) nanstd(out_computereachmetrics.LinIndx)./sqrt(length(find(~isnan(dur))))];
%                     
%                     
%                     
%                     % cursor variability
%                     varcur.andate_x(sess,subj,g) = vargo_curs_c(1,1)/Gain;
%                     varcur.andate_y(sess,subj,g) = vargo_curs_c(2,1)/Gain;
%                     varcur.allmov_x(sess,subj,g) = varcurs_c(1,1)/Gain;
%                     varcur.allmov_y(sess,subj,g) = varcurs_c(2,1)/Gain;
%                     
%                     % null cursor variability
%                     Tvarcur.andate(sess,subj,g) = sum(vargo_curs_c)/(sum(varcurs_c)+sum(Nvarcurs_c));
%                     Tvarcur.allmov(sess,subj,g) = sum(varcurs_c)/(sum(varcurs_c)+sum(Nvarcurs_c));
%                     
%                     Nvarcur.andate(sess,subj,g) = sum(Nvargo_curs_c)/(sum(varcurs_c)+sum(Nvarcurs_c));
%                    Nvarcur.allmov(sess,subj,g) = sum(Nvarcurs_c)/(sum(varcurs_c)+sum(Nvarcurs_c));
%                     % shoulders variability
%                     varshouldL.andate_x(sess,subj,g) = vargo_should_l(1,1);
%                     varshouldL.andate_y(sess,subj,g) = vargo_should_l(2,1);
%                     varshouldL.andate_z(sess,subj,g) = vargo_should_l(3,1);
%                     varshouldL.allmov_x(sess,subj,g) = varshould_l(1,1);
%                     varshouldL.allmov_y(sess,subj,g) = varshould_l(2,1);
%                     varshouldL.allmov_z(sess,subj,g) = varshould_l(3,1);
%                     varshouldR.andate_x(sess,subj,g) = vargo_should_r(1,1);
%                     varshouldR.andate_y(sess,subj,g) = vargo_should_r(2,1);
%                     varshouldR.andate_z(sess,subj,g) = vargo_should_r(3,1);
%                     varshouldR.allmov_x(sess,subj,g) = varshould_r(1,1);
%                     varshouldR.allmov_y(sess,subj,g) = varshould_r(2,1);
%                     varshouldR.allmov_z(sess,subj,g) = varshould_r(3,1);
%                     % pelvis variability
%                     varpelvisL.andate_x(sess,subj,g) = vargo_pelvis_l(1,1);
%                     varpelvisL.andate_y(sess,subj,g) = vargo_pelvis_l(2,1);
%                     varpelvisL.andate_z(sess,subj,g) = vargo_pelvis_l(3,1);
%                     varpelvisL.allmov_x(sess,subj,g) = varpelvis_l(1,1);
%                     varpelvisL.allmov_y(sess,subj,g) = varpelvis_l(2,1);
%                     varpelvisL.allmov_z(sess,subj,g) = varpelvis_l(3,1);
%                     varpelvisR.andate_x(sess,subj,g) = vargo_pelvis_r(1,1);
%                     varpelvisR.andate_y(sess,subj,g) = vargo_pelvis_r(2,1);
%                     varpelvisR.andate_z(sess,subj,g) = vargo_pelvis_r(3,1);
%                     varpelvisR.allmov_x(sess,subj,g) = varpelvis_r(1,1);
%                     varpelvisR.allmov_y(sess,subj,g) = varpelvis_r(2,1);
%                     varpelvisR.allmov_z(sess,subj,g) = varpelvis_r(3,1);
                    
                else
                    
%                     ReachMetrics.MT{subj,sess,g}=nan;
%                     Reach.MT(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.NP{subj,sess,g}=nan;
%                     Reach.NP(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.RT{subj,sess,g}=nan;
%                     Reach.RT(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.StLineDist{subj,sess,g}=nan;
%                     Reach.MA(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.EucError_1s{subj,sess,g}=nan;
%                     Reach.EndPointErr(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.PathLength{subj,sess,g}=nan;
%                     Reach.PL(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.AspectRatio{subj,sess,g}=nan;
%                     Reach.AR(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.DimJerk{subj,sess,g}=nan;
%                     Reach.DJ(:,subj,sess,g)=[nan nan];
%                     ReachMetrics.LinIndx{subj,sess,g}=nan;
%                     Reach.LI(:,subj,sess,g)=[nan nan];
%                     
%                     
%                     RecMetrics.MT{subj,sess,g}=nan;
%                     Rec.MT(:,subj,sess,g)=[nan nan];
%                     RecMetrics.RT{subj,sess,g}=nan;
%                     Rec.RT(:,subj,sess,g)=[nan nan];
%                     RecMetrics.StLineDist{subj,sess,g}=nan;
%                     Rec.MA(:,subj,sess,g)=[nan nan];
%                     RecMetrics.EucError_1s{subj,sess,g}=nan;
%                     Rec.EndPointErr(:,subj,sess,g)=[nan nan];
%                     RecMetrics.PathLength{subj,sess,g}=nan;
%                     Rec.PL(:,subj,sess,g)=[nan nan];
%                     RecMetrics.AspectRatio{subj,sess,g}=nan;
%                     Rec.AR(:,subj,sess,g)=[nan nan];
%                     RecMetrics.DimJerk{subj,sess,g}=nan;
%                     Rec.DJ(:,subj,sess,g)=[nan nan];
%                     RecMetrics.LinIndx{subj,sess,g}=nan;
%                     Rec.LI(:,subj,sess,g)=[nan nan];
%                     RecMetrics.NP{subj,sess,g}=nan;
%                     Rec.NP(:,subj,sess,g)=[nan nan];
%                     
%                     varcur.andate_x(sess,subj,g) = nan;
%                     varcur.andate_y(sess,subj,g) = nan;
%                     varcur.allmov_x(sess,subj,g) = nan;
%                     varcur.allmov_y(sess,subj,g) = nan;
%                     
%                     Nvarcur.andate_x(sess,subj,g) = nan;
%                     Nvarcur.andate_y(sess,subj,g) = nan;
%                     Nvarcur.allmov_x(sess,subj,g) = nan;
%                     Nvarcur.allmov_y(sess,subj,g) = nan;
%                     
%                     % shoulders variability
%                     varshouldL.andate_x(sess,subj,g) = nan;
%                     varshouldL.andate_y(sess,subj,g) = nan;
%                     varshouldL.andate_z(sess,subj,g) = nan;
%                     varshouldL.allmov_x(sess,subj,g) = nan;
%                     varshouldL.allmov_y(sess,subj,g) = nan;
%                     varshouldL.allmov_z(sess,subj,g) = nan;
%                     varshouldR.andate_x(sess,subj,g) = nan;
%                     varshouldR.andate_y(sess,subj,g) = nan;
%                     varshouldR.andate_z(sess,subj,g) = nan;
%                     varshouldR.allmov_x(sess,subj,g) = nan;
%                     varshouldR.allmov_y(sess,subj,g) = nan;
%                     varshouldR.allmov_z(sess,subj,g) = nan;
%                     % pelvis variability
%                     varpelvisL.andate_x(sess,subj,g) = nan;
%                     varpelvisL.andate_y(sess,subj,g) = nan;
%                     varpelvisL.andate_z(sess,subj,g) = nan;
%                     varpelvisL.allmov_x(sess,subj,g) = nan;
%                     varpelvisL.allmov_y(sess,subj,g) = nan;
%                     varpelvisL.allmov_z(sess,subj,g) = nan;
%                     varpelvisR.andate_x(sess,subj,g) = nan;
%                     varpelvisR.andate_y(sess,subj,g) = nan;
%                     varpelvisR.andate_z(sess,subj,g) = nan;
%                     varpelvisR.allmov_x(sess,subj,g) = nan;
%                     varpelvisR.allmov_y(sess,subj,g) = nan;
%                     varpelvisR.allmov_z(sess,subj,g) = nan;
                end
                
                clear out_findmovement
            end %of kk epochs
        end
    end %of sess
end %end subj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reach: mean and std of reaching metrics after removing outliers
% ReachMetrics : indicators calculated for each trial of each session
save_data({'ReachCompleteData','ReachKinectData','Rec_cursor','Null_cursor','outliers','Mappe'},ReachCompleteData,ReachKinectData,Rec_cursor,Null_cursor,outliers,Mappe);
% save_data({'ReachCompleteData','ReachKinectData','Rec_cursor','Null_cursor','Reach','ReachMetrics','Rec','RecMetrics','varshouldL','varshouldR','varpelvisL','varpelvisR','Mappe'},ReachCompleteData,ReachKinectData,Rec_cursor,Null_cursor,Reach,ReachMetrics,Rec,RecMetrics,varshouldL,varshouldR,varpelvisL,varpelvisR,Mappe);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
