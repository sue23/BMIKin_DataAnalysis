function [rind,sind,mt]=start_stop(xy,vel)
time=xy(:,1);
xy=xy(:,2:3);

tol = 0.1;
%  switch(thtype)
%   case 'abs',
%    ttol = tol;      %tol ? la tolleranza: i suoi valori sono scelti in base a delle regole precise
%   case 'rel',
%    ttol = (tol)*traj.pkspeed;
%   end

speed = sqrt(sum(vel.^2,2));
speed = speed(2:end);
time = time(2:end)-time(2);

% x=1:length(speed);
% figure
% plot(x,speed)

mt.speed=speed;
[pkspeed,pki]=max(speed); %determina il valore massimo e l'indice relativo

ttol = (tol)*pkspeed;
c=diff(speed);
if c(1)>0 & c(2)<0
    ind=max(find(c>0,2,'first')); % cos? non considero il pesso iniziale che parte dall'alto e scende
else
    ind=find(c>0,1,'first');
end
spd=speed(ind:end);
aind = min(find(spd>3*ttol));
rind = max(find(spd(1:aind)<ttol))+ind-1;

if isempty(rind) & ind~=1
    %         keyboard
    rind=ind-1;
elseif isempty(rind) & ind==1
    rind=ind;
end

% hold on
% try
% plot(x(rind),speed(rind),'k^','markerfacecolor',[0 1 0]);
% catch
%     keyboard
% end

% la fine del movimento corrisponde  all'istante in cui appare la
% home(target centrale) meno un secondo. Perche' nel task di reaching e'
% richiesto di restare un secondo fermo nel target
indfine = find(abs(time-(time(end)-0.5))<0.5);
sottoth=find(speed(indfine)<ttol);
if isempty(sottoth)
    [m, s_ind]=min(speed(indfine));
else
    [m, s_id]=min(speed(indfine(sottoth)));
    s_ind=sottoth(s_id);
end
try
    sind=s_ind+indfine(1)-1;
catch
    keyboard
end
if isempty(sind)| sind<rind |sind==rind
    sind =  min(find(abs(time-(time(end)-0.5))<0.01));
end
if isempty(sind)
    sind=length(spd);
end
% plot(x(sind),speed(sind),'k^','markerfacecolor',[1 0 0]);
% line([indfine(1) indfine(1)],[0 speed(pki)])
% line([indfine(end) indfine(end)],[0 speed(pki)])

% il tempo di reazione e' definito come il primo campione (quando lo stato
% e' 1 appare il target (periferico)
mt.rtime = time(rind)-time(1);
mt.dur = time(sind)-time(rind);
mt.time = time;
end


