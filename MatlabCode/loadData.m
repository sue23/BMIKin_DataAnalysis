function[Mappe,Custom,Data]=loadData(soggetti,subj,sess,datadir)
A=nan;
Offset=nan;
Gain=nan;
Rotation=nan;
Kin_offset=nan;
A_v=nan;
Offset_v=nan;
Gain_v=nan;
Rotation_v=nan;
Kin_offset_v=nan;
A_o=nan;
Offset_o=nan;
Gain_o=nan;
Rotation_o=nan;
Kin_offset_o=nan;
Data_o=nan;
Data_v=nan;
Data=nan;
APosture=nan;
A_vPosture=nan;
A_oPosture=nan;
if ((strcmp(soggetti{subj},'gr')  & sess==2) | (strcmp(soggetti{subj},'cv')  & sess==1))
    % % % %            Trgt = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'vert',filesep,'TargSeq7','.mat']); %1:8 posizione d ogni numero cm all inizio
    %questi soggetti hanno fatto gli esercizi con mappe diverse
    A1_v = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'vert',filesep,'CalibDatakinectMap.mat']);
    Kin_offset_v=load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'vert',filesep,'offsetCalibDataMap.mat']);
    A1_custom_v = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'vert',filesep,'CustomData.mat']);
    Data_v = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'vert',filesep,'Data.mat']);
    Data_v = (Data_v.Data)';%solo matrice dei dati
    A_v = A1_v.AMap;
    A_vPosture = A1_v.CalibDataMap;
    Offset_v = A1_custom_v.Offset;
    Gain_v = str2double(A1_custom_v.Gain);
    Rotation_v = str2double(A1_custom_v.Rot);
    
    A1_o = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'oriz',filesep,'CalibDatakinectMap.mat']);
    Kin_offset_o=load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'oriz',filesep,'offsetCalibDataMap.mat']);
    A1_custom_o = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'oriz',filesep,'CustomData.mat']);
    Data_o = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'oriz',filesep,'Data.mat']);
    Data_o = (Data_o.Data)';%solo matrice dei dati
    A_o = A1_o.AMap;
    A_oPosture = A1_o.CalibDataMap;
    Offset_o = A1_custom_o.Offset;
    Gain_o = str2double(A1_custom_o.Gain);
    Rotation_o = str2double(A1_custom_o.Rot);
    
else
    % % % % Trgt = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'TargSeq',num2str(targetseq(seq)),'.mat']); %1:8 posizione d ogni numero cm all inizio
    A1 = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'CalibDatakinectMap.mat']);
    Kin_offset=load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'offsetCalibDataMap.mat']);
    A1_custom = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'CustomData.mat']);
    Data = load([datadir,filesep,soggetti{subj},filesep,num2str(sess),filesep,'Data.mat']);
    Data = (Data.Data)';%solo matrice dei dati
    A = A1.AMap;
    APosture = A1.CalibDataMap;
    Offset = A1_custom.Offset;
    Gain = str2double(A1_custom.Gain);
    if strcmp(soggetti{subj},'cv') & sess==3 %|| sess==4 %???? quale soggetto????
        Gain = 1.5;
    end
    if strcmp(soggetti{subj},'cv') & sess==4
        Gain = 2;
    end
    Rotation = str2double(A1_custom.Rot);
end
Mappe.A=A;
Mappe.A_v=A_v;
Mappe.A_o=A_o;
Mappe.APosture=APosture;
Mappe.A_vPosture=A_vPosture;
Mappe.A_oPosture=A_oPosture;

Custom.Offset=Offset;
Custom.Gain=Gain;
Custom.Rotation=Rotation;
Custom.KinOffset=Kin_offset;

Custom.Offset_v=Offset_v;
Custom.Gain_v=Gain_v;
Custom.Rotation_v=Rotation_v;
Custom.KinOffset_v=Kin_offset_v;

Custom.Offset_o=Offset_o;
Custom.Gain_o=Gain_o;
Custom.Rotation_o=Rotation_o;
Custom.KinOffset_o=Kin_offset_o;

Data.Data=Data;
Data.Data_v=Data_v;
Data.Data_o=Data_o;