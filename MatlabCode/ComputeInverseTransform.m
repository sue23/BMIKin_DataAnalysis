function ComputeInverseTransform(datadir)
%PlotHipDistanceinMap valuta distanza tra marker in fase di esercizio
%   Detailed explanation goes here

% markers = {'hipc','spine','shc','head','shl','elbl','wristl','handl','shr','elbr','wristr','handr','hipl','kneel','anklel','footl','hipr','kneer','ankler','footr'};
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
fine=[7 10 6 10];
A=load(['mats',filesep,'ReachKinectDataK']); %marker in system body
tit='';
load(['mats',filesep,'start']);
start = ind;
load(['mats',filesep,'stop']);
stop = ind;
load(['mats',filesep,'Mappe']);
maps = ind;
load(['mats',filesep,'cursor']);
cursor = ind;


for subj=1:length(soggetti)
    
    %similmente a prima, dentro ad ogni cartella del soggetto c'è una cartella
    %per ogni sessione
    listsess = dir([datadir,filesep, soggetti{subj}]);
    listsess = listsess(3:length(listsess),:);%le prime due directory non servono
    maxsess=length({listsess.name});
    
    if maxsess>10
        display('WARNING! Sessions more than 10');
        keyboard
    end
    %     for g = 1:size(A.ind,3)
    for g=1:2
        andate=[];
        cursore=[];
        for sess=1:maxsess
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
            mouse = cursor{subj,sess,g};
            if isnan(mouse)
                continue
            else
                for trial = 1:length(start{subj,sess,g})
                    
                    if isnan(start{subj,sess,g}(trial))
                        continue
                    end
                        andate = [andate ; data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:)];
                        cursore = [cursore mouse(:,start{subj,sess,g}(trial):stop{subj,sess,g}(trial))];
                    
                end %end trial
            end
            if isnan(mappa)
                continue
            else
                kinectX{subj,sess,g}=pinv(mappa')* [cursore(1,:);cursore(2,:).*0];
                kinectY{subj,sess,g}=pinv(mappa')* [cursore(1,:).*0;cursore(2,:)];
                
                kinectXvarX_hipL{subj,sess,g}=var(kinectX{subj,sess,g}(37,:));
                kinectXvarY_hipL{subj,sess,g}=var(kinectX{subj,sess,g}(38,:));
                kinectXvarZ_hipL{subj,sess,g}=var(kinectX{subj,sess,g}(39,:));
                kinectXvarX_hipR{subj,sess,g}=var(kinectX{subj,sess,g}(49,:));
                kinectXvarY_hipR{subj,sess,g}=var(kinectX{subj,sess,g}(50,:));
                kinectXvarZ_hipR{subj,sess,g}=var(kinectX{subj,sess,g}(51,:));
                
                kinectYvarX_hipL{subj,sess,g}=var(kinectY{subj,sess,g}(37,:));
                kinectYvarY_hipL{subj,sess,g}=var(kinectY{subj,sess,g}(38,:));
                kinectYvarZ_hipL{subj,sess,g}=var(kinectY{subj,sess,g}(39,:));
                kinectYvarX_hipR{subj,sess,g}=var(kinectY{subj,sess,g}(49,:));
                kinectYvarY_hipR{subj,sess,g}=var(kinectY{subj,sess,g}(50,:));
                kinectYvarZ_hipR{subj,sess,g}=var(kinectY{subj,sess,g}(51,:));
                if g==1
                    ratioYXvarX_hipL(subj,sess)=var(kinectY{subj,sess,g}(37,:))/var(kinectX{subj,sess,g}(37,:));
                    ratioYXvarY_hipL(subj,sess)=var(kinectY{subj,sess,g}(38,:))/var(kinectX{subj,sess,g}(38,:));
                    ratioYXvarZ_hipL(subj,sess)=var(kinectY{subj,sess,g}(39,:))/var(kinectX{subj,sess,g}(39,:));
                    ratioYXvarX_hipR(subj,sess)=var(kinectY{subj,sess,g}(49,:))/var(kinectX{subj,sess,g}(49,:));
                    ratioYXvarY_hipR(subj,sess)=var(kinectY{subj,sess,g}(50,:))/var(kinectX{subj,sess,g}(50,:));
                    ratioYXvarZ_hipR(subj,sess)=var(kinectY{subj,sess,g}(51,:))/var(kinectX{subj,sess,g}(51,:));
                else if g==2
                        ratioXYvarX_hipL(subj,sess)=var(kinectX{subj,sess,g}(37,:))/var(kinectY{subj,sess,g}(37,:));
                        ratioXYvarY_hipL(subj,sess)=var(kinectX{subj,sess,g}(38,:))/var(kinectY{subj,sess,g}(38,:));
                        ratioXYvarZ_hipL(subj,sess)=var(kinectX{subj,sess,g}(39,:))/var(kinectY{subj,sess,g}(39,:));
                        ratioXYvarX_hipR(subj,sess)=var(kinectX{subj,sess,g}(49,:))/var(kinectY{subj,sess,g}(49,:));
                        ratioXYvarY_hipR(subj,sess)=var(kinectX{subj,sess,g}(50,:))/var(kinectY{subj,sess,g}(50,:));
                        ratioXYvarZ_hipR(subj,sess)=var(kinectX{subj,sess,g}(51,:))/var(kinectY{subj,sess,g}(51,:));
                    end
                end
                
                
            end
           
        end
        
         clear cursore
         clear andate
        
    end
%     figure(11)
%         subplot(1,3,subj)
%         bar([ratioYXvarX_hipL{subj,1,1} ratioYXvarX_hipL{subj,fine(subj),1}])
end


save_data({'kinectX','kinectY'},kinectX,kinectY);
end


