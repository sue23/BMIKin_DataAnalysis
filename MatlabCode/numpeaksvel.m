function [ numpeaks ] = numpeaksvel( Data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
InitIndx=Data.start;
StopIndx=Data.stop;
fc=30;
lfilter=29;%19;
polord=4;%8
vel = sav_golay(Data.reachcompletedata(:,2:3),lfilter,polord,1,30);

for trial=1:length(StopIndx)
% peak speed
    threshold = 0.20;
    velocita=sqrt(vel(InitIndx(trial):StopIndx(trial),1).^2+vel(InitIndx(trial):StopIndx(trial),2).^2);
    [pks,locs] = findpeaks(velocita);
    pksval = pks(pks >= threshold*max(pks));
    pksloc = locs(pks >= threshold*max(pks));
    numpeaks(trial)=length(pksval);
    
%     figure(100)
%     plot(velocita)
%     hold on
%     plot([0 length(velocita)],[threshold*max(pks) threshold*max(pks)],'r')
%     plot(pksloc,pksval,'*c')
%     keyboard
%     close figure 100
end
end

