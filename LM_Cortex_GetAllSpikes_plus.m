function [cellName,allSpikes,avgFr,avgFR_trial,avgFR_preTrial,avgFR_baseTom,PL,OFC] = LM_Cortex_GetAllSpikes_plus(fn,varargin)

%create a cell array of spike trains

process_varargin(varargin);

%Name variables of interest
cellName = [];
allSpikes = [];
avgFr = [];
avgFR_trial = [];
avgFR_preTrial = [];

avgFR_baseTom = [];
PL = [];
OFC = [];
wireNum = [];%0-15 PL, 16-31 OFC

if isstruct(fn{1});
    for iS = 1:length(fn);%total number of sessions
        if ~isempty(fn{iS});
            
            sessTime = NaN(length(fn{iS}.S),1);%Preallocate space for session time %does need to be a cell, preallocate with NaN %NaN(length(sd.S),1)
            sessSpikes = cell(length(fn{iS}.S),1);%Preallocate space for each cell in each session, lots of numbers different across neurons
            avgFr_temp = NaN(length(fn{iS}.S),1);%Preallocate space for avg FR %NaN length of cell %does need to be a cell, preallocate with NaN
            cellName_temp = cell(length((fn{iS}.S)),1);%Preallocate space for name, lots of numbers different across neurons
            wireNum_temp = cell(length((fn{iS}.S)),1);%Preallocate space for wire
            
            %sessTime = length(fn{iS}.
            
            for iC = 1:length(fn{iS}.S);%For each cell of each session
                
                sessSpikes{iC} = (fn{iS}.S{iC}.data);%Take the spike times %use .data
                sessTime(iC) = sessSpikes{iC}(end)- sessSpikes{iC}(1);
                avgFr_temp(iC) = (length(sessSpikes{iC})/ sessTime(iC)); %Calculate average Fr: # of spikes/time
                %cellName_temp{iC} = {strcat((fn{iS}.fn(end-20:end-13)),(fn{iS}.cellInfo{iC}.name))};%automatically changed the file name
                cellName_temp{iC} = {strcat((fn{iS}.fn(end-21:end-6)),(fn{iS}.cellInfo{iC}.name))};%automatically changed the file name
                wireNum_temp{iC} = (fn{iS}.cellInfo{iC}.wire);%changed
                
            end
            cellName = cat(1,cellName,cellName_temp);
            avgFr = cat(1,avgFr,avgFr_temp);
            allSpikes = cat(1,allSpikes,sessSpikes);%output of interest, use array of spike times as an input for mean firing rates function
            wireNum = cat(1,wireNum,wireNum_temp); 
        end
    end
    
    for i = 1:length(wireNum); 
    if wireNum{i} <= 15 ; %PL
     PL_OFC_wireNum(i)= 1; %if 0-15 then PL 1
     elseif wireNum{i} >= 16; 
         PL_OFC_wireNum(i) =2; %if 16-35 then OFC 2
    end        
end

[~,avgFR_trial,avgFR_preTrial,avgFR_baseTom] = amw_allfiringrates(fn);

PL = (PL_OFC_wireNum == 1)';
OFC = (PL_OFC_wireNum == 2)';

end