function [ startIndx,stopIndx,Data,g ] = Select_task( Data,task )
%Select_task Trovo gli indici per lavorare su un task:
%   'reachH'=reaching orizzontale
%   'reachV'=reaching verticale
%   'reachC'=reaching cross
%   'reach'=reaching all dir
%   'pongH'=pong orizzontale
%   'pongV'=pong verticale
%ed elimino i campioni in cui il controllo della BMI non era del soggetto
Data(Data(:,15)==0,:) = []; %butto tutti i dati in cui il controllo non era del soggetto

switch task
    case 'reachH'
        ex=6;
        g=1;
    case 'reachV'
        ex=7;
        g=2;
    case 'reachC'
        ex=8;
        g=3;
    case 'reach'
        ex=1;
        g=4;
    case 'pongH'
        ex=4;
        exp=1;%TO DO riconoscimento che pongo sto a f??
        g=5;
    case 'pongV'
        ex=4;
        exp=5;
        g=6;
end
        
        
startIndx = find(diff(Data(:,5)==ex)==1)+1;
stopIndx = find(diff(Data(:,5)==ex)==-1);
if isempty(stopIndx)
    stopIndx=length(Data(:,5)==ex);
end


end

