function ComputeLastAnalysis(datadir)
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
load(['mats',filesep,'ReachMetrics']);
metric=ind;

load(['mats',filesep,'targetseq']);


for subj=1:3%length(soggetti)
    
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
        switch g
            case 1
                seq = horizseq;
            case 2
                seq = vertseq;
        end
        
        andate=[];
        cursore=[];
        for sess=[1 fine(subj)]
            if g==1
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    %ordine: left hip right hip left shoulder right
                    %shoulder
                    mappa=maps{sess,subj}.A_o;
                    post=maps{sess,subj}.A_oPosture;
                else
                    mappa=maps{sess,subj}.A;
                    post=maps{sess,subj}.APosture;
                end
            elseif g==2
                if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
                    mappa=maps{sess,subj}.A_v;
                    post=maps{sess,subj}.A_vPosture;
                else
                    mappa=maps{sess,subj}.A;
                    post=maps{sess,subj}.APosture;
                end
            else
                mappa=maps{sess,subj}.A;
                post=maps{sess,subj}.APosture;
            end
            
            data_markers = A.ind{subj,sess,g}+repmat(mean(post),size(A.ind{subj,sess,g},1),1);
            mouse = cursor{subj,sess,g};
            if isnan(mouse)
                continue
            else
                for trial = 1:length(start{subj,sess,g})
                    
                    if isnan(start{subj,sess,g}(trial))
                        continue
                    end
                    if isnan(metric.MT{subj,sess,g}(trial))
                        continue
                    end
                        andate = [andate ; data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),:)];
                        cursore = [cursore mouse(:,start{subj,sess,g}(trial):stop{subj,sess,g}(trial))];
%                         figure(subj*sess*g)
%                         plot3(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),37),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),38),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),39),'m');
%                         hold on
%                         plot3(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),49),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),50),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),51),'r');
%                         plot3(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),13),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),14),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),15),'b');
%                         plot3(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),25),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),26),data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),27),'k');
%                         legend('left hip','right hip','left sh','right sh')
%                         title(['Subject',num2str(subj),' session',num2str(sess),' task',num2str(g)])
                        
                        %variance and std of each single trajectory hips
                        %and shoulders
                        vartrial_hipL(trial,:)=[var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),37)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),38)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),39))];
                        vartrial_hipR(trial,:)=[var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),49)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),50)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),51))];
                        vartrial_shL(trial,:)=[var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),13)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),14)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),15))];
                        vartrial_shR(trial,:)=[var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),25)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),26)) var(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),27))];
                        
                        stdtrial_hipL(trial,:)=[std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),37)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),38)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),39))];
                        stdtrial_hipR(trial,:)=[std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),49)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),50)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),51))];
                        stdtrial_shL(trial,:)=[std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),13)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),14)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),15))];
                        stdtrial_shR(trial,:)=[std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),25)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),26)) std(data_markers(start{subj,sess,g}(trial):stop{subj,sess,g}(trial),27))];

                        delta_hipL(trial,:)=data_markers(stop{subj,sess,g}(trial),37:39)-data_markers(start{subj,sess,g}(trial),37:39);
                        delta_hipR(trial,:)=data_markers(stop{subj,sess,g}(trial),49:51)-data_markers(start{subj,sess,g}(trial),49:51);
                        delta_shL(trial,:)=data_markers(stop{subj,sess,g}(trial),13:15)-data_markers(start{subj,sess,g}(trial),13:15);
                        delta_shR(trial,:)=data_markers(stop{subj,sess,g}(trial),25:27)-data_markers(start{subj,sess,g}(trial),25:27);
                end %end trial
                if g==1
                    %mean of variance and std for reaching H
                    varmean_hipL_H(:,sess,subj)=mean([nonzeros(vartrial_hipL(:,1)) nonzeros(vartrial_hipL(:,2)) nonzeros(vartrial_hipL(:,3))]);
                    varmean_hipR_H(:,sess,subj)=mean([nonzeros(vartrial_hipR(:,1)) nonzeros(vartrial_hipR(:,2)) nonzeros(vartrial_hipR(:,3))]);
                    stdmean_hipL_H(:,sess,subj)=mean([nonzeros(stdtrial_hipL(:,1)) nonzeros(stdtrial_hipL(:,2)) nonzeros(stdtrial_hipL(:,3))]);
                    stdmean_hipR_H(:,sess,subj)=mean([nonzeros(stdtrial_hipR(:,1)) nonzeros(stdtrial_hipR(:,2)) nonzeros(stdtrial_hipR(:,3))]);
                    varmean_shL_H(:,sess,subj)=mean([nonzeros(vartrial_shL(:,1)) nonzeros(vartrial_shL(:,2)) nonzeros(vartrial_shL(:,3))]);
                    varmean_shR_H(:,sess,subj)=mean([nonzeros(vartrial_shR(:,1)) nonzeros(vartrial_shR(:,2)) nonzeros(vartrial_shR(:,3))]);
                    stdmean_shL_H(:,sess,subj)=mean([nonzeros(stdtrial_shL(:,1)) nonzeros(stdtrial_shL(:,2)) nonzeros(stdtrial_shL(:,3))]);
                    stdmean_shR_H(:,sess,subj)=mean([nonzeros(stdtrial_shR(:,1)) nonzeros(stdtrial_shR(:,2)) nonzeros(stdtrial_shR(:,3))]);
                    %DIVIDO QUA PER  DUE TARGET PERCHÈ LE HIP AVRANNO
                    %POSIZIONI DIVERSE A SECONDA DEL TRGT CHE COMPARE
                    deltamean_hipL_trgt1H(:,sess,subj)=mean([nonzeros(delta_hipL(find(seq{subj,sess}==1),1)) nonzeros(delta_hipL(find(seq{subj,sess}==1),2)) nonzeros(delta_hipL(find(seq{subj,sess}==1),3))]);
                    deltamean_hipR_trgt1H(:,sess,subj)=mean([nonzeros(delta_hipR(find(seq{subj,sess}==1),1)) nonzeros(delta_hipR(find(seq{subj,sess}==1),2)) nonzeros(delta_hipR(find(seq{subj,sess}==1),3))]);
                    deltamean_hipL_trgt2H(:,sess,subj)=mean([nonzeros(delta_hipL(find(seq{subj,sess}==2),1)) nonzeros(delta_hipL(find(seq{subj,sess}==2),2)) nonzeros(delta_hipL(find(seq{subj,sess}==2),3))]);
                    deltamean_hipR_trgt2H(:,sess,subj)=mean([nonzeros(delta_hipR(find(seq{subj,sess}==2),1)) nonzeros(delta_hipR(find(seq{subj,sess}==2),2)) nonzeros(delta_hipR(find(seq{subj,sess}==2),3))]);
                    deltamean_shL_trgt1H(:,sess,subj)=mean([nonzeros(delta_shL(find(seq{subj,sess}==1),1)) nonzeros(delta_shL(find(seq{subj,sess}==1),2)) nonzeros(delta_shL(find(seq{subj,sess}==1),3))]);
                    deltamean_shR_trgt1H(:,sess,subj)=mean([nonzeros(delta_shR(find(seq{subj,sess}==1),1)) nonzeros(delta_shR(find(seq{subj,sess}==1),2)) nonzeros(delta_shR(find(seq{subj,sess}==1),3))]);
                    deltamean_shL_trgt2H(:,sess,subj)=mean([nonzeros(delta_shL(find(seq{subj,sess}==2),1)) nonzeros(delta_shL(find(seq{subj,sess}==2),2)) nonzeros(delta_shL(find(seq{subj,sess}==2),3))]);
                    deltamean_shR_trgt2H(:,sess,subj)=mean([nonzeros(delta_shR(find(seq{subj,sess}==2),1)) nonzeros(delta_shR(find(seq{subj,sess}==2),2)) nonzeros(delta_shR(find(seq{subj,sess}==2),3))]);
                else
                    %mean of variance and std for reach V
                    varmean_hipL_V(:,sess,subj)=mean([nonzeros(vartrial_hipL(:,1)) nonzeros(vartrial_hipL(:,2)) nonzeros(vartrial_hipL(:,3))]);
                    varmean_hipR_V(:,sess,subj)=mean([nonzeros(vartrial_hipR(:,1)) nonzeros(vartrial_hipR(:,2)) nonzeros(vartrial_hipR(:,3))]);
                    stdmean_hipL_V(:,sess,subj)=mean([nonzeros(stdtrial_hipL(:,1)) nonzeros(stdtrial_hipL(:,2)) nonzeros(stdtrial_hipL(:,3))]);
                    stdmean_hipR_V(:,sess,subj)=mean([nonzeros(stdtrial_hipR(:,1)) nonzeros(stdtrial_hipR(:,2)) nonzeros(stdtrial_hipR(:,3))]);
                    varmean_shL_V(:,sess,subj)=mean([nonzeros(vartrial_shL(:,1)) nonzeros(vartrial_shL(:,2)) nonzeros(vartrial_shL(:,3))]);
                    varmean_shR_V(:,sess,subj)=mean([nonzeros(vartrial_shR(:,1)) nonzeros(vartrial_shR(:,2)) nonzeros(vartrial_shR(:,3))]);
                    stdmean_shL_V(:,sess,subj)=mean([nonzeros(stdtrial_shL(:,1)) nonzeros(stdtrial_shL(:,2)) nonzeros(stdtrial_shL(:,3))]);
                    stdmean_shR_V(:,sess,subj)=mean([nonzeros(stdtrial_shR(:,1)) nonzeros(stdtrial_shR(:,2)) nonzeros(stdtrial_shR(:,3))]);
                    
                    deltamean_hipL_trgt1V(:,sess,subj)=mean([nonzeros(delta_hipL(find(seq{subj,sess}==1),1)) nonzeros(delta_hipL(find(seq{subj,sess}==1),2)) nonzeros(delta_hipL(find(seq{subj,sess}==1),3))]);
                    deltamean_hipR_trgt1V(:,sess,subj)=mean([nonzeros(delta_hipR(find(seq{subj,sess}==1),1)) nonzeros(delta_hipR(find(seq{subj,sess}==1),2)) nonzeros(delta_hipR(find(seq{subj,sess}==1),3))]);
                    deltamean_hipL_trgt2V(:,sess,subj)=mean([nonzeros(delta_hipL(find(seq{subj,sess}==2),1)) nonzeros(delta_hipL(find(seq{subj,sess}==2),2)) nonzeros(delta_hipL(find(seq{subj,sess}==2),3))]);
                    deltamean_hipR_trgt2V(:,sess,subj)=mean([nonzeros(delta_hipR(find(seq{subj,sess}==2),1)) nonzeros(delta_hipR(find(seq{subj,sess}==2),2)) nonzeros(delta_hipR(find(seq{subj,sess}==2),3))]);
                    deltamean_shL_trgt1V(:,sess,subj)=mean([nonzeros(delta_shL(find(seq{subj,sess}==1),1)) nonzeros(delta_shL(find(seq{subj,sess}==1),2)) nonzeros(delta_shL(find(seq{subj,sess}==1),3))]);
                    deltamean_shR_trgt1V(:,sess,subj)=mean([nonzeros(delta_shR(find(seq{subj,sess}==1),1)) nonzeros(delta_shR(find(seq{subj,sess}==1),2)) nonzeros(delta_shR(find(seq{subj,sess}==1),3))]);
                    deltamean_shL_trgt2V(:,sess,subj)=mean([nonzeros(delta_shL(find(seq{subj,sess}==2),1)) nonzeros(delta_shL(find(seq{subj,sess}==2),2)) nonzeros(delta_shL(find(seq{subj,sess}==2),3))]);
                    deltamean_shR_trgt2V(:,sess,subj)=mean([nonzeros(delta_shR(find(seq{subj,sess}==2),1)) nonzeros(delta_shR(find(seq{subj,sess}==2),2)) nonzeros(delta_shR(find(seq{subj,sess}==2),3))]);
                end
            end
            if isnan(mappa)
                continue
            else
%                 kinectX{subj,sess,g}=pinv(mappa')* [cursore(1,:);cursore(2,:).*0];
%                 kinectY{subj,sess,g}=pinv(mappa')* [cursore(1,:).*0;cursore(2,:)];
%                 kinectALL{subj,sess,g}=pinv(mappa')* cursore;
                if sess==1 || sess==fine(subj)
%                     figure
%                     plot3(kinectALL{subj,sess,g}(37,:),kinectALL{subj,sess,g}(38,:),kinectALL{subj,sess,g}(39,:),'.');
%                     hold on
%                     plot3(kinectALL{subj,sess,g}(49,:),kinectALL{subj,sess,g}(50,:),kinectALL{subj,sess,g}(51,:),'r.');
% %                     plot3(kinectY{subj,sess,g}(37,:),kinectY{subj,sess,g}(38,:),kinectY{subj,sess,g}(39,:),'k.');
% %                     plot3(kinectY{subj,sess,g}(49,:),kinectY{subj,sess,g}(50,:),kinectY{subj,sess,g}(51,:),'c.');
%                     legend('left hipx','right hipx','left hipy','right hipy')
%                     title(['subject',num2str(subj),'sess',num2str(sess),'task',num2str(g)])
if g==1
    %hip
    varianzaxHipl_hor(subj,sess)=var(andate(:,37));
    varianzayHipl_hor(subj,sess)=var(andate(:,38));
    varianzazHipl_hor(subj,sess)=var(andate(:,39));
    
    varianzaxHipr_hor(subj,sess)=var(andate(:,49));
    varianzayHipr_hor(subj,sess)=var(andate(:,50));
    varianzazHipr_hor(subj,sess)=var(andate(:,51));
    
    stdxHipl_hor(subj,sess)=var(andate(:,37));
    stdyHipl_hor(subj,sess)=var(andate(:,38));
    stdzHipl_hor(subj,sess)=var(andate(:,39));
    
    stdxHipr_hor(subj,sess)=var(andate(:,49));
    stdyHipr_hor(subj,sess)=var(andate(:,50));
    stdzHipr_hor(subj,sess)=var(andate(:,51));
    %shoulder
    varianzaxShl_hor(subj,sess)=var(andate(:,13));
    varianzayShl_hor(subj,sess)=var(andate(:,14));
    varianzazShl_hor(subj,sess)=var(andate(:,15));
    
    varianzaxShr_hor(subj,sess)=var(andate(:,25));
    varianzayShr_hor(subj,sess)=var(andate(:,26));
    varianzazShr_hor(subj,sess)=var(andate(:,27));
    
    stdxShl_hor(subj,sess)=var(andate(:,13));
    stdyShl_hor(subj,sess)=var(andate(:,14));
    stdzShl_hor(subj,sess)=var(andate(:,15));
    
    stdxShr_hor(subj,sess)=var(andate(:,25));
    stdyShr_hor(subj,sess)=var(andate(:,26));
    stdzShr_hor(subj,sess)=var(andate(:,27));
    
%     figure(1)
%     plot3(andate(:,37),andate(:,38),andate(:,39),'.');
%     hold on
%     plot3(andate(:,49),andate(:,50),andate(:,51),'r.');
%     plot3(andate(:,13),andate(:,14),andate(:,15),'b.');
%     hold on
%     plot3(andate(:,25),andate(:,26),andate(:,27),'k.');
%     legend('left hip','right hip','left hs','right sh')
else
    %hip
    varianzaxHipl_vert(subj,sess)=var(andate(:,37));
    varianzayHipl_vert(subj,sess)=var(andate(:,38));
    varianzazHipl_vert(subj,sess)=var(andate(:,39));
    
    varianzaxHipr_vert(subj,sess)=var(andate(:,49));
    varianzayHipr_vert(subj,sess)=var(andate(:,50));
    varianzazHipr_vert(subj,sess)=var(andate(:,51));
    
    stdxHipl_vert(subj,sess)=std(andate(:,37));
    stdyHipl_vert(subj,sess)=std(andate(:,38));
    stdzHipl_vert(subj,sess)=std(andate(:,39));
    
    stdxHipr_vert(subj,sess)=std(andate(:,49));
    stdyHipr_vert(subj,sess)=std(andate(:,50));
    stdzHipr_vert(subj,sess)=std(andate(:,51));
    %shoulder
    varianzaxShl_vert(subj,sess)=var(andate(:,13));
    varianzayShl_vert(subj,sess)=var(andate(:,14));
    varianzazShl_vert(subj,sess)=var(andate(:,15));
    
    varianzaxShr_vert(subj,sess)=var(andate(:,25));
    varianzayShr_vert(subj,sess)=var(andate(:,26));
    varianzazShr_vert(subj,sess)=var(andate(:,27));
    
    stdxShl_vert(subj,sess)=var(andate(:,13));
    stdyShl_vert(subj,sess)=var(andate(:,14));
    stdzShl_vert(subj,sess)=var(andate(:,15));
    
    stdxShr_vert(subj,sess)=var(andate(:,25));
    stdyShr_vert(subj,sess)=var(andate(:,26));
    stdzShr_vert(subj,sess)=var(andate(:,27));
%     plot3(andate(:,37),andate(:,38),andate(:,39),'c.');
%     hold on
%     plot3(andate(:,49),andate(:,50),andate(:,51),'m.');
%     plot3(andate(:,13),andate(:,14),andate(:,15),'y.');
%     hold on
%     plot3(andate(:,25),andate(:,26),andate(:,27),'m.');
end
                    
                end
%                 kinectXvarX_hipL{subj,sess,g}=var(kinectX{subj,sess,g}(37,:));
%                 kinectXvarY_hipL{subj,sess,g}=var(kinectX{subj,sess,g}(38,:));
%                 kinectXvarZ_hipL{subj,sess,g}=var(kinectX{subj,sess,g}(39,:));
%                 kinectXvarX_hipR{subj,sess,g}=var(kinectX{subj,sess,g}(49,:));
%                 kinectXvarY_hipR{subj,sess,g}=var(kinectX{subj,sess,g}(50,:));
%                 kinectXvarZ_hipR{subj,sess,g}=var(kinectX{subj,sess,g}(51,:));
%                 
%                 kinectYvarX_hipL{subj,sess,g}=var(kinectY{subj,sess,g}(37,:));
%                 kinectYvarY_hipL{subj,sess,g}=var(kinectY{subj,sess,g}(38,:));
%                 kinectYvarZ_hipL{subj,sess,g}=var(kinectY{subj,sess,g}(39,:));
%                 kinectYvarX_hipR{subj,sess,g}=var(kinectY{subj,sess,g}(49,:));
%                 kinectYvarY_hipR{subj,sess,g}=var(kinectY{subj,sess,g}(50,:));
%                 kinectYvarZ_hipR{subj,sess,g}=var(kinectY{subj,sess,g}(51,:));
%                 if g==1
%                     ratioYXvarX_hipL(subj,sess)=var(kinectY{subj,sess,g}(37,:))/var(kinectX{subj,sess,g}(37,:));
%                     ratioYXvarY_hipL(subj,sess)=var(kinectY{subj,sess,g}(38,:))/var(kinectX{subj,sess,g}(38,:));
%                     ratioYXvarZ_hipL(subj,sess)=var(kinectY{subj,sess,g}(39,:))/var(kinectX{subj,sess,g}(39,:));
%                     ratioYXvarX_hipR(subj,sess)=var(kinectY{subj,sess,g}(49,:))/var(kinectX{subj,sess,g}(49,:));
%                     ratioYXvarY_hipR(subj,sess)=var(kinectY{subj,sess,g}(50,:))/var(kinectX{subj,sess,g}(50,:));
%                     ratioYXvarZ_hipR(subj,sess)=var(kinectY{subj,sess,g}(51,:))/var(kinectX{subj,sess,g}(51,:));
%                 else if g==2
%                         ratioXYvarX_hipL(subj,sess)=var(kinectX{subj,sess,g}(37,:))/var(kinectY{subj,sess,g}(37,:));
%                         ratioXYvarY_hipL(subj,sess)=var(kinectX{subj,sess,g}(38,:))/var(kinectY{subj,sess,g}(38,:));
%                         ratioXYvarZ_hipL(subj,sess)=var(kinectX{subj,sess,g}(39,:))/var(kinectY{subj,sess,g}(39,:));
%                         ratioXYvarX_hipR(subj,sess)=var(kinectX{subj,sess,g}(49,:))/var(kinectY{subj,sess,g}(49,:));
%                         ratioXYvarY_hipR(subj,sess)=var(kinectX{subj,sess,g}(50,:))/var(kinectY{subj,sess,g}(50,:));
%                         ratioXYvarZ_hipR(subj,sess)=var(kinectX{subj,sess,g}(51,:))/var(kinectY{subj,sess,g}(51,:));
%                     end
%                 end
                
                
            end
           
        end
        
        
        
        clear cursore
        clear andate
        
    end%end task

end %end subject

plotvariance_std_delta

end
