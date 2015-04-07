function [ cursor ] = ReconstructNullSpace( sensors_vec ,A)
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


%MOVIMENTO DEL CURSORE RICOSTRUITO

% if ~isempty(find(isnan(sensors_vec)))
%     cursor = repmat([nan; nan],1,size(sensors_vec,1));
% zind0 = find(A(:,1)==0);
% zind = find(A(:,1)~=0);
% A=A(zind,:);
% else
    try 
        cursor =  (sensors_vec*(null(A')))';
%                 cursor =  rotMat*(sensors_vec*(null(A')))'.*Gain + repmat(eval(Offset)',1,size(sensors_vec,1));

%                 cursor =  rotMat*(sensors_vec*(eye(size(A))-A))'.*Gain + repmat(eval(Offset)',1,size(sensors_vec,1));

    catch
        keyboard
    end
% end

end

