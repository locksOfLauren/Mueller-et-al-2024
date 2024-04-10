 function [out] = LM_freeChoice_logicals_NComms(sd,varargin);
%used for anovan
process_varargin(varargin);

volume = [];
trialNumber = [];
LrgFree = [];
%creates list of 
for iS = 1:length(sd);%for all sessions
    if ~isempty(sd{iS});
        
   %find the trials we want
   %1. Fig. 1b
       temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.choice==1 & (sd{iS}.beh.blockNumber == 2 | sd{iS}.beh.blockNumber == 4 ) & sd{iS}.beh.blockTrialNumber_choice<21; %first 20 free choice trials only on value block switches, for choice rate graph
     %2. Fig. 1c
        %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.choice==1 & (sd{iS}.beh.blockNumber == 3 | sd{iS}.beh.blockNumber == 5 ) & sd{iS}.beh.blockTrialNumber_choice<21; %first 20 free choice trials only on flavor block switches, for choice rate graph

        
        
        %pull trial number / block number info
        temp_volume = sd{iS}.beh.chosenVolume(temp_keep);%size of the forced choice
        
        
        temp_trialNumber = sd{iS}.beh.blockTrialNumber_choice(temp_keep);
        
        temp_LrgFree = sd{iS}.beh.chosenVolume(temp_keep)==3;%large choice free choice trials
   
    %Each column is one session
    volume = cat(1,volume,{temp_volume});
    volume = cell2mat(volume);
    trialNumber = cat(1,trialNumber,{temp_trialNumber});
    trialNumber = cell2mat(trialNumber);
    LrgFree = cat(1,LrgFree,{temp_LrgFree});
    LrgFree = cell2mat(LrgFree);

    end
    out.volume = volume;
    out.trialNumber = trialNumber;
    out.LrgFree = LrgFree;
end
end

    