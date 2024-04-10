function [x m sdev serr] = LM_PlotGroupMean_NComms(xData,yData,bins,varargin)

% bins data in x as requested and computes means for corresponding yData
% amw 03May2012

shadeBars = 0;
color = 'r';
whichError = 'sem'; %else 'std'
doubleError = 0;
normX = 0; normY = 1;% for percent choice
smooth = 0;
noError = 0;
doPlot = 1;
process_varargin(varargin);

if normX; 
    xData = xData./nanmax(xData);
end
if normY;
    yData = yData./nanmax(yData);
    yData = yData * 100;
end
    
if length(bins)==1;
    edges = linspace(nanmin(xData)-1,nanmax(xData)+1,bins);
else
    edges = bins;
end

[~,inds] = histc(xData,edges);

m = NaN(length(edges)-1,1);
sdev = NaN(length(edges)-1,1);
serr = NaN(length(edges)-1,1);
for iB = 1:length(edges)-1;
    m(iB) = nanmean(yData(inds==iB));
    sdev(iB) = nanstd(yData(inds==iB));
    serr(iB) = nanstderr(yData(inds==iB));
end

x = (linspace(edges(1),edges(end),length(edges)-1))';

if smooth>0;
	m = smooth1(m,smooth);
end

%plot it (or don't)

if strcmp(whichError,'sem');
    pErr = serr;
else
    pErr = sdev;
end

if doPlot;
    if shadeBars
        if doubleError;
            ShadedErrorbar(x,m,pErr,'L',pErr.*2,'U',pErr.*2,'color',color);
        else
            ShadedErrorbar(x,m,pErr,'L',pErr,'U',pErr,'color',color);
        end
    elseif doubleError;
        errorbar(x,m,pErr.*2,'Color',color);
    elseif noError;
        plot(x,m,'Color',color);
    else
        errorbar(x,m,pErr,'Color',color);
    end
    
end
end


    