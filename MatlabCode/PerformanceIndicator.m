function PerformanceIndicator(datadir)
%Questa funzione parte dai segnali del kinect e ricostruisce caricando la
%mappa i movimenti del cursore

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

%nella cartella datadir c'? una cartella per ogni soggetto che contiene
%tutti i dati
listsubj = dir(datadir);
listsubj = listsubj(3:length(listsubj),:);%le prime due directory non servono
soggetti={listsubj.name};
if ~isempty(find([listsubj.isdir]==0))
    soggetti=soggetti(2:end);
end
load(['mats',filesep,'Reach']) %outliers have been removed
Reach=ind;
load(['mats',filesep,'Rec']) %outliers have been removed
Rec=ind;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plotReachPerformance(Reach,soggetti,'real_reach')
close all
plotReachPerformance(Rec,soggetti,'rec_reach')
close all