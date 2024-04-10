function [out] = LM_latency_NComms(sd,varargin);

%by session
%free choice latency,organized

%preallocate space
latency = [];
latency_Lrg = [];
latency_Smll = [];
avg_latency = [];
avg_latency_Lrg = [];
avg_latency_Smll = [];



for iS = 1:length(sd);%for all sessions
    if ~isempty(sd{iS});
        
        %find the trials we want

        temp_keep = sd{iS}.beh.trialOutcome==3 & ~(sd{iS}.beh.error==1)& sd{iS}.beh.blockNumber>1 & (sd{iS}.beh.blockTrialNumber_forced<41);      

        
        %pull the decision latencies
        temp_latency = sd{iS}.beh.fluidPoke(temp_keep) - sd{iS}.beh.odorUnpoke(temp_keep); %time between entering fluid well and leaving odor port
        
    
        %pull trial number / block number info
        temp_volume = sd{iS}.beh.chosenVolume(temp_keep);%size of the free choice
        temp_blockNumber = sd{iS}.beh.blockNumber(temp_keep);
        temp_trialNumber = sd{iS}.beh.blockTrialNumber_choice(temp_keep);%number of free choice trial in the block
        
        %pull ID from fn
        temp_fn = sd{iS}.fn;
        temp_ID_Num = strfind(temp_fn,'LM');
        temp_ID = temp_fn(temp_ID_Num+2:temp_ID_Num+3);
        temp_ID= str2num(temp_ID);
%%%%%%%%%%
        % specify separate latencies by size
        
         temp_latency_Lrg = [];
         temp_latency_Smll = [];
                
                

for i = 1 : length(temp_volume);
if temp_volume(i) == 3;
temp_latency_Lrg (i) = temp_latency(i);
else temp_latency_Smll(i) = temp_latency(i);    
end
end

temp_latency_Lrg(temp_latency_Lrg==0) = NaN;
temp_latency_Lrg = temp_latency_Lrg';
temp_latency_Smll(temp_latency_Smll==0) = NaN;
temp_latency_Smll = temp_latency_Smll';    
 %%%%%%%%%%%%%%   
  % not sure which outputs we want
latency = cat(1,latency,{temp_latency});
latency_Lrg = cat(1,latency_Lrg,{temp_latency_Lrg});
latency_Smll = cat(1,latency_Smll,{temp_latency_Smll});

    
    end
    avg_latency = cellfun(@mean,latency);
    avg_latency_Lrg = cellfun(@nanmean,latency_Lrg);
    avg_latency_Smll = cellfun(@nanmean,latency_Smll);
     
end





%package

out.avg_latency = avg_latency;
out.avg_latency_Lrg = avg_latency_Lrg;
out.avg_latency_Smll = avg_latency_Smll;
out.latency =latency;


end


