function [out]=computereachmetrics(Data,g,varargin)
%computereachmetrics Time_state,CursorXY,Target
%   Accepts cursor position and time as input and returns the following metrics:
%   -Euclidean Error @ 1s
%   -Movement Time to capture Target
%   -Path length (ratio of distance traveled/shortest distance)
%   -Aspect ratio (ratio of max perp dist/shortest distance)
%   tempo per vedere quanto ci mette and andare a quello periferico
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
for ii=1:8
    alfa = 2*pi*ii/8;
    Targets(1:2,ii) = initial + dist*[cos(alfa);sin(alfa)];
end
switch g
    case 1
        Target=Targets(:,[4,8])';
    case 2
        Target=Targets(:,[2,6])';
    case 3
        Target=Targets(:,[2 4 6 8])';
    case 4
        Target=Targets';
end
for trial = 1:length(Data.reachcompletedata)
       
        if length(varargin)==1
            Data.reachcompletedata{trial}(:,2:3) = varargin{1}{trial}';
        end
        Time{trial}=Data.reachcompletedata{trial}(:,1);
        Time{trial} = Time{trial}-Time{trial}(1); %Make the first time point t=0
        
        CursorXY{trial}=Data.reachcompletedata{trial}(:,2:3);
        % calcolo della distanza finale
        
        StLineDist(trial) =sqrt(sum(diff(CursorXY{trial}([1 end],:)).^2));% norm(CursorXY(end,:)-CursorXY(1,:));

        %calcolo del percorso  fatto
        
        PathLength(trial) = sum(sqrt(sum(diff(CursorXY{trial}).^2,2)));%norm(CursorXY(i+1,:)-CursorXY(i,:));
        
        
        % normalizzo il percorso del mouse con quello ottimo
        LinIndx(trial) = PathLength(trial)/StLineDist(trial)-1;
        
        
        t1 = find(Time{trial}>=1,1);%First time sample when crossing 1s
        %vedo il tempo che ci mette ad arrivare al target perferico dopo 1,1
        %diventa rosso e calcolo la distanza dal target dopo 1 s con eucerror
        if(isempty(t1)) %If MT<1s, then use the final point
            t1 = length(Time{trial});
        end
        Cursor1s{trial} = CursorXY{trial}(t1,:);
        tgt_seq(trial) = (sqrt(sum((CursorXY{trial}(end,:)-Target(1,:)).^2,2))<sqrt(sum((CursorXY{trial}(end,:)-Target(2,:)).^2,2)))+1; %verifica con video!!!!!!
        EucError_1s(trial) = sqrt(sum((Cursor1s{trial}-Target(tgt_seq(trial),:)).^2,2));%norm(Cursor1s{trial}-Target); %Euclidean Error
        
        
        
        %For Aspect ratio, rotate the axes so that the movement is along the "x-axis".
        %Then aspect ratio can be computed by deviations along y-axis
        theta = atan2(CursorXY{trial}(end,2)-CursorXY{trial}(2,2),CursorXY{trial}(end,1)-CursorXY{trial}(1,1));
        theta = -theta; %Rotate back
        R = [cos(theta) sin(theta);-sin(theta) cos(theta)];
        newXY = CursorXY{trial}*R;
        %Center the first point to be the origin
        newXY(:,1) = newXY(:,1)-newXY(1,1);newXY(:,2) = newXY(:,2)-newXY(1,2);
        maxperpdist = max(abs(newXY(:,2)));
        %rapporto dalla distanca vcon il percorso ottimale
        AspectRatio(trial) = maxperpdist/StLineDist(trial);
        % figure;subplot(2,1,1),plot(CursorXY(:,1),CursorXY(:,2));axis equal
        % subplot(2,1,2),plot(newXY(:,1),newXY(:,2));axis equal
        
        % Calculate Dimensionless Jerk
        [DimJerk(trial)] = m3_P_DimJerk(Time{trial},CursorXY{trial});
        
        % % Calculate correlation between minimum Jerk model and reach
        % [MJpos, MJvel] = m3_P_MinJerkCorrV2(Time,CursorXY,Target);

end

out.StLineDist=StLineDist; out.EucError_1s=EucError_1s;out.PathLength=PathLength;out.AspectRatio=AspectRatio;out.DimJerk=DimJerk;out.LinIndx=LinIndx;





