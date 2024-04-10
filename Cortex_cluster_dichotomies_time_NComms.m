function [out] = Cortex_cluster_dichotomies_time_NComms(sd,varargin);
%USED
process_varargin(varargin);

%get region PL or OFC and corresponding firing rate
[cellName,~,avgFr,~,~,~,PL,OFC] = LM_Cortex_GetAllSpikes_plus(sd)
[~, ~, ~, Cell_sessions,~,sd_sessions,ID_Cell]= sessions_info(sd);%info per rat corresponding with cellResponses

cellName_PL=cellName(PL==1);
cellName_OFC=cellName(OFC==1);

Cell_sessions_PL = Cell_sessions(PL==1);
Cell_sessions_OFC = Cell_sessions(OFC==1);

sd_sessions_PL = sd_sessions(PL==1);
sd_sessions_OFC = sd_sessions(OFC==1);

ID_Cell_PL=ID_Cell(PL==1);
ID_Cell_OFC = ID_Cell(OFC==1);


avgFr_PL = avgFr(PL==1);
avgFr_OFC = avgFr(OFC==1);

[cellResponses] = LM_GenerateDichotomyVectors_time_NComms(sd);
%% 1- 35 PL
cellResponses_PL_di_1 = cellResponses.di_1(PL==1,:,:);
cellResponses_PL_di_2 = cellResponses.di_2(PL==1,:,:);
cellResponses_PL_di_3 = cellResponses.di_3(PL==1,:,:);
cellResponses_PL_di_4 = cellResponses.di_4(PL==1,:,:);
cellResponses_PL_di_5 = cellResponses.di_5(PL==1,:,:);
cellResponses_PL_di_6 = cellResponses.di_6(PL==1,:,:);
cellResponses_PL_di_7 = cellResponses.di_7(PL==1,:,:);
cellResponses_PL_di_8 = cellResponses.di_8(PL==1,:,:);
cellResponses_PL_di_9 = cellResponses.di_9(PL==1,:,:);
cellResponses_PL_di_10 = cellResponses.di_10(PL==1,:,:);
cellResponses_PL_di_11 = cellResponses.di_11(PL==1,:,:);
cellResponses_PL_di_12 = cellResponses.di_12(PL==1,:,:);
cellResponses_PL_di_13 = cellResponses.di_13(PL==1,:,:);
cellResponses_PL_di_14 = cellResponses.di_14(PL==1,:,:);
cellResponses_PL_di_15 = cellResponses.di_15(PL==1,:,:);
cellResponses_PL_di_16 = cellResponses.di_16(PL==1,:,:);
cellResponses_PL_di_17 = cellResponses.di_17(PL==1,:,:);
cellResponses_PL_di_18 = cellResponses.di_18(PL==1,:,:);
cellResponses_PL_di_19 = cellResponses.di_19(PL==1,:,:);
cellResponses_PL_di_20 = cellResponses.di_20(PL==1,:,:);
cellResponses_PL_di_21 = cellResponses.di_21(PL==1,:,:);
cellResponses_PL_di_22 = cellResponses.di_22(PL==1,:,:);
cellResponses_PL_di_23 = cellResponses.di_23(PL==1,:,:);
cellResponses_PL_di_24 = cellResponses.di_24(PL==1,:,:);
cellResponses_PL_di_25 = cellResponses.di_25(PL==1,:,:);
cellResponses_PL_di_26 = cellResponses.di_26(PL==1,:,:);
cellResponses_PL_di_27 = cellResponses.di_27(PL==1,:,:);
cellResponses_PL_di_28 = cellResponses.di_28(PL==1,:,:);
cellResponses_PL_di_29 = cellResponses.di_29(PL==1,:,:);
cellResponses_PL_di_30 = cellResponses.di_30(PL==1,:,:);
cellResponses_PL_di_31 = cellResponses.di_31(PL==1,:,:);
cellResponses_PL_di_32 = cellResponses.di_32(PL==1,:,:);
cellResponses_PL_di_33 = cellResponses.di_33(PL==1,:,:);
cellResponses_PL_di_34 = cellResponses.di_34(PL==1,:,:);
cellResponses_PL_di_35 = cellResponses.di_35(PL==1,:,:);

%1-35 OFC
cellResponses_OFC_di_1 = cellResponses.di_1(OFC==1,:,:);
cellResponses_OFC_di_2 = cellResponses.di_2(OFC==1,:,:);
cellResponses_OFC_di_3 = cellResponses.di_3(OFC==1,:,:);
cellResponses_OFC_di_4 = cellResponses.di_4(OFC==1,:,:);
cellResponses_OFC_di_5 = cellResponses.di_5(OFC==1,:,:);
cellResponses_OFC_di_6 = cellResponses.di_6(OFC==1,:,:);
cellResponses_OFC_di_7 = cellResponses.di_7(OFC==1,:,:);
cellResponses_OFC_di_8 = cellResponses.di_8(OFC==1,:,:);
cellResponses_OFC_di_9 = cellResponses.di_9(OFC==1,:,:);
cellResponses_OFC_di_10 = cellResponses.di_10(OFC==1,:,:);
cellResponses_OFC_di_11 = cellResponses.di_11(OFC==1,:,:);
cellResponses_OFC_di_12 = cellResponses.di_12(OFC==1,:,:);
cellResponses_OFC_di_13 = cellResponses.di_13(OFC==1,:,:);
cellResponses_OFC_di_14 = cellResponses.di_14(OFC==1,:,:);
cellResponses_OFC_di_15 = cellResponses.di_15(OFC==1,:,:);
cellResponses_OFC_di_16 = cellResponses.di_16(OFC==1,:,:);
cellResponses_OFC_di_17 = cellResponses.di_17(OFC==1,:,:);
cellResponses_OFC_di_18 = cellResponses.di_18(OFC==1,:,:);
cellResponses_OFC_di_19 = cellResponses.di_19(OFC==1,:,:);
cellResponses_OFC_di_20 = cellResponses.di_20(OFC==1,:,:);
cellResponses_OFC_di_21 = cellResponses.di_21(OFC==1,:,:);
cellResponses_OFC_di_22 = cellResponses.di_22(OFC==1,:,:);
cellResponses_OFC_di_23 = cellResponses.di_23(OFC==1,:,:);
cellResponses_OFC_di_24 = cellResponses.di_24(OFC==1,:,:);
cellResponses_OFC_di_25 = cellResponses.di_25(OFC==1,:,:);
cellResponses_OFC_di_26 = cellResponses.di_26(OFC==1,:,:);
cellResponses_OFC_di_27 = cellResponses.di_27(OFC==1,:,:);
cellResponses_OFC_di_28 = cellResponses.di_28(OFC==1,:,:);
cellResponses_OFC_di_29 = cellResponses.di_29(OFC==1,:,:);
cellResponses_OFC_di_30 = cellResponses.di_30(OFC==1,:,:);
cellResponses_OFC_di_31 = cellResponses.di_31(OFC==1,:,:);
cellResponses_OFC_di_32 = cellResponses.di_32(OFC==1,:,:);
cellResponses_OFC_di_33 = cellResponses.di_33(OFC==1,:,:);
cellResponses_OFC_di_34 = cellResponses.di_34(OFC==1,:,:);
cellResponses_OFC_di_35 = cellResponses.di_35(OFC==1,:,:);

%%


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
[idx_PL] = clusterdata([PL_vw,PL_pw,PL_v2p],'Linkage','ward','Maxclust',2,'Distance','euclidean');

meanFr_PL = [nanmean(PL_avgFr(idx_PL==1)),nanmean(PL_avgFr(idx_PL==2))];%For each of the two clusters calculate the avg Fr

[~,lowFrInd_PL] = min(meanFr_PL ); %Of the two calculated averages, find the cluster that has the lowest meanFr value, put the number of the identified cluster into a variable named lowFrInd
[~,highFrInd_PL] = max(meanFr_PL);%find the cluster that has the highest meanFr,put the number of the identified cluster into a variable named highFrInd

%classify the cell types
WS_PL = idx_PL==lowFrInd_PL; %WS
HF_PL = idx_PL==highFrInd_PL;%NS


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
        
%get corresponding firing rates
WS_PL_Fr= avgFr_PL(WS_PL==1);
uid_PL_Fr = avgFr_PL(uid_PL==1);
HF_PL_Fr = avgFr_PL(HF_PL==1);

PL_HF_cellName = cellName_PL(HF_PL==1);
PL_uid_cellName = cellName_PL(uid_PL==1);
PL_WS_cellName = cellName_PL(WS_PL==1);

%% separate PL by putative WS cells

% PL WS

cellResponses_PL_di_1_WS = cellResponses_PL_di_1(WS_PL==1,:,:);
cellResponses_PL_di_2_WS = cellResponses_PL_di_2(WS_PL==1,:,:);
cellResponses_PL_di_3_WS = cellResponses_PL_di_3(WS_PL==1,:,:);
cellResponses_PL_di_4_WS = cellResponses_PL_di_4(WS_PL==1,:,:);
cellResponses_PL_di_5_WS = cellResponses_PL_di_5(WS_PL==1,:,:);
cellResponses_PL_di_6_WS = cellResponses_PL_di_6(WS_PL==1,:,:);
cellResponses_PL_di_7_WS = cellResponses_PL_di_7(WS_PL==1,:,:);
cellResponses_PL_di_8_WS = cellResponses_PL_di_8(WS_PL==1,:,:);
cellResponses_PL_di_9_WS = cellResponses_PL_di_9(WS_PL==1,:,:);
cellResponses_PL_di_10_WS = cellResponses_PL_di_10(WS_PL==1,:,:);
cellResponses_PL_di_11_WS = cellResponses_PL_di_11(WS_PL==1,:,:);
cellResponses_PL_di_12_WS = cellResponses_PL_di_12(WS_PL==1,:,:);
cellResponses_PL_di_13_WS = cellResponses_PL_di_13(WS_PL==1,:,:);
cellResponses_PL_di_14_WS = cellResponses_PL_di_14(WS_PL==1,:,:);
cellResponses_PL_di_15_WS = cellResponses_PL_di_15(WS_PL==1,:,:);
cellResponses_PL_di_16_WS = cellResponses_PL_di_16(WS_PL==1,:,:);
cellResponses_PL_di_17_WS = cellResponses_PL_di_17(WS_PL==1,:,:);
cellResponses_PL_di_18_WS = cellResponses_PL_di_18(WS_PL==1,:,:);
cellResponses_PL_di_19_WS = cellResponses_PL_di_19(WS_PL==1,:,:);
cellResponses_PL_di_20_WS = cellResponses_PL_di_20(WS_PL==1,:,:);
cellResponses_PL_di_21_WS = cellResponses_PL_di_21(WS_PL==1,:,:);
cellResponses_PL_di_22_WS = cellResponses_PL_di_22(WS_PL==1,:,:);
cellResponses_PL_di_23_WS = cellResponses_PL_di_23(WS_PL==1,:,:);
cellResponses_PL_di_24_WS = cellResponses_PL_di_24(WS_PL==1,:,:);
cellResponses_PL_di_25_WS = cellResponses_PL_di_25(WS_PL==1,:,:);
cellResponses_PL_di_26_WS = cellResponses_PL_di_26(WS_PL==1,:,:);
cellResponses_PL_di_27_WS = cellResponses_PL_di_27(WS_PL==1,:,:);
cellResponses_PL_di_28_WS = cellResponses_PL_di_28(WS_PL==1,:,:);
cellResponses_PL_di_29_WS = cellResponses_PL_di_29(WS_PL==1,:,:);
cellResponses_PL_di_30_WS = cellResponses_PL_di_30(WS_PL==1,:,:);
cellResponses_PL_di_31_WS = cellResponses_PL_di_31(WS_PL==1,:,:);
cellResponses_PL_di_32_WS = cellResponses_PL_di_32(WS_PL==1,:,:);
cellResponses_PL_di_33_WS = cellResponses_PL_di_33(WS_PL==1,:,:);
cellResponses_PL_di_34_WS = cellResponses_PL_di_34(WS_PL==1,:,:);
cellResponses_PL_di_35_WS = cellResponses_PL_di_35(WS_PL==1,:,:);

%%


Cell_sessions_PL_HF = Cell_sessions_PL(HF_PL==1,:,:);
Cell_sessions_PL_uid = Cell_sessions_PL(uid_PL==1,:,:);
Cell_sessions_PL_WS = Cell_sessions_PL(WS_PL==1,:,:);

sd_sessions_PL_HF = sd_sessions_PL(HF_PL==1,:,:);
sd_sessions_PL_uid = sd_sessions_PL(uid_PL==1,:,:);
sd_sessions_PL_WS = sd_sessions_PL(WS_PL==1,:,:);

ID_Cell_PL_HF = ID_Cell_PL(HF_PL==1,:,:);
ID_Cell_PL_uid = ID_Cell_PL(uid_PL==1,:,:);
ID_Cell_PL_WS = ID_Cell_PL(WS_PL==1,:,:);

%%
%define OFC average waves
OFC_vw= vw(OFC==1);
OFC_pw= pw(OFC==1);
OFC_v2p= v2p(OFC==1);
OFC_avgFr = avgFr(OFC==1);
OFC_ww = OFC_vw + OFC_pw;%erase later
OFC_ratio = OFC_vw./OFC_pw; %erase later

%OFC
[idx_OFC] =clusterdata([OFC_vw,OFC_pw,OFC_v2p],'Linkage','ward','Maxclust',2,'Distance','euclidean');%1st

meanFr_OFC = [nanmean(OFC_avgFr(idx_OFC==1)),nanmean(OFC_avgFr(idx_OFC==2))];%For each of the two clusters calculate the avg Fr
[~,lowFrInd_OFC] = min(meanFr_OFC ); %Of the two calculated averages, find the cluster that has the lowest meanFr value, put the number of the identified cluster into a variable named lowFrInd
[~,highFrInd_OFC] = max(meanFr_OFC);%find the cluster that has the highest meanFr,put the number of the identified cluster into a variable named highFrInd


%classify the OFC cells
WS_OFC = idx_OFC==lowFrInd_OFC; %ws OFC 
HF_OFC = idx_OFC==highFrInd_OFC;%ns OFC

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

%get corresponding firing rates
WS_OFC_Fr= avgFr_OFC(WS_OFC==1);
uid_OFC_Fr = avgFr_OFC(uid_OFC==1);
HF_OFC_Fr = avgFr_OFC(HF_OFC==1);

%%
OFC_HF_cellName = cellName_OFC(HF_OFC==1);
OFC_uid_cellName = cellName_OFC(uid_OFC==1);
OFC_WS_cellName = cellName_OFC(WS_OFC==1);

%% OFC
%1-35 OFC
cellResponses_OFC_di_1_WS = cellResponses_OFC_di_1(WS_OFC==1,:,:);
cellResponses_OFC_di_2_WS = cellResponses_OFC_di_2(WS_OFC==1,:,:);
cellResponses_OFC_di_3_WS = cellResponses_OFC_di_3(WS_OFC==1,:,:);
cellResponses_OFC_di_4_WS = cellResponses_OFC_di_4(WS_OFC==1,:,:);
cellResponses_OFC_di_5_WS = cellResponses_OFC_di_5(WS_OFC==1,:,:);
cellResponses_OFC_di_6_WS = cellResponses_OFC_di_6(WS_OFC==1,:,:);
cellResponses_OFC_di_7_WS = cellResponses_OFC_di_7(WS_OFC==1,:,:);
cellResponses_OFC_di_8_WS = cellResponses_OFC_di_8(WS_OFC==1,:,:);
cellResponses_OFC_di_9_WS = cellResponses_OFC_di_9(WS_OFC==1,:,:);
cellResponses_OFC_di_10_WS = cellResponses_OFC_di_10(WS_OFC==1,:,:);
cellResponses_OFC_di_11_WS = cellResponses_OFC_di_11(WS_OFC==1,:,:);
cellResponses_OFC_di_12_WS = cellResponses_OFC_di_12(WS_OFC==1,:,:);
cellResponses_OFC_di_13_WS = cellResponses_OFC_di_13(WS_OFC==1,:,:);
cellResponses_OFC_di_14_WS = cellResponses_OFC_di_14(WS_OFC==1,:,:);
cellResponses_OFC_di_15_WS = cellResponses_OFC_di_15(WS_OFC==1,:,:);
cellResponses_OFC_di_16_WS = cellResponses_OFC_di_16(WS_OFC==1,:,:);
cellResponses_OFC_di_17_WS = cellResponses_OFC_di_17(WS_OFC==1,:,:);
cellResponses_OFC_di_18_WS = cellResponses_OFC_di_18(WS_OFC==1,:,:);
cellResponses_OFC_di_19_WS = cellResponses_OFC_di_19(WS_OFC==1,:,:);
cellResponses_OFC_di_20_WS = cellResponses_OFC_di_20(WS_OFC==1,:,:);
cellResponses_OFC_di_21_WS = cellResponses_OFC_di_21(WS_OFC==1,:,:);
cellResponses_OFC_di_22_WS = cellResponses_OFC_di_22(WS_OFC==1,:,:);
cellResponses_OFC_di_23_WS = cellResponses_OFC_di_23(WS_OFC==1,:,:);
cellResponses_OFC_di_24_WS = cellResponses_OFC_di_24(WS_OFC==1,:,:);
cellResponses_OFC_di_25_WS = cellResponses_OFC_di_25(WS_OFC==1,:,:);
cellResponses_OFC_di_26_WS = cellResponses_OFC_di_26(WS_OFC==1,:,:);
cellResponses_OFC_di_27_WS = cellResponses_OFC_di_27(WS_OFC==1,:,:);
cellResponses_OFC_di_28_WS = cellResponses_OFC_di_28(WS_OFC==1,:,:);
cellResponses_OFC_di_29_WS = cellResponses_OFC_di_29(WS_OFC==1,:,:);
cellResponses_OFC_di_30_WS = cellResponses_OFC_di_30(WS_OFC==1,:,:);
cellResponses_OFC_di_31_WS = cellResponses_OFC_di_31(WS_OFC==1,:,:);
cellResponses_OFC_di_32_WS = cellResponses_OFC_di_32(WS_OFC==1,:,:);
cellResponses_OFC_di_33_WS = cellResponses_OFC_di_33(WS_OFC==1,:,:);
cellResponses_OFC_di_34_WS = cellResponses_OFC_di_34(WS_OFC==1,:,:);
cellResponses_OFC_di_35_WS = cellResponses_OFC_di_35(WS_OFC==1,:,:);

%%
Cell_sessions_OFC_HF = Cell_sessions_OFC(HF_OFC==1,:,:);
Cell_sessions_OFC_uid = Cell_sessions_OFC(uid_OFC==1,:,:);
Cell_sessions_OFC_WS = Cell_sessions_OFC(WS_OFC==1,:,:);

sd_sessions_OFC_HF = sd_sessions_OFC(HF_OFC==1,:,:);
sd_sessions_OFC_uid = sd_sessions_OFC(uid_OFC==1,:,:);
sd_sessions_OFC_WS = sd_sessions_OFC(WS_OFC==1,:,:);

ID_Cell_OFC_HF = ID_Cell_OFC(HF_OFC==1,:,:);
ID_Cell_OFC_uid = ID_Cell_OFC(uid_OFC==1,:,:);
ID_Cell_OFC_WS = ID_Cell_OFC(WS_OFC==1,:,:);

%%
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


out.OFC_HF_cellName = OFC_HF_cellName;
out.OFC_uid_cellName = OFC_uid_cellName;
out.OFC_WS_cellName = OFC_WS_cellName;


out.PL_HF_cellName = PL_HF_cellName;
out.PL_uid_cellName = PL_uid_cellName;
out.PL_WS_cellName = PL_WS_cellName;


%% package dichotomies
out.PL_dichotomies.cellResponses_PL_di_1_WS = cellResponses_PL_di_1_WS;
out.PL_dichotomies.cellResponses_PL_di_2_WS = cellResponses_PL_di_2_WS;
out.PL_dichotomies.cellResponses_PL_di_3_WS = cellResponses_PL_di_3_WS;
out.PL_dichotomies.cellResponses_PL_di_4_WS = cellResponses_PL_di_4_WS;
out.PL_dichotomies.cellResponses_PL_di_5_WS = cellResponses_PL_di_5_WS;
out.PL_dichotomies.cellResponses_PL_di_6_WS = cellResponses_PL_di_6_WS;
out.PL_dichotomies.cellResponses_PL_di_7_WS = cellResponses_PL_di_7_WS;
out.PL_dichotomies.cellResponses_PL_di_8_WS = cellResponses_PL_di_8_WS;
out.PL_dichotomies.cellResponses_PL_di_9_WS = cellResponses_PL_di_9_WS;
out.PL_dichotomies.cellResponses_PL_di_10_WS = cellResponses_PL_di_10_WS;
out.PL_dichotomies.cellResponses_PL_di_11_WS = cellResponses_PL_di_11_WS;
out.PL_dichotomies.cellResponses_PL_di_12_WS = cellResponses_PL_di_12_WS;
out.PL_dichotomies.cellResponses_PL_di_13_WS = cellResponses_PL_di_13_WS;
out.PL_dichotomies.cellResponses_PL_di_14_WS = cellResponses_PL_di_14_WS;
out.PL_dichotomies.cellResponses_PL_di_15_WS = cellResponses_PL_di_15_WS;
out.PL_dichotomies.cellResponses_PL_di_16_WS = cellResponses_PL_di_16_WS;
out.PL_dichotomies.cellResponses_PL_di_17_WS = cellResponses_PL_di_17_WS;
out.PL_dichotomies.cellResponses_PL_di_18_WS = cellResponses_PL_di_18_WS;
out.PL_dichotomies.cellResponses_PL_di_19_WS = cellResponses_PL_di_19_WS;
out.PL_dichotomies.cellResponses_PL_di_20_WS = cellResponses_PL_di_20_WS;
out.PL_dichotomies.cellResponses_PL_di_21_WS = cellResponses_PL_di_21_WS;
out.PL_dichotomies.cellResponses_PL_di_22_WS = cellResponses_PL_di_22_WS;
out.PL_dichotomies.cellResponses_PL_di_23_WS = cellResponses_PL_di_23_WS;
out.PL_dichotomies.cellResponses_PL_di_24_WS = cellResponses_PL_di_24_WS;
out.PL_dichotomies.cellResponses_PL_di_25_WS = cellResponses_PL_di_25_WS;
out.PL_dichotomies.cellResponses_PL_di_26_WS = cellResponses_PL_di_26_WS;
out.PL_dichotomies.cellResponses_PL_di_27_WS = cellResponses_PL_di_27_WS;
out.PL_dichotomies.cellResponses_PL_di_28_WS = cellResponses_PL_di_28_WS;
out.PL_dichotomies.cellResponses_PL_di_29_WS = cellResponses_PL_di_29_WS;
out.PL_dichotomies.cellResponses_PL_di_30_WS = cellResponses_PL_di_30_WS;
out.PL_dichotomies.cellResponses_PL_di_31_WS = cellResponses_PL_di_31_WS;
out.PL_dichotomies.cellResponses_PL_di_32_WS = cellResponses_PL_di_32_WS;
out.PL_dichotomies.cellResponses_PL_di_33_WS = cellResponses_PL_di_33_WS;
out.PL_dichotomies.cellResponses_PL_di_34_WS = cellResponses_PL_di_34_WS;
out.PL_dichotomies.cellResponses_PL_di_35_WS = cellResponses_PL_di_35_WS;

% package, OFC
out.OFC_dichotomies.cellResponses_OFC_di_1_WS = cellResponses_OFC_di_1_WS;
out.OFC_dichotomies.cellResponses_OFC_di_2_WS = cellResponses_OFC_di_2_WS;
out.OFC_dichotomies.cellResponses_OFC_di_3_WS = cellResponses_OFC_di_3_WS;
out.OFC_dichotomies.cellResponses_OFC_di_4_WS = cellResponses_OFC_di_4_WS;
out.OFC_dichotomies.cellResponses_OFC_di_5_WS = cellResponses_OFC_di_5_WS;
out.OFC_dichotomies.cellResponses_OFC_di_6_WS = cellResponses_OFC_di_6_WS;
out.OFC_dichotomies.cellResponses_OFC_di_7_WS = cellResponses_OFC_di_7_WS;
out.OFC_dichotomies.cellResponses_OFC_di_8_WS = cellResponses_OFC_di_8_WS;
out.OFC_dichotomies.cellResponses_OFC_di_9_WS = cellResponses_OFC_di_9_WS;
out.OFC_dichotomies.cellResponses_OFC_di_10_WS = cellResponses_OFC_di_10_WS;
out.OFC_dichotomies.cellResponses_OFC_di_11_WS = cellResponses_OFC_di_11_WS;
out.OFC_dichotomies.cellResponses_OFC_di_12_WS = cellResponses_OFC_di_12_WS;
out.OFC_dichotomies.cellResponses_OFC_di_13_WS = cellResponses_OFC_di_13_WS;
out.OFC_dichotomies.cellResponses_OFC_di_14_WS = cellResponses_OFC_di_14_WS;
out.OFC_dichotomies.cellResponses_OFC_di_15_WS = cellResponses_OFC_di_15_WS;
out.OFC_dichotomies.cellResponses_OFC_di_16_WS = cellResponses_OFC_di_16_WS;
out.OFC_dichotomies.cellResponses_OFC_di_17_WS = cellResponses_OFC_di_17_WS;
out.OFC_dichotomies.cellResponses_OFC_di_18_WS = cellResponses_OFC_di_18_WS;
out.OFC_dichotomies.cellResponses_OFC_di_19_WS = cellResponses_OFC_di_19_WS;
out.OFC_dichotomies.cellResponses_OFC_di_20_WS = cellResponses_OFC_di_20_WS;
out.OFC_dichotomies.cellResponses_OFC_di_21_WS = cellResponses_OFC_di_21_WS;
out.OFC_dichotomies.cellResponses_OFC_di_22_WS = cellResponses_OFC_di_22_WS;
out.OFC_dichotomies.cellResponses_OFC_di_23_WS = cellResponses_OFC_di_23_WS;
out.OFC_dichotomies.cellResponses_OFC_di_24_WS = cellResponses_OFC_di_24_WS;
out.OFC_dichotomies.cellResponses_OFC_di_25_WS = cellResponses_OFC_di_25_WS;
out.OFC_dichotomies.cellResponses_OFC_di_26_WS = cellResponses_OFC_di_26_WS;
out.OFC_dichotomies.cellResponses_OFC_di_27_WS = cellResponses_OFC_di_27_WS;
out.OFC_dichotomies.cellResponses_OFC_di_28_WS = cellResponses_OFC_di_28_WS;
out.OFC_dichotomies.cellResponses_OFC_di_29_WS = cellResponses_OFC_di_29_WS;
out.OFC_dichotomies.cellResponses_OFC_di_30_WS = cellResponses_OFC_di_30_WS;
out.OFC_dichotomies.cellResponses_OFC_di_31_WS = cellResponses_OFC_di_31_WS;
out.OFC_dichotomies.cellResponses_OFC_di_32_WS = cellResponses_OFC_di_32_WS;
out.OFC_dichotomies.cellResponses_OFC_di_33_WS = cellResponses_OFC_di_33_WS;
out.OFC_dichotomies.cellResponses_OFC_di_34_WS = cellResponses_OFC_di_34_WS;
out.OFC_dichotomies.cellResponses_OFC_di_35_WS = cellResponses_OFC_di_35_WS;


%% session info
%out.x=x;
out.Cell_sessions_PL_HF = Cell_sessions_PL_HF;
out.Cell_sessions_PL_uid = Cell_sessions_PL_uid ;
out.Cell_sessions_PL_WS = Cell_sessions_PL_WS;

out.sd_sessions_PL_HF = sd_sessions_PL_HF;
out.sd_sessions_PL_uid = sd_sessions_PL_uid;
out.sd_sessions_PL_WS = sd_sessions_PL_WS;

out.ID_Cell_PL_HF = ID_Cell_PL_HF;
out.ID_Cell_PL_uid = ID_Cell_PL_uid;
out.ID_Cell_PL_WS = ID_Cell_PL_WS;

out.Cell_sessions_OFC_HF = Cell_sessions_OFC_HF;
out.Cell_sessions_OFC_uid = Cell_sessions_OFC_uid;
out.Cell_sessions_OFC_WS = Cell_sessions_OFC_WS;

out.sd_sessions_OFC_HF = sd_sessions_OFC_HF;
out.sd_sessions_OFC_uid = sd_sessions_OFC_uid;
out.sd_sessions_OFC_WS = sd_sessions_OFC_WS;

out.ID_Cell_OFC_HF = ID_Cell_OFC_HF;
out.ID_Cell_OFC_uid = ID_Cell_OFC_uid ;
out.ID_Cell_OFC_WS = ID_Cell_OFC_WS;

