function [out] = LM_forcedChoice_logicals_NComms(sd,varargin);
%used Geoff's request of making equivalent plots for free and forced trials
process_varargin(varargin);

out.pctCorr_all = [];
out.pctCorr_large = [];
out.pctCorr_small = [];
out.trialNumber = [];
out.correct = [];
%creates list of 
for iS = 1:length(sd);%for all sessions
    if ~isempty(sd{iS});
        
   %find the trials we want
        %for line graphs
        %1. value switch line graph Fig. 1d
       temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.forced==1 & (sd{iS}.beh.blockNumber == 2 | sd{iS}.beh.blockNumber == 4 ) & sd{iS}.beh.blockTrialNumber_forced<21; %first 20 forced choice trials only on value block switches, for forced % correct line graph
       %2. identity switch line graph Fig. 1e
        %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.forced==1 & (sd{iS}.beh.blockNumber == 3 | sd{iS}.beh.blockNumber == 5 ) & sd{iS}.beh.blockTrialNumber_forced<21; %first 20 forced choice trials only on flavor block switches, for forced % correct line graph
     
        %for Identity switch violin
        %3. early Fig. 1e inset
        %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.forced==1 & (sd{iS}.beh.blockNumber == 3 | sd{iS}.beh.blockNumber == 5 ) & sd{iS}.beh.blockTrialNumber_forced<21; %first 20 forced choice trials only on flavor block switches, and early violin used pctCorr_all
        %4. late Fig. 1e inset
         %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.forced==1 & (sd{iS}.beh.blockNumber == 3 | sd{iS}.beh.blockNumber == 5 ) & (sd{iS}.beh.blockTrialNumber_forced<40&sd{iS}.beh.blockTrialNumber_forced>20); %last 20 forced choice trials only on flavor block switches, and late violin used pctCorr_all


        %for Value violin
        %5. early Fig. 1d inset
        %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.forced==1 & (sd{iS}.beh.blockNumber == 2 | sd{iS}.beh.blockNumber == 4 ) & sd{iS}.beh.blockTrialNumber_forced<21; %first 20 forced choice trials only on value block switches, and early violin used pctCorr_all
        %6. late Fig. 1d inest
        %temp_keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.forced==1 & (sd{iS}.beh.blockNumber == 2 | sd{iS}.beh.blockNumber == 4 ) & (sd{iS}.beh.blockTrialNumber_forced<40&sd{iS}.beh.blockTrialNumber_forced>20); %last 20 forced choice trials only on value block switches, and late violin used pctCorr_all


         
     
        
        %pull trial number / block number info     
        temp_trialNumber = sd{iS}.beh.blockTrialNumber_forced(temp_keep);%forced trials

                %pull out trial info
        temp_correct = sd{iS}.beh.correct(temp_keep) == 1;
        wentRight = sd{iS}.beh.wentRight(temp_keep);
        progVolLeft = sd{iS}.beh.programmedVolumeLeft(temp_keep);
        progVolRight = sd{iS}.beh.programmedVolumeRight(temp_keep);
        
        chosenVolume = NaN(size(wentRight));
        chosenVolume(wentRight==1) = progVolRight(wentRight==1); 
        chosenVolume(wentRight==0) = progVolLeft(wentRight==0);  
        
        cuedVolume = NaN(size(chosenVolume));
        cuedVolume(temp_correct==1) = chosenVolume(temp_correct==1);
        
        errorVolume = NaN(size(chosenVolume));
        errorVolume(temp_correct==0) = chosenVolume(temp_correct==0);
        errorVolume(errorVolume==3) = 2;
        errorVolume(errorVolume==1) = 3;
        errorVolume(errorVolume==2) = 1;
        cuedVolume(temp_correct==0) = errorVolume(temp_correct==0);

        %compute percentages
        pctCorr_all = nansum(temp_correct)/length(temp_correct);
        pctCorr_large = nansum(temp_correct(cuedVolume==3))/nansum(cuedVolume==3);
        pctCorr_small = nansum(temp_correct(cuedVolume==1))/nansum(cuedVolume==1);

        %package
        out.pctCorr_all = cat(1,out.pctCorr_all,pctCorr_all);
        out.pctCorr_large = cat(1,out.pctCorr_large,pctCorr_large);
        out.pctCorr_small = cat(1,out.pctCorr_small,pctCorr_small);
        
        out.trialNumber = cat(1,out.trialNumber,{temp_trialNumber});
        out.trialNumber = cell2mat(out.trialNumber);

        out.correct = cat(1,out.correct,{temp_correct});
        out.correct = cell2mat(out.correct);
    end
end
end
      

   

     