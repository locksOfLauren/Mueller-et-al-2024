function [betaSize,betaDir,betaFlav,betaTrial,pValSize,pValDir,pValFlav,pValTrial] = LM_RunRegression_allSessions_trial(sd,varargin)

process_varargin(varargin);

betaSize = [];
betaDir = [];
betaFlav = [];
betaTrial = [];
pValSize = [];
pValDir = [];
pValFlav = [];
pValTrial = [];

for iS = 1:length(sd);
    disp(iS);
    if ~isempty(sd{iS});
        [response,predictor] = Cortex_LM_PrepInputs_trial_glm(sd{iS});%updated time bins p3 and p10
        [temp_betaDir,temp_betaSize,temp_betaFlav,temp_betaTrial,temp_pValDir,temp_pValSize,temp_pValFlav,temp_pValTrial] = LM_RunGLM_trial(response,predictor);
              
        betaSize = cat(1,betaSize,temp_betaSize);
        betaDir = cat(1,betaDir,temp_betaDir);
        betaFlav = cat(1,betaFlav,temp_betaFlav);
        betaTrial = cat(1,betaTrial,temp_betaTrial);
        pValSize = cat(1,pValSize,temp_pValSize);
        pValDir = cat(1,pValDir,temp_pValDir);
        pValFlav = cat(1,pValFlav,temp_pValFlav);
        pValTrial = cat(1,pValTrial,temp_pValTrial);
    end
end

dividers = NaN(length(betaSize),1); %create vector of NaNs the length of beta or pVal that will divide
%epochs, may need to adjust depending on dt time bin size 


% %dt = 0.1 
betaSize = [betaSize(:,1:8) dividers betaSize(:,9:13) dividers betaSize(:,14:18) dividers betaSize(:,19:23) dividers betaSize(:,24:28) dividers betaSize(:,29:end) dividers];
betaDir = [betaDir(:,1:8) dividers betaDir(:,9:13) dividers betaDir(:,14:18) dividers betaDir(:,19:23) dividers betaDir(:,24:28) dividers betaDir(:,29:end) dividers];
betaFlav = [betaFlav(:,1:8) dividers betaFlav(:,9:13) dividers betaFlav(:,14:18) dividers betaFlav(:,19:23) dividers betaFlav(:,24:28) dividers betaFlav(:,29:end) dividers]
betaTrial = [betaTrial(:,1:8) dividers betaTrial(:,9:13) dividers betaTrial(:,14:18) dividers betaTrial(:,19:23) dividers betaTrial(:,24:28) dividers betaTrial(:,29:end) dividers]
% 
pValDir = [pValDir(:,1:8) dividers pValDir(:,9:13) dividers pValDir(:,14:18) dividers pValDir(:,19:23) dividers pValDir(:,24:28) dividers pValDir(:,29:end) dividers];
pValSize = [pValSize(:,1:8) dividers pValSize(:,9:13) dividers pValSize(:,14:18) dividers pValSize(:,19:23) dividers pValSize(:,24:28) dividers pValSize(:,29:end) dividers];
pValFlav = [pValFlav(:,1:8) dividers pValFlav(:,9:13) dividers pValFlav(:,14:18) dividers pValFlav(:,19:23) dividers pValFlav(:,24:28) dividers pValFlav(:,29:end) dividers];
pValTrial = [pValTrial(:,1:8) dividers pValTrial(:,9:13) dividers pValTrial(:,14:18) dividers pValTrial(:,19:23) dividers pValTrial(:,24:28) dividers pValTrial(:,29:end) dividers]



