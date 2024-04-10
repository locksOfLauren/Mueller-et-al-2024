function [Firing_rate_total_neurons] = amw_total_avg_spike(sd,varargin)

process_varargin(varargin);

%Preallocate for all neurons expected
Firing_rate_total_neurons = NaN(length(sd.S),1);

for iC = 1:length(sd.S);
    clear Total_trial_spikes Total_trial_time
    Total_trial_spikes = length(sd.S{iC}.data);
    
    Total_trial_time= sd.S{iC}.endtime - sd.S{iC}.starttime;
  
    Firing_rate_total_neurons(iC) = Total_trial_spikes/Total_trial_time;
end


