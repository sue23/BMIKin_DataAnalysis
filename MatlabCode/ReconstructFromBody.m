function [ cursor ] = ReconstructFromBody( sensors_vec ,A,Rotation,Gain,Offset)
%ReconstructFromBody ricostruisce i movimenti del cursore dai segnali del
%body e plottiamo le coordinate ricostruite su quelle originali
%   INPUT:
%   sensors_vec ? il vettore con le coordinate dei sensori
%   A: mappa; Rotation: rotatione; Gain: guadagno; Offset: offset
%   xy sono le coordinate reali
%   g flag del task
%   OUTPUT:
%   cursor coordinate xy del cursore ricostruito

%ricostruisco e plotto movimento in 2-D

rotMat = [cosd(Rotation) -sind(Rotation); sind(Rotation) cosd(Rotation)];

%MOVIMENTO DEL CURSORE RICOSTRUITO

% if ~isempty(find(isnan(sensors_vec)))
%     cursor = repmat([nan; nan],1,size(sensors_vec,1));
% else
    try 
        cursor =  rotMat*(sensors_vec*A)'.*Gain + repmat(eval(Offset)',1,size(sensors_vec,1));
    catch
        keyboard
    end
% end

end

