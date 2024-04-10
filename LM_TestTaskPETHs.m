function [peth,x] = LM_TestTaskPETHs(sd,varargin)

dt = 0.05;

process_varargin(varargin);

%compute firing rate
F = LM_FiringRate(sd.S,dt,'array',true);

%find the time stamps we care about
% events: light on, odor poke, fluid poke,
keep = sd.beh.trialOutcome==3&~(sd.beh.error==1)&(sd.beh.blockNumber > 1);%changed 032724



lightOn = sd.beh.lightsOn(keep);
odorPoke = sd.beh.odorPoke(keep);
fluidPoke = sd.beh.fluidPoke(keep);
lightOff = sd.beh.lightsOff(keep);

%make the peths
%preallocate
peth = [];

for iC = 1:length(sd.S);
    
    [p3,x1] = LM_tsdPETH(F{iC}, odorPoke, 'window', [-0.8 1]); 
    [p10,x2] = LM_tsdPETH(F{iC}, fluidPoke, 'window', [-0.4 1.4]);
 
    p3_new = NaN(size(p3));
             for iT = 2:size(p3,2);
                 p3_new(:,iT) = nanmean(p3(:,iT-1:iT),2);
             end
             p3 = p3_new(:,2:end);
             
              p10_new = NaN(size(p10));
             for iT = 2:size(p10,2);
                 p10_new(:,iT) = nanmean(p10(:,iT-1:iT),2);
             end
             p10 = p10_new(:,2:end);
    
    peth = cat(1,peth,[nanmean(p3), NaN, nanmean(p10)]);
end
x = cat(1,[x1(2:end),NaN,x2(2:end)]);