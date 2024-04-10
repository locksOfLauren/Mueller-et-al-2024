function[] = LM_Plot_Beta_Regression_trial(s_pValSize,s_pValFlav,s_pValDir,s_pValTrial,s_betaSize,s_betaFlav,s_betaDir,s_betaTrial,c_pValSize,c_pValFlav,c_pValDir,c_pValTrial,c_betaSize,c_betaFlav,c_betaDir,c_betaTrial,sd_suc,sd_coc,varargin)

% Use LM_RunRegression_allSessions, use pVals as inputs for this function
% to plot values, here we are plotting sucrose vs cocaine per region (PL v OFC) per
% cell type (HF v WS)
process_varargin(varargin);
%% get region indicies (PL or OFC) per treatment group (suc or coc)
[~,~,~,~,~,~,s_PL,s_OFC] = LM_Cortex_GetAllSpikes_plus(sd_suc); 
[~,~,~,~,~,~,c_PL,c_OFC] = LM_Cortex_GetAllSpikes_plus(sd_coc);
%% get regression pVals corresponding with region of interest

% sucrose, PL
s_PL_pValSize = s_pValSize(s_PL==1,:,:);
s_PL_pValDir = s_pValDir(s_PL==1,:,:);
s_PL_pValFlav = s_pValFlav(s_PL==1,:,:);
s_PL_pValTrial = s_pValTrial(s_PL==1,:,:);

%sucrose, OFC
s_OFC_pValSize = s_pValSize(s_OFC==1,:,:);
s_OFC_pValDir = s_pValDir(s_OFC==1,:,:);
s_OFC_pValFlav = s_pValFlav(s_OFC==1,:,:);
s_OFC_pValTrial = s_pValTrial(s_OFC==1,:,:);

% cocaine, PL
c_PL_pValSize = c_pValSize(c_PL==1,:,:);
c_PL_pValDir = c_pValDir(c_PL==1,:,:);
c_PL_pValFlav = c_pValFlav(c_PL==1,:,:);
c_PL_pValTrial = c_pValTrial(c_PL==1,:,:);

%cocaine, OFC
c_OFC_pValSize = c_pValSize(c_OFC==1,:,:);
c_OFC_pValDir = c_pValDir(c_OFC==1,:,:);
c_OFC_pValFlav = c_pValFlav(c_OFC==1,:,:);
c_OFC_pValTrial = c_pValTrial(c_OFC==1,:,:);


%% Get classified cell pops per region (PL or OFC) per treatment group (suc or cocaine)
%sucrose
[out_suc] = Cortex_defineCells(sd_suc);
s_WS_PL = out_suc.WS_PL;
s_WS_OFC = out_suc.WS_OFC;
% 
% %cocaine
[out_coc] = Cortex_defineCells(sd_coc);
c_WS_PL = out_coc.WS_PL;
c_WS_OFC = out_coc.WS_OFC;

%% Divide regression predictor (size, flavor, direction) pVals up by region (PL or OFC) by cell type (HF or principal) by treatment group (suc or cocaine)

% sucrose, PL WS
 s_PL_WS_pValSize = s_PL_pValSize(s_WS_PL==1,:,:);
s_PL_WS_pValDir = s_PL_pValDir(s_WS_PL==1,:,:);
s_PL_WS_pValFlav = s_PL_pValFlav(s_WS_PL==1,:,:);
s_PL_WS_pValTrial = s_PL_pValTrial(s_WS_PL==1,:,:);


% sucrose, OFC WS
s_OFC_WS_pValSize = s_OFC_pValSize(s_WS_OFC==1,:,:);
s_OFC_WS_pValDir = s_OFC_pValDir(s_WS_OFC==1,:,:);
s_OFC_WS_pValFlav = s_OFC_pValFlav(s_WS_OFC==1,:,:);
s_OFC_WS_pValTrial = s_OFC_pValTrial(s_WS_OFC==1,:,:);


% cocaine, PL WS
c_PL_WS_pValSize = c_PL_pValSize(c_WS_PL==1,:,:);
c_PL_WS_pValDir = c_PL_pValDir(c_WS_PL==1,:,:);
c_PL_WS_pValFlav = c_PL_pValFlav(c_WS_PL==1,:,:);
c_PL_WS_pValTrial = c_PL_pValTrial(c_WS_PL==1,:,:);


% cocaine, OFC WS
c_OFC_WS_pValSize = c_OFC_pValSize(c_WS_OFC==1,:,:);
c_OFC_WS_pValDir = c_OFC_pValDir(c_WS_OFC==1,:,:);
c_OFC_WS_pValFlav = c_OFC_pValFlav(c_WS_OFC==1,:,:);
c_OFC_WS_pValTrial = c_OFC_pValTrial(c_WS_OFC==1,:,:);




%% Calculate percent of significantly selective cells (pVal of predictors < = 0.05), get corresponding beta values for units significantly modulated by predictors

%% 
%Size, WS
% Sucrose, PL WS
plot_s_PL_WS_size = [];
for i = 1:size(s_PL_WS_pValSize,2);
    temp_plot_s_PL_WS_size = (sum(s_PL_WS_pValSize(:,i)<=0.05)/length(s_PL_WS_pValSize))*100;
    plot_s_PL_WS_size = cat(2,plot_s_PL_WS_size,temp_plot_s_PL_WS_size);
end
plot_s_PL_WS_size(plot_s_PL_WS_size == 0) = NaN;



%Cocaine, PL WS
plot_c_PL_WS_size = [];
for i = 1:size(c_PL_WS_pValSize,2);
    temp_plot_c_PL_WS_size = (sum(c_PL_WS_pValSize(:,i)<=0.05)/length(c_PL_WS_pValSize))*100;
    plot_c_PL_WS_size = cat(2,plot_c_PL_WS_size,temp_plot_c_PL_WS_size);
end
plot_c_PL_WS_size(plot_c_PL_WS_size == 0) = NaN;

    


% Sucrose, OFC WS
plot_s_OFC_WS_size = [];
for i = 1:size(s_OFC_WS_pValSize,2);
    temp_plot_s_OFC_WS_size = (sum(s_OFC_WS_pValSize(:,i)<=0.05)/length(s_OFC_WS_pValSize))*100;
    plot_s_OFC_WS_size = cat(2,plot_s_OFC_WS_size,temp_plot_s_OFC_WS_size);
end
plot_s_OFC_WS_size(plot_s_OFC_WS_size == 0) = NaN;



%Cocaine, OFC WS
plot_c_OFC_WS_size = [];
for i = 1:size(c_OFC_WS_pValSize,2);
    temp_plot_c_OFC_WS_size = (sum(c_OFC_WS_pValSize(:,i)<=0.05)/length(c_OFC_WS_pValSize))*100;
    plot_c_OFC_WS_size = cat(2,plot_c_OFC_WS_size,temp_plot_c_OFC_WS_size);
end
plot_c_OFC_WS_size(plot_c_OFC_WS_size == 0) = NaN;

   
%% Direction, WS
% Sucrose, PL WS
plot_s_PL_WS_Dir = [];
for i = 1:size(s_PL_WS_pValDir,2);
    temp_plot_s_PL_WS_Dir = (sum(s_PL_WS_pValDir(:,i)<=0.05)/length(s_PL_WS_pValDir))*100;
    plot_s_PL_WS_Dir = cat(2,plot_s_PL_WS_Dir,temp_plot_s_PL_WS_Dir);
end
plot_s_PL_WS_Dir(plot_s_PL_WS_Dir == 0) = NaN;





%Cocaine, PL WS
plot_c_PL_WS_Dir = [];
for i = 1:size(c_PL_WS_pValDir,2);
    temp_plot_c_PL_WS_Dir = (sum(c_PL_WS_pValDir(:,i)<=0.05)/length(c_PL_WS_pValDir))*100;
    plot_c_PL_WS_Dir = cat(2,plot_c_PL_WS_Dir,temp_plot_c_PL_WS_Dir);
end
plot_c_PL_WS_Dir(plot_c_PL_WS_Dir == 0) = NaN;



% Sucrose, OFC WS
plot_s_OFC_WS_Dir = [];
for i = 1:size(s_OFC_WS_pValDir,2);
    temp_plot_s_OFC_WS_Dir = (sum(s_OFC_WS_pValDir(:,i)<=0.05)/length(s_OFC_WS_pValDir))*100;
    plot_s_OFC_WS_Dir = cat(2,plot_s_OFC_WS_Dir,temp_plot_s_OFC_WS_Dir);
end
plot_s_OFC_WS_Dir(plot_s_OFC_WS_Dir == 0) = NaN;




%Cocaine, OFC WS
plot_c_OFC_WS_Dir = [];
for i = 1:size(c_OFC_WS_pValDir,2);
    temp_plot_c_OFC_WS_Dir = (sum(c_OFC_WS_pValDir(:,i)<=0.05)/length(c_OFC_WS_pValDir))*100;
    plot_c_OFC_WS_Dir= cat(2,plot_c_OFC_WS_Dir,temp_plot_c_OFC_WS_Dir);
end
plot_c_OFC_WS_Dir(plot_c_OFC_WS_Dir == 0) = NaN;



%% Trial type, WS
% Sucrose, PL WS
plot_s_PL_WS_Trial = [];
for i = 1:size(s_PL_WS_pValTrial,2);
    temp_plot_s_PL_WS_Trial = (sum(s_PL_WS_pValTrial(:,i)<=0.05)/length(s_PL_WS_pValTrial))*100;
    plot_s_PL_WS_Trial = cat(2,plot_s_PL_WS_Trial,temp_plot_s_PL_WS_Trial);
end
plot_s_PL_WS_Trial(plot_s_PL_WS_Trial == 0) = NaN;

   

%Cocaine, PL WS
plot_c_PL_WS_Trial = [];
for i = 1:size(c_PL_WS_pValTrial,2);
    temp_plot_c_PL_WS_Trial= (sum(c_PL_WS_pValTrial(:,i)<=0.05)/length(c_PL_WS_pValTrial))*100;
    plot_c_PL_WS_Trial = cat(2,plot_c_PL_WS_Trial,temp_plot_c_PL_WS_Trial);
end
plot_c_PL_WS_Trial(plot_c_PL_WS_Trial == 0) = NaN;


  


% Sucrose, OFC WS
plot_s_OFC_WS_Trial = [];
for i = 1:size(s_OFC_WS_pValTrial,2);
    temp_plot_s_OFC_WS_Trial = (sum(s_OFC_WS_pValTrial(:,i)<=0.05)/length(s_OFC_WS_pValTrial))*100;
    plot_s_OFC_WS_Trial = cat(2,plot_s_OFC_WS_Trial,temp_plot_s_OFC_WS_Trial);
end
plot_s_OFC_WS_Trial(plot_s_OFC_WS_Trial == 0) = NaN;

    

%Cocaine, OFC WS
plot_c_OFC_WS_Trial = [];
for i = 1:size(c_OFC_WS_pValTrial,2);
    temp_plot_c_OFC_WS_Trial = (sum(c_OFC_WS_pValTrial(:,i)<=0.05)/length(c_OFC_WS_pValTrial))*100;
    plot_c_OFC_WS_Trial= cat(2,plot_c_OFC_WS_Trial,temp_plot_c_OFC_WS_Trial);
end
plot_c_OFC_WS_Trial(plot_c_OFC_WS_Trial == 0) = NaN;

   

%% Flavor, WS
% Sucrose, PL WS
plot_s_PL_WS_Flav = [];
for i = 1:size(s_PL_WS_pValFlav,2);
    temp_plot_s_PL_WS_Flav = (sum(s_PL_WS_pValFlav(:,i)<=0.05)/length(s_PL_WS_pValFlav))*100;
    plot_s_PL_WS_Flav = cat(2,plot_s_PL_WS_Flav,temp_plot_s_PL_WS_Flav);
end
plot_s_PL_WS_Flav(plot_s_PL_WS_Flav == 0) = NaN;

    

%Cocaine, PL WS
plot_c_PL_WS_Flav = [];
for i = 1:size(c_PL_WS_pValFlav,2);
    temp_plot_c_PL_WS_Flav = (sum(c_PL_WS_pValFlav(:,i)<=0.05)/length(c_PL_WS_pValFlav))*100;
    plot_c_PL_WS_Flav = cat(2,plot_c_PL_WS_Flav,temp_plot_c_PL_WS_Flav);
end
plot_c_PL_WS_Flav(plot_c_PL_WS_Flav == 0) = NaN;


  

% Sucrose, OFC WS
plot_s_OFC_WS_Flav = [];
for i = 1:size(s_OFC_WS_pValFlav,2);
    temp_plot_s_OFC_WS_Flav = (sum(s_OFC_WS_pValFlav(:,i)<=0.05)/length(s_OFC_WS_pValFlav))*100;
    plot_s_OFC_WS_Flav = cat(2,plot_s_OFC_WS_Flav,temp_plot_s_OFC_WS_Flav);
end
plot_s_OFC_WS_Flav(plot_s_OFC_WS_Flav == 0) = NaN;

    
%Cocaine, OFC WS
plot_c_OFC_WS_Flav = [];
for i = 1:size(c_OFC_WS_pValFlav,2);
    temp_plot_c_OFC_WS_Flav = (sum(c_OFC_WS_pValFlav(:,i)<=0.05)/length(c_OFC_WS_pValFlav))*100;
    plot_c_OFC_WS_Flav= cat(2,plot_c_OFC_WS_Flav,temp_plot_c_OFC_WS_Flav);
end
plot_c_OFC_WS_Flav(plot_c_OFC_WS_Flav == 0) = NaN;

   

%% Create plots
%Size selective neurons (suc vs coc)

%PL WS
figure;
plot(plot_s_PL_WS_size(10:end),'g');
hold on
plot(plot_c_PL_WS_size(10:end),'g--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Outcome size, PL WS')

%OFC WS
figure;
plot(plot_s_OFC_WS_size(10:end),'g');
hold on
plot(plot_c_OFC_WS_size(10:end),'g--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Outcome size, OFC WS')

%% Direction selective neurons (suc v coc)
%Size selective neurons (suc vs coc)

%PL WS
figure;
plot(plot_s_PL_WS_Dir(10:end),'b');
hold on
plot(plot_c_PL_WS_Dir(10:end),'b--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Response direction, PL WS')

%OFC WS
figure;
plot(plot_s_OFC_WS_Dir(10:end),'b');
hold on
plot(plot_c_OFC_WS_Dir(10:end),'b--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Response direction, OFC WS')

%% Flavor selective neurons (suc v coc)

%PL WS
figure;
plot(plot_s_PL_WS_Flav(10:end),'m');
hold on
plot(plot_c_PL_WS_Flav(10:end),'m--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Outcome flavor, PL WS')

%OFC WS
figure;
plot(plot_s_OFC_WS_Flav(10:end),'m');
hold on
plot(plot_c_OFC_WS_Flav(10:end),'m--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Outcome flavor, OFC WS')

%% Trial selective neurons (suc v coc)

%PL WS
figure;
plot(plot_s_PL_WS_Trial(10:end),'r');
hold on
plot(plot_c_PL_WS_Trial(10:end),'r--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Outcome Trial, PL WS')

%OFC WS
figure;
plot(plot_s_OFC_WS_Trial(10:end),'r');
hold on
plot(plot_c_OFC_WS_Trial(10:end),'r--');
%setnanwhite;
box off
legend('Sucrose','Cocaine');
legend box off
%xlim([0 20]);
xticks([3 9 15 21 28]);
xtickangle(45);
xticklabels({'Fixation','Odor sample','Movement','Anticipation','Consumption'});
ax = gca;
ax.TickLength = [0 0];
ylim([ 0 45]);
yticks([0 15 30 45]);
ylabel('% selective units')
title('Trial, OFC WS')

end