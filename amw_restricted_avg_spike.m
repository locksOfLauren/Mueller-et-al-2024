function [Firing_rate_restricted_neurons] = amw_restricted_avg_spike(sd,varargin)

process_varargin(varargin);

%Preallocate for all neurons expected

Firing_rate_restricted_neurons = NaN(length(sd.S),1);


%Firing_rate_restricted_neurons = NaN(restrict(sd.beh.lightsOn,sd.beh.lightsOff));

for iC = 1:length(sd.S);
    clear Restricted_trial_spikes Restricted_trial_time
    Restricted_trial_spikes = sd.S{iC}.restrict(sd.beh.lightsOn,sd.beh.lightsOff);
    
    Restricted_trial_time= nansum( sd.beh.lightsOff - sd.beh.lightsOn );
    %Restricted_trial_time = sd.S{iC}.restrict(sd.beh.lightsOff{iC}) - sd.S{iC}.restrict(sd.beh.lightsOn{iC})
    Firing_rate_restricted_neurons(iC) =length(Restricted_trial_spikes.data)/Restricted_trial_time;
end

%test = sd.S{1}.restrict(sd.beh.lightsOn(1),sd.beh.lightsOff(1));

%test = sd.S{iC}.restrict(sd.beh.lightsOn,sd.beh.lightsOff);