function [peth, x] = LM_tsdPETH(tsd,times,varargin)

window = [-.5 0.5]; %seconds

process_varargin(varargin);

dims = size(tsd.data,2);
t0 = tsd.starttime;
t1 = tsd.endtime;

times(times<t0+abs(window(1)) | times>t1-abs(window(2))) = NaN;

lBins = round(abs(window(1))/tsd.dt);
uBins = round(abs(window(2))/tsd.dt);

peth = NaN(dims,(lBins+uBins+1),length(times));

d = tsd.data;
for iT = 1:length(times);
    if ~isnan(times(iT));
        i = findAlignment_amw(tsd,times(iT));
        peth(:,:,iT) = d(i-lBins:i+uBins,:)';
    end
end
x = linspace(window(1),window(2),(lBins+uBins+1));

if dims == 1;
    peth = squeeze(peth);
    peth = peth';
end