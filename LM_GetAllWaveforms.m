function [allWaves_trunc_norm,allWaves_raw,allWaves_trunc] = LM_GetAllWaveforms(fn,varargin)

process_varargin(varargin);

%extract the raw waveforms
allWaves_raw = [];
cellName = [];

if isstruct(fn{1});
    for iS = 1:length(fn);
        disp(iS);
       if ~isempty(fn{iS});
            
            sessWaves = cell(length(fn{iS}.S),1);
            cellName_temp = cell(length((fn{iS}.S)),1);
            for iC = 1:length(fn{iS}.S);
                sessWaves{iC} = (fn{iS}.cellInfo{iC}.waves);
                
                cellName_temp{iC} = {strcat((fn{iS}.fn(end-20:end-13)),(fn{iS}.cellInfo{iC}.name))};
                
            end
            cellName = cat(1,cellName,cellName_temp);
            for iC = 1:length(sessWaves);
                sessWaves{iC} = LM_InterpWaveforms(sessWaves{iC});
            end
            allWaves_raw = cat(1,allWaves_raw,sessWaves);
            
        end
    end
else
    
    
    ;
        disp(iS);
        sd = LM_LoadSessionData(fn{iS});
        sd = LM_ParseStrobes(sd);
        if isempty(sd.beh.sessionStartTime);
            disp('Behavior error')
        else
            
            sessWaves = cell(length(sd.S),1);
            cellName_temp = cell(length(sd.S),1);
            for iC = 1:length(sd.S);
                sessWaves{iC} = sd.cellInfo{iC}.waves;
                cellName_temp{iC} = {strcat(sd.fn(end-20:end-13),sd.cellInfo{iC}.name)};
                
            end
            cellName = cat(1,cellName,cellName_temp);
            allWaves_raw = cat(1,allWaves_raw,sessWaves);
            
        end
    end


%center and truncate everything to the same length
allWaves = NaN(length(allWaves_raw),1000); 
for iC = 1:length(allWaves_raw);
    temp = allWaves_raw{iC};
    temp2 = allWaves_raw{iC};
    temp2(1:75) = NaN;
    temp2(150:end) = NaN;
    [~,valleyIdx] = nanmin(temp2);
    pad = 150-valleyIdx;
%     wvStart = 51-valleyIdx; wvEnd = (wvStart+length(temp))-1;
%     input = cat(2,NaN(1,pad),temp');
    allWaves(iC,pad:((length(temp)-1)+pad)) = temp;
end

allWaves_trunc = allWaves(:,70:400);

%remove weird cells that just won't align
[~,ii] = nanmin(allWaves_trunc,[],2);
bad = ii~=mode(ii);
allWaves_trunc(bad,:) = NaN;

valley = nanmin(allWaves_trunc,[],2);
allWaves_trunc_norm = (allWaves_trunc+repmat(abs(valley),1,size(allWaves_trunc,2))); 
peak = nanmax(allWaves_trunc_norm,[],2);
allWaves_trunc_norm = allWaves_trunc_norm ./ repmat(peak,1,size(allWaves_trunc_norm,2));


end

