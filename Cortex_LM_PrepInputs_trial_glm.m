function [response,predictor] = Cortex_LM_PrepInputs_trial_glm(sd,varargin)

%dt = 0.25;
dt = 0.1;
%dt = 0.05;


process_varargin(varargin);

%compute firing rate
F = FiringRate(sd.S,dt,'array',true);

%find the time stamps we care about
% events: light on, odor poke, fluid poke,

%keep = sd.beh.trialOutcome==3&~(sd.beh.error==1);%all completed none error trials, includes both free and forced 
keep = sd.beh.trialOutcome==3&~(sd.beh.error==1)&(sd.beh.blockNumber>1);%all completed none error trials, includes both free and forced changed 032724

%keep = sd.beh.trialOutcome==3&~(sd.beh.error==1)&(sd.beh.blockTrialNumber_forced>0&sd.beh.blockTrialNumber_forced<23)|(sd.beh.blockTrialNumber_choice>0&sd.beh.blockTrialNumber_choice<25);

lightOn = sd.beh.lightsOn(keep);
odorPoke = sd.beh.odorPoke(keep);
fluidPoke = sd.beh.fluidPoke(keep);
lightOff = sd.beh.lightsOff(keep);

%make the peths
%preallocate
response = [];

for iC = 1:length(sd.S);
    
    
     [p3,x1] = tsdPETH_amw(F{iC}, odorPoke, 'window', [-0.8 1]); 
       
     [p10,x2] = tsdPETH_amw(F{iC}, fluidPoke, 'window', [-0.4 1.4]);   %fluid poke
         
            p3_new = NaN(size(p3));
             for iT = 2:size(p3,2);
                 p3_new(:,iT) = nanmean(p3(:,iT-1:iT),2);
             end
             p3 = p3_new(:,2:end);
             
              p10_new = NaN(size(p10));
             for iT = 2:size(p10,2);
                 p10_new(:,iT) = nanmean(p10(:,iT-1:iT),2);
             end
             p10 = p10_new(:,2:end);
    
    response = cat(3,response,[p3,p10]);
    
end


predictor = [sd.beh.wentRight(keep)==1, sd.beh.chosenVolume(keep)==3, sd.beh.chosenFluid(keep)==1 , sd.beh.forced(keep)==1 ];

%% balance size since unbalanced due to free choice
chosen_large = predictor(:,2)==1;
tot_large = sum(chosen_large);

chosen_small = predictor(:,2)==0;
tot_small = sum(chosen_small);

new_keep_large = nan(length(chosen_large),1);
for i = 1:length(chosen_large)
    if chosen_large(i)==1 & sum(new_keep_large==1)< tot_small;
        new_keep_large(i)=1;
    else
        new_keep_large(i)=nan;
    end
end

updated_keep= new_keep_large ==1 | chosen_small ==1;
        
predictor = predictor(updated_keep==1,:);
response = response(updated_keep==1,:,:);


    

end
