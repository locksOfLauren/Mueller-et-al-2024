function [out] = Cortex_cluster_PETHs_032424(sd,varargin);

process_varargin(varargin);
 
%get region PL or OFC and corresponding firing rate
[cellName,~,avgFr,~,~,~,PL,OFC] = LM_Cortex_GetAllSpikes_plus(sd)


cellName_PL = cellName(PL==1);
cellName_OFC = cellName(OFC==1);

avgFr_PL = avgFr(PL==1);
avgFr_OFC = avgFr(OFC==1);

[peth,x_peth] = LM_TestTaskPETHs_allSessions(sd);
peth_PL = peth(PL==1,:,:);
peth_OFC = peth(OFC==1,:,:);



[allWaves_trunc_norm,allWaves_raw,~] = LM_GetAllWaveforms(sd);%various wv metrics of interest
wv = allWaves_raw;

%define and preallocate space for desired variables

pw = NaN(length(wv),1); %peak width (pw) will require space the length of the allWaves_raw cell array, since this is referencing a cell array we have to define the dimension 
vw = NaN(size(pw)); %valley width (vw) will require space the size of pw, since this is referencing a vector we don't have to define dimension 
v2p = NaN(size(pw)); %valley to peak (v2p) will require space the size of pw, since this is referencing a vector we don't have to define dimension 

%Write a for loop to index into each variable's vector and stack values into a cell array

for iC = 1:length(wv);% For each row (waveform) in the allWaves_raw cell array call the function amw_waveWidths to calculate pw, vw, and v2p
    [pw(iC),vw(iC),~,v2p(iC)] = LM_waveWidths(0-wv{iC});%Invert the waves. Stack these values in order and put into a cell array. There's a place holder between vw and v2p because we aren't using "asy".
end


% for purpose of clustering
PL_vw= vw(PL==1);
PL_pw= pw(PL==1);
PL_v2p=v2p(PL==1);%valley-to-peak ratio
PL_avgFr = avgFr(PL==1);
PL_ratio = PL_vw./PL_pw; %erase later

PL_bad = PL_ratio> 3.4|PL_vw>0.5|PL_vw<0.05;
PL_pw(PL_bad) = NaN;
PL_vw(PL_bad) = NaN;
PL_ratio(PL_bad) = NaN;

%Cluster waveforms using pw, vw, and v2p, do individually for PL and OFC

%PL

%for the purpose of the paper if a unit was not wide spiking (ws) principle unit, it was
%called a narrow spike unit such that the unidentified (UID) and high
%firing (HF) units defined in this code were grouped together since they're
%both narrow spikes (NS) compared to WS

[idx_PL] = clusterdata([PL_vw,PL_pw,PL_v2p],'Linkage','ward','Maxclust',2,'Distance','euclidean');%clusters WS from NS, took closer look at NS population below imcluding HF and UID not necessary for paper

meanFr_PL = [nanmean(PL_avgFr(idx_PL==1)),nanmean(PL_avgFr(idx_PL==2))];%For each of the two clusters calculate the avg Fr

[~,lowFrInd_PL] = min(meanFr_PL ); %Of the two calculated averages, find the cluster that has the lowest meanFr value, put the number of the identified cluster into a variable named lowFrInd
[~,highFrInd_PL] = max(meanFr_PL);%find the cluster that has the highest meanFr,put the number of the identified cluster into a variable named highFrInd

%classify the cell types
WS_PL = idx_PL==lowFrInd_PL;%WS
HF_PL = idx_PL==highFrInd_PL;%NS, later to be subdivided into Highfiring NS and unidentified NS

%%


%for purpose of examining shape
PL_waves = allWaves_trunc_norm(PL==1,:,:);%all PL waves


 
for i = 1:length(HF_PL);
if HF_PL(i) == 1 & PL_waves(i,1) < 0.535;
HF_PL(i)=0;
end
end

for i = 1:length(WS_PL);
if WS_PL(i) == 1 & PL_avgFr(i,1) > 10 ;
WS_PL(i)=0;
end
end

uid_PL = zeros(length(HF_PL),1)
for i = 1:length(HF_PL);
    if HF_PL(i) == 1 & PL_avgFr(i,1) < 10 ;
        uid_PL(i)=1;
    end
end
    
for i = 1:length(HF_PL);
    if HF_PL(i) == 1 & PL_avgFr(i,1) < 10 ;
       HF_PL(i)=0;
    end
end
        
%get corresponding firing rates
WS_PL_Fr= avgFr_PL(WS_PL==1);
uid_PL_Fr = avgFr_PL(uid_PL==1);%sub types of NS
HF_PL_Fr = avgFr_PL(HF_PL==1);%sub types of NS

PL_HF_cellName = cellName_PL(HF_PL==1);
PL_uid_cellName = cellName_PL(uid_PL==1);
PL_WS_cellName = cellName_PL(WS_PL==1);

%% get corresponding peths
peth_PL_WS = peth_PL(WS_PL==1,:,:);
peth_PL_HF = peth_PL(HF_PL==1,:,:);
peth_PL_uid = peth_PL(uid_PL==1,:,:);

%%
%define OFC average waves
OFC_vw= vw(OFC==1);
OFC_pw= pw(OFC==1);
OFC_v2p= v2p(OFC==1);
OFC_avgFr = avgFr(OFC==1);
OFC_ww = OFC_vw + OFC_pw;
OFC_ratio = OFC_vw./OFC_pw;

%OFC

%for the purpose of the paper if a unit was not wide spiking (ws) principle unit, it was
%called a narrow spike unit such that the unidentified (UID) and high
%firing (HF) units defined in this code were grouped together since they're
%both narrow spikes (NS)

[idx_OFC] =clusterdata([OFC_vw,OFC_pw,OFC_v2p],'Linkage','ward','Maxclust',2,'Distance','euclidean');%clusters WS from NS, took closer look at NS population below imcluding HF and UID not necessary for paper

meanFr_OFC = [nanmean(OFC_avgFr(idx_OFC==1)),nanmean(OFC_avgFr(idx_OFC==2))];%For each of the two clusters calculate the avg Fr
[~,lowFrInd_OFC] = min(meanFr_OFC ); %Of the two calculated averages, find the cluster that has the lowest meanFr value, put the number of the identified cluster into a variable named lowFrInd
[~,highFrInd_OFC] = max(meanFr_OFC);%find the cluster that has the highest meanFr,put the number of the identified cluster into a variable named highFrInd


%classify the OFC cells
WS_OFC = idx_OFC==lowFrInd_OFC; %principal OFC 
HF_OFC = idx_OFC==highFrInd_OFC;%narrow spike OFC


%%
for i = 1:length(WS_OFC);
if WS_OFC(i) == 1 & OFC_avgFr(i,1) > 14 ;
WS_OFC(i)=0;
end
end

for i = 1:length(WS_OFC);
if WS_OFC(i) == 1 & OFC_v2p(i,1) < 0.4 & OFC_avgFr(i,1) > 6 ;
WS_OFC(i)=0;
end
end

uid_OFC = zeros(length(HF_OFC),1)
for i = 1:length(HF_OFC);
    if HF_OFC(i) == 1 & OFC_avgFr(i,1) < 10 ;
        uid_OFC(i)=1;
    end
end
    
for i = 1:length(HF_OFC);
    if HF_OFC(i) == 1 & OFC_avgFr(i,1) < 10 ;
       HF_OFC(i)=0;
    end
end

%get corresponding firing rates
WS_OFC_Fr= avgFr_OFC(WS_OFC==1);
uid_OFC_Fr = avgFr_OFC(uid_OFC==1);%sub type of NS
HF_OFC_Fr = avgFr_OFC(HF_OFC==1);%sub type of NS

%%
OFC_HF_cellName = cellName_OFC(HF_OFC==1);
OFC_uid_cellName = cellName_OFC(uid_OFC==1);
OFC_WS_cellName = cellName_OFC(WS_OFC==1);

%% get corresponding peths
peth_OFC_WS = peth_OFC(WS_OFC==1,:,:);
peth_OFC_HF = peth_OFC(HF_OFC==1,:,:);%subtype of NS
peth_OFC_uid = peth_OFC(uid_OFC==1,:,:);%subtype of NS

%for the purpose of the paper if a unit was not wide spiking (ws)t, it was
%called a narrow spike unit such that the unidentified (UID) and high
%firing (HF) units defined in this code were grouped together since they're
%both narrow spikes (NS)

%package output

 out.WS_PL = WS_PL;
out.WS_PL_Fr = WS_PL_Fr;
out.uid_PL = uid_PL_Fr;
out.uid_PL_Fr = uid_PL_Fr;
out.HF_PL = HF_PL;
out.HF_PL_Fr = HF_PL_Fr;



out.WS_OFC = WS_OFC;
out.WS_OFC_Fr = WS_OFC_Fr;
out.HF_OFC = HF_OFC;
out.HF_OFC_Fr = HF_OFC_Fr;
out.uid_OFC = uid_OFC;
out.uid_OFC_Fr = uid_OFC_Fr;


%% get corresponding peths
out.x_peth = x_peth;
out.peth_PL_WS  = peth_PL_WS;
out.peth_PL_HF=peth_PL_HF;
out.peth_PL_uid = peth_PL_uid;

out.peth_OFC_WS  = peth_OFC_WS;
out.peth_OFC_HF=peth_OFC_HF;
out.peth_OFC_uid = peth_OFC_uid;

out.OFC_HF_cellName = OFC_HF_cellName;
out.OFC_uid_cellName = OFC_uid_cellName;
out.OFC_WS_cellName = OFC_WS_cellName;


out.PL_HF_cellName = PL_HF_cellName;
out.PL_uid_cellName = PL_uid_cellName;
out.PL_WS_cellName = PL_WS_cellName;
