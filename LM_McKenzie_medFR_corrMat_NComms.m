function[popVec]= LM_McKenzie_medFR_corrMat_NComms(cellResponses,varargin);


timeBin = 1; % using 1 for odor

process_varargin(varargin);

%calculate the median FR for each unit across trials of each trial type
%designation

bin_medFR_cellResponses = cellResponses(:,timeBin,:); %take cellResponses only from desired time bin
medFR_cellResponses = cellfun(@nanmedian,bin_medFR_cellResponses);%compute median FR, change
popVec = permute(medFR_cellResponses, [1 3 2]);%reshape so it's a unit number x trial type matrix
end