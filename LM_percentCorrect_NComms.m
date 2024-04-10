function out = LM_percentCorrect_NComms(sd,varargin)

process_varargin(varargin);

out.pctCorr_all = [];
out.pctCorr_large = [];
out.pctCorr_small = [];



for iS = 1:length(sd);
    if ~isempty(sd{iS});
       
        %find all forced trials        
        keep = sd{iS}.beh.trialOutcome==3 & sd{iS}.beh.forced==1 &(sd{iS}.beh.blockNumber > 1)&  sd{iS}.beh.blockTrialNumber_forced<41; 
        
        
        %pull out trial info
        correct = sd{iS}.beh.correct(keep) == 1;
        wentRight = sd{iS}.beh.wentRight(keep);
        progVolLeft = sd{iS}.beh.programmedVolumeLeft(keep);
        progVolRight = sd{iS}.beh.programmedVolumeRight(keep);
        
        chosenVolume = NaN(size(wentRight));
        chosenVolume(wentRight==1) = progVolRight(wentRight==1); 
        chosenVolume(wentRight==0) = progVolLeft(wentRight==0);  
        
        cuedVolume = NaN(size(chosenVolume));
        cuedVolume(correct==1) = chosenVolume(correct==1);
        
        errorVolume = NaN(size(chosenVolume));
        errorVolume(correct==0) = chosenVolume(correct==0);
        errorVolume(errorVolume==3) = 2;
        errorVolume(errorVolume==1) = 3;
        errorVolume(errorVolume==2) = 1;
        cuedVolume(correct==0) = errorVolume(correct==0);
        
        %compute percentages
        pctCorr_all = nansum(correct)/length(correct);
        pctCorr_large = nansum(correct(cuedVolume==3))/nansum(cuedVolume==3);
        pctCorr_small = nansum(correct(cuedVolume==1))/nansum(cuedVolume==1);
        

        %package
        out.pctCorr_all = cat(1,out.pctCorr_all,pctCorr_all);
        out.pctCorr_large = cat(1,out.pctCorr_large,pctCorr_large);
        out.pctCorr_small = cat(1,out.pctCorr_small,pctCorr_small);
     

        
        
    end
end
    
   
end