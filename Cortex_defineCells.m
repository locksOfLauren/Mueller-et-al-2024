function [out] = Cortex_defineCells(sd,varargin);

process_varargin(varargin);

%get region PL or OFC and corresponding firing rate
[cellName,~,avgFr,avgFR_trial,avgFR_preTrial,avgFR_baseTom,PL,OFC] = LM_Cortex_GetAllSpikes_plus(sd);
avgFr_PL = avgFr(PL==1);
avgFr_OFC = avgFr(OFC==1);

%wv is the raw (un-normalized) mean waveform of a unit

[allWaves_trunc_norm,allWaves_raw,~] = LM_GetAllWaveforms(sd);%change what wv depending on metric of interest
wv = allWaves_raw;

%define and preallocate space for desired variables

pw = NaN(length(wv),1); %peak width (pw) will require space the length of the allWaves_raw cell array, since this is referencing a cell array we have to define the dimension 
vw = NaN(size(pw)); %valley width (vw) will require space the size of pw, since this is referencing a vector we don't have to define dimension 
v2p = NaN(size(pw)); %valley to peak (v2p) will require space the size of pw, since this is referencing a vector we don't have to define dimension 

%Write a for loop to index into each variable's vector and stack values into a cell array

for iC = 1:length(wv);% For each row (waveform) in the allWaves_raw cell array call the function amw_waveWidths to calculate pw, vw, and v2p
    [pw(iC),vw(iC),~,v2p(iC)] = LM_waveWidths(0-wv{iC});%Invert the waves. Stack these values in order and put into a cell array. There's a place holder between vw and v2p because we aren't using "asy".
end

%% for PL

% average waveform properties for purpose of clustering
PL_vw= vw(PL==1);
PL_pw= pw(PL==1);
PL_v2p=v2p(PL==1);%half valley duartion
PL_avgFr = avgFr(PL==1);
PL_ratio = PL_vw./PL_pw;

PL_bad = PL_ratio> 3.4|PL_vw>0.5|PL_vw<0.05;
PL_pw(PL_bad) = NaN;
PL_vw(PL_bad) = NaN;
PL_ratio(PL_bad) = NaN;
%Cluster waveforms using pw, vw, and v2p, do individually for PL and OFC

%PL
[idx_PL] = clusterdata([PL_vw,PL_pw,PL_v2p],'Linkage','ward','Maxclust',2,'Distance','euclidean');%old 1st place

meanFr_PL = [nanmean(PL_avgFr(idx_PL==1)),nanmean(PL_avgFr(idx_PL==2))];%For each of the two clusters calculate the avg Fr

[~,lowFrInd_PL] = min(meanFr_PL ); %Of the two calculated averages, find the cluster that has the lowest meanFr value, put the number of the identified cluster into a variable named lowFrInd
[~,highFrInd_PL] = max(meanFr_PL);%find the cluster that has the highest meanFr,put the number of the identified cluster into a variable named highFrInd

%classify the cell types
WS_PL = idx_PL==lowFrInd_PL; 
HF_PL = idx_PL==highFrInd_PL;

%for purpose of examining shape
PL_waves = allWaves_trunc_norm(PL==1,:,:);%all PL waves

%get rid of weird waves in HF group and rename index, small percent of pop
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
        


%% For OFC

%define OFC average waves
OFC_vw= vw(OFC==1);
OFC_pw= pw(OFC==1);
OFC_v2p= v2p(OFC==1);
OFC_avgFr = avgFr(OFC==1);

%OFC
[idx_OFC] =clusterdata([OFC_vw,OFC_pw,OFC_v2p],'Linkage','ward','Maxclust',2,'Distance','euclidean');%1st

meanFr_OFC = [nanmean(OFC_avgFr(idx_OFC==1)),nanmean(OFC_avgFr(idx_OFC==2))];%For each of the two clusters calculate the avg Fr

%define pops based on highest FR
[~,lowFrInd_OFC] = min(meanFr_OFC ); %Of the two calculated averages, find the cluster that has the lowest meanFr value, put the number of the identified cluster into a variable named lowFrInd
[~,highFrInd_OFC] = max(meanFr_OFC);%find the cluster that has the highest meanFr,put the number of the identified cluster into a variable named highFrInd


%classify the OFC cells
WS_OFC = idx_OFC==lowFrInd_OFC; %principal OFC 
HF_OFC = idx_OFC==highFrInd_OFC;%high firing OFC

%get corresponding firing rates
WS_OFC_Fr= avgFr_OFC(WS_OFC==1);
HF_OFC_Fr = avgFr_OFC(HF_OFC==1);

%get rid of weird FR in OFC HF group and rename index, small percent of pop
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
      



%package output

out.WS_PL = WS_PL;
out.HF_PL = HF_PL;
out.uid_PL = uid_PL;
out.WS_OFC = WS_OFC;
out.HF_OFC = HF_OFC;
out.uid_OFC = uid_OFC;

