function [out] = LM_percent_freechoice_NComms(sd,varargin);

% similar to function LM_early_per_Lrg_freechoice but organized and with
% sessions

%preallocate space
volume = [];
blockNumber = [];
trialNumber = [];
percent_ChoiceLrgFree = [];
percent_ChoiceSmllFree = [];






for iS = 1:length(sd);%for all sessions
    if ~isempty(sd{iS});
        
        %find the trials we want
        %for Identity violin
        
        %1. Fig. 1c inset
        temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.choice==1 & ~(sd{iS}.beh.error==1) & (sd{iS}.beh.blockNumber == 3 | sd{iS}.beh.blockNumber == 5 ) & sd{iS}.beh.blockTrialNumber_choice<10; %first 10 free choice trials only on flavor block switches
        %2. Fig. 1c inset 
        %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.choice==1 & ~(sd{iS}.beh.error==1)& (sd{iS}.beh.blockNumber == 3 | sd{iS}.beh.blockNumber == 5 ) & (sd{iS}.beh.blockTrialNumber_choice<20&sd{iS}.beh.blockTrialNumber_choice>10); %last 10 free choice trials only on flavor block switches


        %for Value violin
        %3. Fig. 1b inset
        %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.choice==1 & ~(sd{iS}.beh.error==1)& (sd{iS}.beh.blockNumber == 2 | sd{iS}.beh.blockNumber == 4 ) & sd{iS}.beh.blockTrialNumber_choice<10; %first 10 free choice trials only on value block switches
        %4. Fig. 1b inset
         %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.choice==1 & ~(sd{iS}.beh.error==1)& (sd{iS}.beh.blockNumber == 2 | sd{iS}.beh.blockNumber == 4 ) & (sd{iS}.beh.blockTrialNumber_choice<20&sd{iS}.beh.blockTrialNumber_choice>10); %last 10 free choice trials only on value block switches


         
         
        %pull trial number / block number info
        temp_volume = sd{iS}.beh.chosenVolume(temp_keep);%size of the forced choice
        temp_blockNumber = sd{iS}.beh.blockNumber(temp_keep);%block number
        
        temp_trialNumber = sd{iS}.beh.blockTrialNumber_choice(temp_keep);%number of free choice trials, should only be 45ish
        %large free choice
        temp_LrgFree = sd{iS}.beh.chosenVolume(temp_keep)==3;%large choice free choice trials
        temp_LrgFree = sum(temp_LrgFree(:,1));%#of large choice
        temp_percent_ChoiceLrgFree = temp_LrgFree/length(temp_trialNumber);
        
        %small free choice, just to make sure it's inline with large
        temp_SmllFree = sd{iS}.beh.chosenVolume(temp_keep)==1;%small choice free choice trials
        temp_SmllFree = sum(temp_SmllFree(:,1));%#of large choice
        temp_percent_ChoiceSmllFree = temp_SmllFree/length(temp_trialNumber);
        

    
    
    
    %Each column is one session
    volume = cat(1,volume,{temp_volume});
    blockNumber = cat(1,blockNumber,{temp_blockNumber});
    trialNumber = cat(1,trialNumber,{temp_trialNumber});
    percent_ChoiceLrgFree = cat(1,percent_ChoiceLrgFree,temp_percent_ChoiceLrgFree);
    percent_ChoiceSmllFree = cat(1,percent_ChoiceSmllFree,temp_percent_ChoiceSmllFree);
   
   
    end
    


end

%package

out.volume = volume;
out.blockNumber = blockNumber;
out.trialNumber = trialNumber;
out.percentLrg= percent_ChoiceLrgFree;
out.percentSmll=percent_ChoiceSmllFree;

end



