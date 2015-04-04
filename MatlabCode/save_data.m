function save_data(name,varargin)

nVarToSave = length(varargin);
nNameVar = length(name);
if nVarToSave~=nNameVar
    disp('Warning')
end
for i=1:nNameVar
    ind=varargin{i};
    eval(['save(''','mats',filesep,name{i},'.mat'',''ind'');']);
end