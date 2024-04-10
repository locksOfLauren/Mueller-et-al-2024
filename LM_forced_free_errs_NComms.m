function out = LM_forced_free_errs_NComms(sd,varargin)


process_varargin(varargin);

out.free= [];
out.forced = [];
out.forced_error = [];
out.forced_correct = [];
out.free_error = [];
out.free_correct = [];
out.ID = [];
out.sessions=[];
out.Ordered_ID =[];
out.volume = [];
out.blockNumber = [];
out.trialNumber = [];
out.forced_small = [];
out.forced_large = [];

volume = [];
blockNumber = [];
trialNumber = [];
for iS = 1:length(sd);
    if ~isempty(sd{iS});
       
        %find all forced trials        
       keep = sd{iS}.beh.trialOutcome==3 &(sd{iS}.beh.blockTrialNumber>6& sd{iS}.beh.blockTrialNumber<60)&(sd{iS}.beh.blockNumber > 1);%original, worked used on first analysis




        %pull out trial info
        temp_free = sd{iS}.beh.choice(keep) == 1;
        temp_forced = sd{iS}.beh.forced(keep) == 1;
        temp_forced_error = sd{iS}.beh.error(keep) == 1 & sd{iS}.beh.forced(keep) == 1;
        temp_forced_correct = sd{iS}.beh.correct(keep) == 1 & sd{iS}.beh.forced(keep) == 1;
        temp_volume = sd{iS}.beh.chosenVolume(keep);
        temp_blockNumber = sd{iS}.beh.blockNumber(keep);%block number
        temp_trialNumber = sd{iS}.beh.blockTrialNumber(keep);
        
        correct = sd{iS}.beh.correct(keep) == 1;
       

        
        temp_free_error = temp_volume ==1 & temp_free == 1;
        temp_free_correct = temp_volume ==3 & temp_free == 1;
        temp_forced_small = temp_volume == 1 & temp_forced == 1 & correct ==1;
        temp_forced_large = temp_volume == 3 & temp_forced == 1 & correct ==1;
        
        %compute percentages

        
         %pull ID from fn
        temp_fn = sd{iS}.fn;
        temp_ID_Num = strfind(temp_fn,'LM');
        temp_ID = temp_fn(temp_ID_Num+2:temp_ID_Num+3);
        temp_ID= str2num(temp_ID);
        
        volume = cat(1,volume,{temp_volume});
        blockNumber = cat(1,blockNumber,{temp_blockNumber});
        trialNumber = cat(1,trialNumber,{temp_trialNumber});


        %package

        out.ID = cat(1,out.ID,temp_ID);
        out.free = cat(1,out.free,{temp_free});
        out.forced = cat(1,out.forced,{temp_forced});
        out.forced_error = cat(1,out.forced_error,{temp_forced_error});
        out.free_error = cat(1,out.free_error,{temp_free_error});
        out.free_correct = cat(1,out.free_correct,{temp_free_correct});
        out.forced_correct = cat(1,out.forced_correct,{temp_forced_correct});
        out.forced_small = cat(1,out.forced_small,{temp_forced_small});
        out.forced_large = cat(1,out.forced_large,{temp_forced_large});




        
        
    end
end
    
    % sucrose sessions, PL OFC data
if out.ID(1,1)==14;
ID_14_tot_sessions = sum(out.ID==14);
ID_14_sessions = [1:ID_14_tot_sessions]';
ID_16_tot_sessions = sum(out.ID==16);
ID_16_sessions = [1:ID_16_tot_sessions]';
ID_26_tot_sessions = sum(out.ID==26);
ID_26_sessions = [1:ID_26_tot_sessions]';
ID_28_tot_sessions = sum(out.ID==28);
ID_28_sessions = [1:ID_28_tot_sessions]';
sessions = cat(1,ID_14_sessions,ID_16_sessions,ID_26_sessions,ID_28_sessions);
Ordered_ID = [14,16,26,28]';
        
elseif out.ID(1,1)==11;
ID_11_tot_sessions = sum(out.ID==11);
ID_11_sessions = [1:ID_11_tot_sessions]';
ID_12_tot_sessions = sum(out.ID==12);
ID_12_sessions = [1:ID_12_tot_sessions]';
ID_13_tot_sessions = sum(out.ID==13);
ID_13_sessions = [1:ID_13_tot_sessions]';
ID_21_tot_sessions = sum(out.ID==21);
ID_21_sessions = [1:ID_21_tot_sessions]';
sessions = cat(1,ID_11_sessions,ID_12_sessions,ID_13_sessions,ID_21_sessions);
Ordered_ID = [11,12,13,21]';
end
        out.volume = volume;
        out.blockNumber = blockNumber;
        out.trialNumber = trialNumber;
        out.sessions = sessions;
        out.Ordered_ID=Ordered_ID;
end