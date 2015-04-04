clear all
% Construct a questdlg with three options
choice = questdlg('Quale gruppo vuoi analizzare?', ...
    '', ...
    'Controlli','Pazienti','Pazienti');

path = pwd;
d.name = {'LoadandGetData','TBodySpace','DistinCalib','DistinTask','PlotReach','PerformanceIndicator',...
    'CursorVariability','Null_CursorVariability','BodyVariability','PlotStick','PostureAnalysis','ComputeDeltaPos',...
    'MarkerIndicators','pckinect'};
d.scriptpath = [pwd,filesep,'MatlabCode',filesep];
% Handle response
switch choice
    case 'Controlli'
        d.datapath = uigetdir(pwd,'Specify Data path');
        d.datapath = [d.datapath,filesep,'Sani'];
        [script,v] = listdlg('PromptString','Select a file:',...
            'SelectionMode','single',...
            'ListString',d.name)
    case 'Pazienti'
        d.datapath = uigetdir(pwd,'Specify Data path');
%         d.datapath = ['/Volumes/HD Camilla/DataBMI_kinect_s_c',filesep,'Data',filesep,'Pazienti'];
        d.datapath = [d.datapath,filesep,'Pazienti'];
        [script,v] = listdlg('PromptString','Select a file:',...
            'SelectionMode','single',...
            'ListString',d.name)
end
switch d.name{script}
    case 'LoadandGetData'
        cd(d.scriptpath)
        LoadandGetData(d.datapath)
    case 'TBodySpace'
        cd(d.scriptpath)
        TKinectInBody2(d.datapath)
    case 'DistinCalib'
        cd(d.scriptpath)
        PlotHipDistanceinMap(d.datapath)
    case 'DistinTask'
        cd(d.scriptpath)
        PlotHipDistanceDuringReach(d.datapath)
    case 'PlotReach'
        cd(d.scriptpath)
        plotreach(d.datapath)
    case 'CursorVariability'
        cd(d.scriptpath)
        CursorVariability(d.datapath)
    case 'Null_CursorVariability'
        cd(d.scriptpath)
        Null_CursorVariability(d.datapath)
    case 'PerformanceIndicator'
        cd(d.scriptpath)
        PerformanceIndicator(d.datapath)
    case 'BodyVariability'
        cd(d.scriptpath)
        BodyVariability(d.datapath)
    case 'PostureAnalysis'
        cd(d.scriptpath)
        PostureAnalysis(d.datapath)
    case 'PlotStick'
        cd(d.scriptpath)
        PlotStick(d.datapath)
    case 'ComputeDeltaPos'
        cd(d.scriptpath)
        ComputeDeltaPos(d.datapath)
    case 'MarkerIndicators'
        cd(d.scriptpath)
        MarkerIndicators(d.datapath)
     case 'pckinect'
        cd(d.scriptpath)   
        pckinect(d.datapath)
end

