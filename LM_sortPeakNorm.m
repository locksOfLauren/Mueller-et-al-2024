function [out] = LM_sortPeakNorm(peth,varargin);
process_varargin(varargin);
%takes peth and normalizes per neurons

out = [];
normVal = [];
%normalize
for i = 1:length(peth);%for each row
    highVal(i)=max(peth(i,:));%find the highest FR
    temp_normVal = peth(i,:) ./ highVal(i);%divide each point by the highest FR
    normVal = cat(1,normVal,temp_normVal);%make a matrix of paek-norm avg FR
end

%sort for epoch with highest FR
[~,ind] = max(normVal,[],2);
[~,ind2] = sort(ind);
out.ranked = normVal(ind2,:);
    
    
    