# Mueller-et-al-2024
code associated with Mueller et al., 2024 manuscript

Get necessary data about recording sessions using the prepackaged sd named ‘prepackaged_SDs’. 
1.	Example: Enter ‘load('prepackaged_SDs.mat')’ into MATLAB command line and one sd for each treatment group will appear the workspace.
   
To get behavioral data for plots (Fig. 1b, c)
1.	Use SDs as input for ‘LM_freeChoice_logicals_NComms’, making sure to run each treatment group separately. The function is currently calculating the values needed to plot the line graph (Fig. 1b), to change to calculate the values needed to plot the other line graph (Fig. 1c) simply comment out line 14 and uncomment line 16. 
  a.	Example: [s_out] = LM_freeChoice_logicals_NComms(sd_suc)
  b.	Example: [c_out] = LM_freeChoice_logicals_NComms(sd_coc)
    i.	To visualize line graphs use ‘s_out.trialNumber’ and ‘s_out.LrgFree’ as inputs for ‘LM_PlotGroupMean’
      1.	Example: 
          Figure
          LM_PlotGroupMean_NComms(s_out.trialNumber, s_out.LrgFree,6)
          hold on
          LM_PlotGroupMean_NComms(c_out.trialNumber, c_out. LrgFree,6)
          ylim([0 100])
2.	To get the values used to create the inset violin plots use SDs input for ‘LM_percent_freechoice_NComms’, making sure to run each treatment group separately. The function is currently calculating the values needed to plot the inset violin for early trials (Fig. 1c), to change to calculate the values needed to plot the other violins (Fig. 1c, late; Fig. 1d, early and late) simply comment out line 25 and uncomment the labeled corresponding desired data (line 27, 32, or 34).
  a.	Example: [s_out] = LM_percent_freechoice_NComms(sd_suc)
  b.	Example: [c_out] = LM_percent_freechoice_NComms(sd_coc)
    i.	Use dot notation to access the % choice for the large reward
      1.	Example:
      Suc_prcnt_choice = s_out.percentLrg
      Coc_prcnt_choice = c_out.percentLrg
      2.	I exported these variables and created violin plots in GraphPad
         
To get behavioral data for plots (Fig. 1d, e)
1.	Use SDs as input for ‘LM_forcedChoice_logicals_NComms’, making sure to run each treatment group separately. The function is currently calculating the values needed to plot the line graph (Fig. 1d), to change to calculate the values needed to plot the other line graph (Fig. 1e) simply comment out line 17 and uncomment line 19. 
  a.	Example: [s_out] = LM_forcedChoice_logicals_NComms(sd_suc)
  b.	Example: [c_out] = LM_forcedChoice_logicals_NComms(sd_coc)
    i.	To visualize line graphs use ‘s_out.trialNumber’ and ‘s_out.correct’ as inputs for ‘LM_PlotGroupMean’
      1.	Example: 
      Figure
      LM_PlotGroupMean_NComms(s_out.trialNumber, s_out.correct,6)
      hold on
      LM_PlotGroupMean_NComms(c_out.trialNumber, c_out.correct,6)
      ylim([0 100])
2.	To get the values used to create the inset violin plots use the same function commenting out lines 17 or 19 that were used to create the line graph, and uncommenting the labeled corresponding desired data (line 23, 25, 30, or 32)
  a.	Example: [s_out] = LM_forcedChoice_logicals_NComms(sd_suc)
  b.	Example: [c_out] = LM_forcedChoice_logicals_NComms(sd_coc)
    i.	Use dot notation to access the % correct values
      1.	Example:
      Suc_prcnt_corr = s_out.pctCorr_all
      Coc_prcnt_corr = c_out.pctCorr_all
      2.	I exported these variables and created violin plots in GraphPad
         
To get behavioral data for plots (Fig. 1f)
1.	Use SDs as input for ‘LM_percentCorrect_NComms’, making sure to run each treatment group separately. 
  a.	Example: [s_out] = LM_percentCorrect_NComms(sd_suc)
  b.	Example: [c_out] = LM_percentCorrect_NComms(sd_coc)
    i.	Use dot notation to access the % correct values
1.	Example:
      Suc_smll_corr = s_out.pctCorr_small
      Suc_lrg_corr = s_out.pctCorr_large
      Coc_smll_corr = c_out.pctCorr_small
      Coc_lrg_corr = c_out.pctCorr_large
      2.	I exported these variables and created violin plots in GraphPad
         
To get behavioral data for plots (Fig. 1g)
1.	Use SDs as input for ‘LM_latency_NComms’, making sure to run each treatment group separately. 
  a.	Example: [s_out] = LM_latency_NComms(sd_suc)
  b.	Example: [c_out] = LM_latency_NComms(sd_coc)
    i.	Use dot notation to access the % correct values
      1.	Example:
      Suc_smll_lat = s_out.avg_latency_Smll
      Suc_lrg_lat = s_out.avg_latency_Lrg
      Coc_smll_lat = c_out.avg_latency_Smll
      Coc_lrg_lat = c_out.avg_latency_Lrg
      2.	I exported these variables and created violin plots in GraphPad
         
To define wide spike and narrow spike populations (Fig. 2b and c)
1.	Use SDs  as input for ‘Cortex_cluster_PETHs_032424,’ outputs out.WS_OFC and out.WS_PL are wide spike populations analyzed in this paper. Please note, a small proportion of the unit population was excluded if units did not fire, abnormally fired, or had strange wave properties, thresholds were applied equally across treatment groups
   
To create PETHs (Fig. 3a and c)
1.	Use SDs as input for ‘Cortex_cluster_PETHs_032424’ 
2.	Use output out.peth_OFC_WS(:,16:end) or out.peth_PL_WS(:,16:end) from ‘Cortex_cluster_PETHs_032424’ as input for ‘LM_sortPeakNorm,’ truncated here to eliminate activity from very beginning of trial we didn’t analyze
3.	Use output out.ranked to visualize PETHs, do this by entering ‘imagesc (out.ranked)’ into command line, must do this individually for each region and treatment group 
To create bar graphs (Fig. 3b and d)
4.	Use output out.ranked from ‘LM_sortPeakNorm’ as input for ‘LM_maxActive’
5.	Do this independently for each treatment group and region
6.	Use output maxActive from ‘LM_maxActive’ to run script LM_plot_maxActive to visualize data
  a.	Currently the plot script is graphing OFC maximally active units, to look at this quickly run sucrose and cocaine OFC   independently and name them ‘s_OFC_WS_max’  and ‘c_OFC_WS_max,’ while both are in workspace simply enter LM_plot_maxActive to     visualize bar graph

To run regression analyses and plot line graph (Fig. 4a ,b)
1.	Use SDs as input for ‘LM_RunRegression_allSessions_trial’ making sure to run treatment groups separately
2.	To visualize, use outputs from ‘LM_RunRegression_allSessions_trial’ and SDs as inputs for LM_Plot_Beta_Regression_trial. 
  a.	Currently, the % of selective units are not corrected for on these graphs making the general pattern correct but the values higher than the panel in the manuscript

To run d’ analyses and plot line graph (Fig. 5a, b)
1.	Use SDs as input for ‘Cortex_cluster_McKenzie_test’ making sure to run treatment groups separately 
  a.	Example: [s_out] = Cortex_cluster_McKenzie_test(sd_suc)
2.	Use output of ‘Cortex_cluster_McKenzie_test’ as input for ‘LM_Cortex_RSA_ensemble_d’ making sure to run each treatment group and unit population separately
  a.	Example for OFC d’:
        [s_ofc_dp] = LM_Cortex_RSA_ensemble_d(s_out.cellResponses_OFC_WS) and
  	    [c_ofc_dp] = LM_Cortex_RSA_ensemble_d(c_out.cellResponses_OFC_WS)
  b.	Example for PL d’:
    i.  [s_pl_dp] = LM_Cortex_RSA_ensemble_d(s_out.cellResponses_PL_WS) and
  	ii. [c_pl_dp] =LM_Cortex_RSA_ensemble_d(c_out.cellResponses_PL_WS)
3.	To visualize, use ‘LM_Cortex_RSA_ensemble_d’ outputs as  inputs for ‘plot_dPrime_shaded’ entering one region with both treatment groups at the same time
  a.	Example for OFC d’:
    i.	Plot_dPrime_shaded(s_ofc_dp, c_ofc_dp)
  b.	Example for PL d’:
    i.	Plot_dPrime_shaded(s_pl_dp, c_pl_dp)

To create dendrograms (Fig. 6a, b)
1.	Use SDs as input for ‘Cortex_cluster_McKenzie_test_dend’ making sure to run treatment groups separately 
  a.	Example: [s_out] = Cortex_cluster_McKenzie_test_dend(sd_suc) and [c_out] = Cortex_cluster_McKenzie_test_dend(sd_coc)
2.	To visualize, with above outputs in workspace run script ‘LM_plot_dend_NComms’

To get behavioral values used for plot (Fig. 6c)
1.	Use SDs as input for ‘LM_forced_free_errs_NComms’ making sure to run treatment groups separately– behavioral data analyzed here was from first 60 trials of each block because behavior was most stable, can change to use all trials
  a.	Example for sucrose: [s_behVals] = LM_forced_free_errs_NComms(sd_suc)
2.	Use output ‘s_behVals’ from ‘LM_forced_free_errs_NComms’ as input for ‘betweenChoice_errs_withinChoiceErr_NComms’
  a.	Example: [s_errs] = betweenChoice_errs_withinChoiceErr_NComms(s_behVals)
3.	Values used to create violin plot are stored in ‘s_errs’, access using dot notation. Violin plots were created using GraphPad.
  a.	Example: ‘Across_errs = s_errs.prcntAll_errs’
  b.	Example: ‘Within_errs = s_errs.prcentAll_withinErrs’

To get behavioral and d’ values corresponding to the same sessions (Fig. 6d) – used second recording session to start because not enough units in first session, used total of sixteen sessions per rat because of limited units and recording sessions later on in experiment
1.	For behavior, use ‘s_errs’ and ‘c_errs’ outputs from above as inputs for ‘segmented_behErrs_shifted_NComms’ making sure to run treatment groups separately 
  a.	Example: [s_beh_seg] = segmented_behErrs_shifted_NComms(s_errs)
  b.	Example: [c_beh_seg] = segmented_behErrs_shifted_NComms(c_errs)
2.	Use dot notation to access behavioral data used for plot and regression, concatenate ‘.allErrs_2bin_session’ from both treatment groups 
  a.	Example: [all_beh_seg] = cat(1,s_beh_seg.allErrs_2bin_session, c_beh_seg.allErrs_2bin_session)
3.	For d’, use SDs as inputs for ‘Cortex_cluster_McKenzie_test_beh_dp’ making sure to run treatment groups separately 
  a.	Example: [s_out] = Cortex_cluster_McKenzie_test_beh_dp(sd_suc)
  b.	Example: [c_out] = Cortex_cluster_McKenzie_test_beh_dp (sd_coc)
4.	Use ‘s_out’ and ‘c_out’ outputs from ‘Cortex_cluster_McKenzie_test_beh_dp’ as inputs for ‘segmented_dp_shifted_NComms’, making sure to run each treatment group separately and using the 17th bin occurring during the odor sampling epoch
  a.	Example: 
  [s_dp_ofc] = segmented_dp_shifted_NComms(s_out.cellResponses_OFC_WS, s_out.Cell_sessions_OFC_WS, 17) 
  b.	Example: 
  [c_dp_ofc] = segmented_dp_shifted_NComms(c_out.cellResponses_OFC_WS, c_out.Cell_sessions_OFC_WS, 17)
5.	Use dot notation to access d’ data used for plot and regression, concatenate ‘.dp_2bin_session_choice’ from both treatment groups 
  a.	Example: [all_choice_dp] = cat(1, s_dp_ofc.dp_2bin_session_choice, c_dp_ofc. dp_2bin_session_choice)
6.	Use both d’ values and treatment group as predictors going into glm
  a.	Create vector of values assigning treatment group
    i.	Example: suc = ones(1,8)
    ii.	Example: coc = zeros(1,8)
    iii.	all_trtmnt = cat(1,suc,coc)
  b.	Create final predictor by concatenating the d’ values and treatment group assignment vectors 
    i.	Example: predictor = cat(2,all_choice_dp,all_trtmnt)
7.	Use above behavioral responses as response going into glm
8.	Run glm using built-in function ‘fitglm’
  a.	Example: [regress] = fitglm(predictor,all_beh_seg) – values will not be identical to paper because pseudoensembles are randomly       chosen

To run shattering dimensionality analysis used for data included in plots (Fig. 7a, b)
1.	Use SDs as input for ‘Cortex_cluster_dichotomies_time_NComms’ making sure to run treatment groups separately 
  a.	Example for sucrose: [s_dichotomies] = Cortex_cluster_dichotomies_time_NComms (sd_suc)
  b.	Example for cocaine: [c_dichotomies] = Cortex_cluster_dichotomies_time_NComms (sd_coc)
2.	With the ‘dichotomies’ output from ‘Cortex_cluster_dichotomies_time_NComms’ in the workspace, run script ‘run_dichotomies_NComms’ in command line. This analysis will take a long time and require space, it’s likely best to run one region and treatment group at a time and save the workspace. Currently, the sucrose and cocaine OFC dichotomies are set to run. To run the PL dichotomies simply comment out the OFC and uncomment the pl. We used the third time bin of ‘cellResponses’ because it’s during the odor sampling epoch. 
3.	Running the above script as is will output 35 dichotomies for each treatment group for the OFC. With the 35 dichotomies from each treatment group in the workspace, run ‘plot_SD_NComms’ in command line. To calculate for PL, simply have the PL dichotomies in the workspace instead of OFC when running ‘plot_SD_NComms’
  a.	The variables ‘all_s_di’ and ‘all_c_di’ in the workspace contain the average decoding accuracy of each of the 31 latent variables per treatment group. These values were used to create plots (Fig. 7a, b) in GraphPad.
  b.	Figure 1 – similar visualization of values identical to those in Fig. 7a, top
  c.	Figure 2 - similar visualization of values identical to those in Fig. 7a, bottom















![image](https://github.com/locksOfLauren/Mueller-et-al-2024/assets/77174110/ef17a58d-9342-474c-9a45-b589c28e215a)

