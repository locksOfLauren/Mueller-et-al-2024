function [out]=segmented_dp_shifted_NComms(cellResponses,Cell_sessions,cellResponses_bin,varargin);

%takes cellResponses from RSA cluster, define region and corresponding
%sessions (s_out.cellResponses_OFC_principal,s_out.Cell_sessions_OFC_principal)

 cellResponses_bin =17;%chosen time bin within odor epoch 
process_varargin(varargin);


odorbin = cellResponses_bin;
cellResponses = cellResponses(:,odorbin,:);

%  2 sessions grouped
% odorbin = 17 ;
[dp_1] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>1&Cell_sessions<4,:,:),'nCells',20,'nBoot',50);%2-3
avg_dp_1 = nanmean(dp_1.dp_choiceType);

[dp_2] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>3&Cell_sessions<6,:,:),'nCells',20,'nBoot',50);%
avg_dp_2 = nanmean(dp_2.dp_choiceType);

[dp_3] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>5&Cell_sessions<8,:,:),'nCells',20,'nBoot',50);%
avg_dp_3 = nanmean(dp_3.dp_choiceType);

[dp_4] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>7&Cell_sessions<10,:,:),'nCells',20,'nBoot',50);%
avg_dp_4 = nanmean(dp_4.dp_choiceType);

[dp_5] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>9&Cell_sessions<12,:,:),'nCells',20,'nBoot',50);%
avg_dp_5 = nanmean(dp_5.dp_choiceType);

[dp_6] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>11&Cell_sessions<14,:,:),'nCells',20,'nBoot',50);%
avg_dp_6 = nanmean(dp_6.dp_choiceType);

[dp_7] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>13&Cell_sessions<16,:,:),'nCells',20,'nBoot',50);
avg_dp_7 = nanmean(dp_7.dp_choiceType);

[dp_8] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>15&Cell_sessions<18,:,:),'nCells',20,'nBoot',50);
avg_dp_8 = nanmean(dp_8.dp_choiceType);


%% dir

[dp_1_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>1&Cell_sessions<4,:,:),'nCells',20,'nBoot',50);%2-3
avg_dp_1_dir = nanmean(dp_1.dp_dir);

[dp_2_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>3&Cell_sessions<6,:,:),'nCells',20,'nBoot',50);%
avg_dp_2_dir = nanmean(dp_2.dp_dir);

[dp_3_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>5&Cell_sessions<8,:,:),'nCells',20,'nBoot',50);%
avg_dp_3_dir = nanmean(dp_3.dp_dir);

[dp_4_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>7&Cell_sessions<10,:,:),'nCells',20,'nBoot',50);%
avg_dp_4_dir = nanmean(dp_4.dp_dir);

[dp_5_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>9&Cell_sessions<12,:,:),'nCells',20,'nBoot',50);%
avg_dp_5_dir = nanmean(dp_5.dp_dir);

[dp_6_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>11&Cell_sessions<14,:,:),'nCells',20,'nBoot',50);%
avg_dp_6_dir = nanmean(dp_6.dp_dir);

[dp_7_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>13&Cell_sessions<16,:,:),'nCells',20,'nBoot',50);
avg_dp_7_dir = nanmean(dp_7.dp_dir);

[dp_8_dir] = LM_Cortex_RSA_ensemble_d(cellResponses(Cell_sessions>15&Cell_sessions<18,:,:),'nCells',20,'nBoot',50);
avg_dp_8_dir = nanmean(dp_8.dp_dir);



dp_2bin_session = cat(1,avg_dp_1,avg_dp_2,avg_dp_3,avg_dp_4,avg_dp_5,avg_dp_6,avg_dp_7,avg_dp_8);
dp_2bin_session_dir = cat(1,avg_dp_1_dir,avg_dp_2_dir,avg_dp_3_dir,avg_dp_4_dir,avg_dp_5_dir,avg_dp_6_dir,avg_dp_7_dir,avg_dp_8_dir);


all_dp_2bin.dp_1=dp_1.dp_choiceType;
all_dp_2bin.dp_2=dp_2.dp_choiceType;
all_dp_2bin.dp_3=dp_3.dp_choiceType;
all_dp_2bin.dp_4=dp_4.dp_choiceType;
all_dp_2bin.dp_5=dp_5.dp_choiceType;
all_dp_2bin.dp_6=dp_6.dp_choiceType;
all_dp_2bin.dp_7=dp_7.dp_choiceType;
all_dp_2bin.dp_8=dp_8.dp_choiceType;


all_dp_2bin_dir.dp_1=dp_1.dp_dir;
all_dp_2bin_dir.dp_2=dp_2.dp_dir;
all_dp_2bin_dir.dp_3=dp_3.dp_dir;
all_dp_2bin_dir.dp_4=dp_4.dp_dir;
all_dp_2bin_dir.dp_5=dp_5.dp_dir;
all_dp_2bin_dir.dp_6=dp_6.dp_dir;
all_dp_2bin_dir.dp_7=dp_7.dp_dir;
all_dp_2bin_dir.dp_8=dp_8.dp_dir;




out.dp_2bin_session_choice=dp_2bin_session;
out.all_dp_2bin_choice = all_dp_2bin;


%% 
out.dp_2bin_session_dir=dp_2bin_session_dir;
out.all_dp_2bin_dir = all_dp_2bin_dir;
