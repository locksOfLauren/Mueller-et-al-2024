function F = LM_FiringRate(S, dt, varargin)%(fn,dt,'array',true)

%F = FiringRate(S, dt, varargin)
%F = FiringRate(S, dt, parms)
%F = FiringRate(fn,dt,'array',true)

% INPUTS
% S = cell array of ts of spikes
% dt = timestep of sampling (will return firing rate every dt seconds) - in seconds
%
% OUTPUTS
%    F = ctsd of firing rate by time
%
% ALGORITHM
%    Counts spikes in each bin and then blurs with a gaussian blur.
%
% PARAMETERS
%    windowSize = 0.5; % seconds -- window size of Gaussian blurring window
%    gaussBlur = 0.1; % seconds -- stddev of Gaussian blurring window
%    normalize = 0; % 1 = yes, 0 = no; -- if 1 then normalizes so each cell's FR sums to 1.
%    tStart = nan; tEnd = nan;  -- if nan then starts from first spike, ends with last, 
%               else produces ctsd between tStart and tEnd

% ADR/NCST Sept 2002
% Status: PROMOTED

windowSize = 0.1; % seconds
gaussBlur = 0.1; % seconds (or false for none)
normalize = false; % 1 = yes, 0 = no;
tStart = nan;
tEnd = nan;
array = true;
zScore = false;

process_varargin(varargin);

nC = length(S);

Q = MakeQfromS(S, dt, 'Tstart', tStart, 'Tend', tEnd);
QD = data(Q);
QD = full(QD);

if gaussBlur>0;
	x = -windowSize:dt:windowSize;
	y = normpdf(x,0,gaussBlur)';
	y = y/sum(y);
	
	for iC = 1:nC
		QD(:,iC) = conv2(QD(:,iC), y, 'same');
	end
end

if normalize
    for iC = 1:nC
        QD(:,iC) = QD(:,iC)/sum(QD(:,iC));
	end
end
	

if zScore;
	QD = zscorenan(QD,[],1);
end

F = ctsd(Q.starttime, dt, QD/dt);


if array;
	temp = cell(size(F.data,2),1);
	d = F.data;
	for iC = 1:length(temp);
		temp{iC} = tsd(F.range,d(:,iC));
	end
	F = temp;
end