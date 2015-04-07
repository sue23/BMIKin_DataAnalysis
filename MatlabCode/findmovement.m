function [out]=findmovement(stopIndx,startIndx,Data,subj,sess,soggetti,g,kk,A,Rotation,Gain,Offset)
%findmovement
%   OUTPUT:
%   reachcompletedata matrice con collonne: time, XY pos, reach state
%   reachkinectdata matrice con dati sensori. Una coordinata per ogni
%   colonna
%   start e stop vettori con indici di inizio e fine movimento determinato
%   con profilo di velocit?
try
if strcmp(soggetti{subj},'cv') & sess==3 & kk==1 & g==2
    reachcompletedata=nan;reachkinectdata=nan;start=nan;stop=nan;
    out.reachcompletedata=reachcompletedata;
    out.reachkinectdata=reachkinectdata;
    out.reachkinectdataK=nan;
    out.start=start;
    out.stop=stop;
    %     out.outlierindx=nan;
    out.dur=nan;
    out.rtime=nan;
    return
    
end
catch
    keyboard
end
% if strcmp(soggetti{subj},'pg') & sess==2 & kk==2
%     reachcompletedata=nan;reachkinectdata=nan;start=nan;stop=nan;
%     out.reachcompletedata=reachcompletedata;
%     out.reachkinectdata=reachkinectdata;
%     out.start=start;
%     out.stop=stop;
% %     out.outlierindx=nan;
%     out.dur=nan;
%     out.rtime=nan;
%     return
% end
ReachData = Data(startIndx:stopIndx,[2:4,6,18:77]); % time, XY pos, reach state, kin data

% ReachData colonna 1: time
% ReachData colonna 2: X cursor
% ReachData colonna 3: Y cursor
% ReachData colonna 4: stato durante il reching
%                         0: On the fly
%                         1: Center
%                         2: Target
%                         3: 1s Time to Target is Over
%ReachData colonna 5: data kinect

%%%%%interpolation
rawTime=ReachData(:,1)-ReachData(1,1);
endrawTime=find(~isnan(rawTime),1,'last');
newtime=0:(1/30):rawTime(endrawTime);
reachcompletedata(:,1)=newtime;
reachcompletedata(:,2:3)=interp1(rawTime(~isnan(rawTime)),ReachData((~isnan(rawTime)),2:3),newtime');

% if strcmp(soggetti{subj},'cv') & (sess==1|sess==2) & kk==1 & g==1
temp = find(ReachData(:,4)==1);%in center target
rstate = [temp((diff(temp)~=1)); temp(end)];%  leave the central trgt cambiamento del tempo solo quando lasci il target centrale
ReachData([rstate+1 rstate+2],4)=1;
ReachData([rstate-2 rstate-1],4)=1;


temp2 = find(ReachData(:,4)==2);%in peripheral target
rstate2 = [temp2((diff(temp2)~=1)); temp2(end)];%  leave the central trgt cambiamento del tempo solo quando lasci il target centrale
ReachData([rstate2+1 rstate2+2],4)=2;
ReachData([rstate2-2 rstate2-1],4)=2;


% figure
% plot(ReachData(:,4))
% end
reachcompletedata(:,4)=interp1(rawTime,ReachData(:,4),newtime','nearest');
% figure
% plot(reachcompletedata(:,4))

kinectdata=interp1(rawTime,ReachData(:,5:end),newtime');

% Identification of init and stop of each reaching movement da
% definie meglio???
temp3 = find(reachcompletedata(:,4)==1);%in center target
temp4 = find(reachcompletedata(:,4)==2);%in out target
InitIndx = [temp3((diff(temp3)~=1)); temp3(end)];%  leave the central trgt cambiamento del tempo solo quando lasci il target centrale
StopIndx = [temp4((diff(temp4)~=1)); temp4(end); size(reachcompletedata,1)];%arrive in the peripheral trgt
if (strcmp(soggetti{subj},'gr') & sess==6 & kk==1) | (strcmp(soggetti{subj},'cv') & sess==7 & kk==1) | (strcmp(soggetti{subj},'gg'))| (strcmp(soggetti{subj},'pg'))
    StopIndx = [temp4((diff(temp4)~=1)); temp4(end)];%arrive in the peripheral trgt
else
    StopIndx = [temp4((diff(temp4)~=1)); temp4(end); size(reachcompletedata,1)];%arrive in the peripheral trgt
end
if strcmp(soggetti{subj},'cv')
    if sess==1 & kk==1 & g==2
        StopIndx= [1177-startIndx(kk); StopIndx];
    elseif sess==4 & kk==1 & g==2
        StopIndx= [5541-startIndx(kk); StopIndx];
    elseif sess==5 & kk==1 & g==3
        StopIndx(21)=[];
    elseif sess==7 & kk==1 & g==3
        StopIndx(21)=[];
    end
end
if strcmp(soggetti{subj},'gg')
    if sess==4 & kk==1 & g==1
        StopIndx= [StopIndx(1:6); 23650-startIndx(kk); StopIndx(7:end)];
        StopIndx = StopIndx(8:end);
        InitIndx = InitIndx(8:end);
    elseif sess==7 & g==3 & kk==1
        StopIndx= sort([26261;StopIndx]);
    end
end
if strcmp(soggetti{subj},'gr')
    if sess==3 & g==2 & kk==1
        StopIndx = StopIndx(1:end-1);
    elseif sess==4 & g==3 & kk==1
        StopIndx = StopIndx(1:20);
        InitIndx = InitIndx(1:20);
    elseif sess==5 & g==2 & kk==1
        pi1=StopIndx(1:2);pi2=StopIndx(3:end);
        StopIndx= [pi1; 13859-startIndx(kk); pi2];
    end
end
if strcmp(soggetti{subj},'pg')
    if sess==7 & kk==1 & g==1
        StopIndx= sort([StopIndx(1);6095;StopIndx(2:end)]);%; 18455]);
        StopIndx = StopIndx(3:end);
        InitIndx = InitIndx(3:end);
    end
    if sess==8 & kk==1 & g==1
        StopIndx= sort([StopIndx(1);24295;StopIndx(2:end)]);% 43635]);
        StopIndx = StopIndx(3:end);
        InitIndx = InitIndx(3:end);
    end
    if sess==8 & kk==1 & g==2
        StopIndx= sort([2071;StopIndx]);% 1139]);
        StopIndx = StopIndx(2:end);
        InitIndx = InitIndx(2:end);
    end
end
%
% figure
% plot(reachcompletedata(:,4),'m')
% hold on
% plot(InitIndx,reachcompletedata(InitIndx,4),'ow')
% plot(StopIndx,ones(length(StopIndx),1),'ow')
% vs = 1:length(StopIndx);
% vi = 1:length(InitIndx);
% for i =1:length(vi)
%     h=text(InitIndx(i),reachcompletedata(InitIndx(i),4),num2str(vi(i)))
%     h.FontSize=13;
%     h.Color='r';
% end
% for ii=1:length(vs)
%     h2=text(StopIndx(ii),1,num2str(vs(ii)))
%     h2.FontSize=13;
%     h2.Color='b';
% end


for trial=1:length(InitIndx)
    if strcmp(soggetti{subj},'cv')
        if sess==4 && trial<3
            Gain = 1;
        elseif sess==4 && trial>2
            Gain = 2;
        end
    end
    try
        time=reachcompletedata(InitIndx(trial):StopIndx(trial),1);
    catch
        keyboard
    end
    if ~isempty(find(isnan(time)))
        keyboard
    end
    
    % cutoff=test_sav_golay(lfilter,polord,derorder,fc)
    % cutoff=test_sav_golay(29,4,0,30) Usati nel PD
    % cutoff=test_sav_golay(29,4,1,30);
    fc=30;
    lfilter=29;%19;
    polord=4;%8
    vel = sav_golay(reachcompletedata(:,2:3),lfilter,polord,1,30);
    [beg(trial), fine(trial),mt(trial)]=start_stop(reachcompletedata(InitIndx(trial):StopIndx(trial),1:3),vel(InitIndx(trial):StopIndx(trial),:));
    %         figure(1)
    %         line([InitIndx(k)+beg(k)+startIndx(kk) InitIndx(k)+beg(k)+startIndx(kk)]',[0 8]','col','c')
    %         line([InitIndx(k)+stop(k)+startIndx(kk) InitIndx(k)+stop(k)+startIndx(kk)]',[0 8]','col','k')
    %         plot(InitIndx(k)+startIndx(kk):StopIndx(k)+startIndx(kk)-1,mt(k).speed./10,'.')
    
    start(trial)=InitIndx(trial)+beg(trial);
    stop(trial)=InitIndx(trial)+fine(trial);
    
%     [xyzB]=TKinectInBody(A,kinectdata);
%     reachkinectdata = reshape(xyzB,size(kinectdata,1),size(kinectdata,2));
    
    
    if (bad_trial(subj,sess,g,kk,trial))
        Cursordata{trial}=reachcompletedata(start(trial):stop(trial),:).*nan;
        Kinectdata{trial}=kinectdata(start(trial):stop(trial),:).*nan;
        Reconstructedcursor{trial} = ones(2,stop(trial)-start(trial)+1).*nan;
        Null_cursor{trial} = ones(58,stop(trial)-start(trial)+1).*nan;
        mt(trial).rtime=mt(trial).rtime.*nan;
        mt(trial).dur=mt(trial).dur.*nan;
        numpeaks(trial) = nan;
    else
        Cursordata{trial}=reachcompletedata(start(trial):stop(trial),:);
        Reconstructedcursor{trial}=reachcompletedata(start(trial):stop(trial),:).*nan;
        Kinectdata{trial}=kinectdata(start(trial):stop(trial),:);
        mt(trial).rtime=mt(trial).rtime;
        mt(trial).dur=mt(trial).dur;
        %trovo numero di picchi
        threshold=0.20;
        [pks,locs] = findpeaks(mt(trial).speed);
        pksval = pks(pks>=threshold*max(pks));
        numpeaks(trial) = length(pksval);
        Reconstructedcursor{trial} = ReconstructFromBody(Kinectdata{trial},A,Rotation,Gain,Offset);
        Null_cursor{trial} = ReconstructNullSpace(Kinectdata{trial},A);
    end
    
    
end % end trial

% % keyboard
out.rtime=[mt.rtime];
out.reachcompletedata=Cursordata;
out.nullcursor=Null_cursor;
out.reconstructedcursordata=Reconstructedcursor;
out.reachkinectdata=Kinectdata;
out.dur=[mt.dur];
out.numpeaks=numpeaks;

end % function