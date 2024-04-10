function [Firing_rate_baseline_neurons] = amw_baseline_avg_spike(sd,varargin)

process_varargin(varargin);

%Preallocate for all neurons expected

Firing_rate_baseline_neurons = NaN(length(sd.S),1);


%Firing_rate_baseline_neurons = NaN(restrict(sd.beh.lightsOn,sd.beh.lightsOff));

for iC = 1:length(sd.S);
    clear Baseline_trial_spikes Baseline_trial_time
   
    keep = sd.beh.trialOutcome==3 & sd.beh.trialType<2;
    
    Baseline_trial_spikes = sd.S{iC}.restrict((sd.beh.lightsOn(keep) - 0.5), sd.beh.lightsOn(keep));
    
    Baseline_trial_time= nansum((sd.beh.lightsOn(keep) - (sd.beh.lightsOn(keep) - 0.5)));
    %Restricted_trial_time = sd.S{iC}.restrict(sd.beh.lightsOff{iC}) - sd.S{iC}.restrict(sd.beh.lightsOn{iC})
    Firing_rate_baseline_neurons(iC) =length(Baseline_trial_spikes.data)/Baseline_trial_time;
end

%test = sd.S{1}.restrict(sd.beh.lightsOn(1),sd.beh.lightsOff(1));

%test = sd.S{iC}.restrict(sd.beh.lightsOn,sd.beh.lightsOff);