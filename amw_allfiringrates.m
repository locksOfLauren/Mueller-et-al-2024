function [avgFR,avgFR_trial,avgFR_preTrial,avgFR_baseTom] = amw_allfiringrates(sd)

avgFR = [];
avgFR_trial = [];
avgFR_preTrial = [];
avgFR_baseTom = [];

if isstruct(sd{1}); %it's a list of sd structs, not file names
    
    for iS = 1:length(sd);
        disp(iS);
        
        if ~isempty(sd{iS});
            

avgFR_temp= amw_total_avg_spike(sd{iS});
avgFR_trial_temp = amw_restricted_avg_spike(sd{iS});
avgFR_preTrial_temp = amw_baseline_avg_spike(sd{iS});
avgFR_baseTom_temp = amw_baseline_tom(sd{iS});

        end
 avgFR = cat(1,avgFR_temp,avgFR);  
 avgFR_trial = cat(1,avgFR_trial_temp,avgFR_trial);
 avgFR_preTrial = cat(1,avgFR_preTrial_temp,avgFR_preTrial);
 avgFR_baseTom = cat(1,avgFR_baseTom_temp,avgFR_baseTom);
        
        end 
        
        
    end
end
    