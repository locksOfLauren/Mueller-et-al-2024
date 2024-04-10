function [Firing_rate_baseline_tom] = amw_baseline_tom(sd,varargin)

process_varargin(varargin);

%Preallocate for all neurons expected

Firing_rate_baseline_tom = NaN(length(sd.S),1);


%Firing_rate_baseline_neurons = NaN(restrict(sd.beh.lightsOn,sd.beh.lightsOff));

for iC = 1:length(sd.S);
    clear Baseline_trial_spikes Baseline_trial_time
   
    keep = sd.beh.trialOutcome>0;
    keep(1) = false;
    keep = find(keep);
    tOff = sd.beh.lightsOn(keep);
    tOn = sd.beh.lightsOff(keep-1);
    
    Baseline_trial_spikes = sd.S{iC}.restrict(tOn,tOff);
    
    Baseline_trial_time= nansum(tOff-tOn);
    %Restricted_trial_time = sd.S{iC}.restrict(sd.beh.lightsOff{iC}) - sd.S{iC}.restrict(sd.beh.lightsOn{iC})
    Firing_rate_baseline_tom(iC) =length(Baseline_trial_spikes.data)/Baseline_trial_time;
end

%test = sd.S{1}.restrict(sd.beh.lightsOn(1),sd.beh.lightsOff(1));

%test = sd.S{iC}.restrict(sd.beh.lightsOn,sd.beh.lightsOff);