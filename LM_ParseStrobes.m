function sd = LM_ParseStrobes(sd,varargin)

%refactored from amw_ParseStrobes. Modified to work with PL/OFC correct block task.

extractLickData = false; %returns ts file of lick times

process_varargin(varargin);

%format strobe data to work with my old function
s.ts = sd.beh.timestamps;
s.sv  = sd.beh.strobes;


%Extract some very basic session info
sd.beh.sessionStartTime = s.ts(s.sv==221);
sd.beh.sessionEndTime = s.ts(s.sv==246);

%check whether there is fluid info in strobes
fluidError = 0;
if ~any(s.sv==229|s.sv==230);
   disp('Error: strobes do not indicate which flavor was delivered; marking all fluids as "0"');
   fluidError = 1;
end


%index strobes by trial
sd.beh.trialInd = NaN(size(s.sv));
trialOn = find(s.sv==222); %first value of each trial
trialOff = trialOn; %will compute the last value of each trial
trialOff = trialOff(2:end);
trialOff = trialOff-1;
trialOff(end+1) = length(s.sv);

%check to make sure trial start and end match up in length
if length(trialOff)~= length(trialOn);
	disp('ERROR! Trial length mismatch');
	return
end

%compute how many strobes occurred for each trial
eventsPerTrial = NaN(size(sd.beh.trialInd));
for iT = 1:length(trialOff);
	sd.beh.trialInd(trialOn(iT):trialOff(iT)) = iT;
	eventsPerTrial(iT) = sum(sd.beh.trialInd==iT);
end

nTrials = max(sd.beh.trialInd); %this is total "trials" including failed/aborted/incomplete/etc. behavioral events
sd.beh.nTrials = nTrials;

%preallocate for extracted events

%trial info
sd.beh.trialType = NaN(nTrials,1); %0=L, 1=R, 2=Choice
sd.beh.trialOutcome = NaN(nTrials,1); %0=timeout, 1=odor unpoke, 2=rwd unpoke, 3=completed
sd.beh.wentRight = NaN(nTrials,1);
sd.beh.wentLeft = NaN(nTrials,1);
sd.beh.chosenVolume = NaN(nTrials,1);
sd.beh.chosenFluid = NaN(nTrials,1); %0=A=chocolate; 1=B=vanilla

%trial timestamps
sd.beh.lightsOn = NaN(nTrials,1);
sd.beh.timeOut = NaN(nTrials,1);
sd.beh.odorPoke = NaN(nTrials,1);
sd.beh.odorOn = NaN(nTrials,1);
sd.beh.odorUnpoke = NaN(nTrials,1);
sd.beh.odorOff = NaN(nTrials,1);
sd.beh.fluidPoke = NaN(nTrials,1);
sd.beh.fluidDelivery = NaN(nTrials,1);
sd.beh.fluidUnpoke = NaN(nTrials,1);
sd.beh.lightsOff = NaN(nTrials,1);

%looping over trials, first determine "trial outcome"
for iT = 1:nTrials;
	
	clear currTrialStrobes
	currTrialStrobes = s.sv(sd.beh.trialInd==iT);
	
    
    %trial outcome
	if any(currTrialStrobes==223);  %0=timeout
		sd.beh.trialOutcome(iT) = 0;
	elseif any(currTrialStrobes==225); %1=odor unpoke
		sd.beh.trialOutcome(iT) = 1;
	elseif any(currTrialStrobes==250) | any(currTrialStrobes==251); %2==fluid unpoke
		sd.beh.trialOutcome(iT) = 2;
		
	elseif (any(currTrialStrobes==257) | any(currTrialStrobes==258) | ...    %3==completed
			any(currTrialStrobes==248) | any(currTrialStrobes==249)) ...
			& ~any(currTrialStrobes==250) | any(currTrialStrobes==251);
		sd.beh.trialOutcome(iT) = 3;
    end
	
    %trial type (this is incomplete, as any trial ending before odor onset
    %can't be classified)
    if any(currTrialStrobes==2); %left
        sd.beh.trialType(iT) = 0;
    elseif any(currTrialStrobes==12); %right
        sd.beh.trialType(iT) = 1;
    elseif any(currTrialStrobes==13); %choice
        sd.beh.trialType(iT) = 2;
    end
    

    
end

%fill in time stamps, other info for each trial
for iT = 1:nTrials;
	
	clear currTrialStrobes
	currTrialStrobes = s.sv(sd.beh.trialInd==iT);
	
	if ~isnan(sd.beh.trialOutcome(iT));
		
		%values for every trial (including timeouts)
		sd.beh.lightsOn(iT) = s.ts(sd.beh.trialInd==iT&s.sv==222);
		sd.beh.lightsOff(iT) = s.ts(sd.beh.trialInd==iT&s.sv==233);
		
		
		%additional values for trialOutcome=1 (odor unpoke)
		if sd.beh.trialOutcome(iT)>=1;
			sd.beh.odorPoke(iT) = s.ts(sd.beh.trialInd==iT&s.sv==224);
            if sd.beh.trialOutcome(iT)<2;
                sd.beh.odorUnpoke(iT) = s.ts(sd.beh.trialInd==iT&s.sv==225); %early odor unpoke
            else
                sd.beh.odorUnpoke(iT) = s.ts(sd.beh.trialInd==iT&s.sv==226); %
            end
            
			%there may not be values for these:
			if sum(sd.beh.trialInd==iT&s.sv<14)>0 ;
				sd.beh.odorOn(iT) = s.ts(sd.beh.trialInd==iT&s.sv<14);
			end
			
			if sum(sd.beh.trialInd==iT&s.sv==247)>0;
				sd.beh.odorOff(iT) = s.ts(sd.beh.trialInd==iT&s.sv==247);
			end
		end
		
		
		%additional values for trialOutcome=2 (fluid unpoke)
		if sd.beh.trialOutcome(iT)>=2;
			
			%response direction
			if any(currTrialStrobes==248) | any(currTrialStrobes==257); %went left
				sd.beh.wentLeft(iT) = 1;
				sd.beh.wentRight(iT) = 0;
			elseif any(currTrialStrobes==249) | any(currTrialStrobes==258); %went right
				sd.beh.wentLeft(iT) = 0;
				sd.beh.wentRight(iT) = 1;
			end
			
			%fluid poke/unpoke times
			pokeVal = [248 257 249 258];
            
            pokeVal = pokeVal(ismember(pokeVal,currTrialStrobes));
            pokeVal = pokeVal(1);
            sd.beh.fluidPoke(iT) = s.ts(sd.beh.trialInd==iT&s.sv==pokeVal);
			
            unpokeVal = [254 250 255 251];
            unpokeVal = unpokeVal(ismember(unpokeVal,currTrialStrobes));
            if ~isempty(unpokeVal);
                unpokeVal = unpokeVal(1);
                sd.beh.fluidUnpoke(iT) = s.ts(sd.beh.trialInd==iT&s.sv==unpokeVal);
            end
            
        end
        
		
		%additional values for trialOutcome=3 (complete trial)
		if sd.beh.trialOutcome(iT)==3;
			
			if any(currTrialStrobes==252)|any(currTrialStrobes==253); %a fluid was delivered
				
				%fluid delivery time
				if sd.beh.wentLeft(iT)==1;
					sd.beh.fluidDelivery(iT) = s.ts(sd.beh.trialInd==iT&s.sv==252);
				elseif sd.beh.wentRight(iT)==1;
					sd.beh.fluidDelivery(iT) = s.ts(sd.beh.trialInd==iT&s.sv==253);
				end
				
				%volume delivered
				if any(currTrialStrobes==291)&sd.beh.wentLeft(iT);
					sd.beh.chosenVolume(iT) = 3;
                elseif any(currTrialStrobes==291)&sd.beh.wentRight(iT);
					sd.beh.chosenVolume(iT) = 1;
                elseif any(currTrialStrobes==292)&sd.beh.wentLeft(iT);
                    sd.beh.chosenVolume(iT) = 1;
                elseif any(currTrialStrobes==292)&sd.beh.wentRight(iT);
                    sd.beh.chosenVolume(iT) = 3;
				end
				
				%fluid delivered
				if any(currTrialStrobes==229);
					sd.beh.chosenFluid(iT) = 0;
				elseif any(currTrialStrobes==230);
					sd.beh.chosenFluid(iT) = 1;
                elseif ~any(currTrialStrobes==230|currTrialStrobes==229);%Andrew added this in amw_ParseStrobes
                    sd.beh.chosenFluid(iT) = 0;
				end
				
			end
		end
	end
end
	



%now, infer some values from the extracted data

%preallocate



sd.beh.correct = NaN(nTrials,1);%Andrew added dot notation to put this into sd structure
sd.beh.error = NaN(nTrials,1);
sd.beh.choice = NaN(nTrials,1);
sd.beh.forced = NaN(nTrials,1);

sd.beh.programmedVolumeLeft = NaN(nTrials,1);%Andrew added dot notation to put this into sd structure
sd.beh.programmedVolumeRight = NaN(nTrials,1);
sd.beh.programmedFluidLeft = NaN(nTrials,1);
sd.beh.programmedFluidRight = NaN(nTrials,1);

%choice/forced
sd.beh.forced(sd.beh.trialType<=1) = 1;
sd.beh.choice(sd.beh.trialType==2) = 1;

%correct/error
sd.beh.correct(sd.beh.trialOutcome==3&~isnan(sd.beh.chosenFluid)) = 1;
sd.beh.error(sd.beh.trialOutcome==3&isnan(sd.beh.chosenFluid)) = 1;

%programmed volume
sd.beh.programmedVolumeLeft(sd.beh.wentLeft==1&sd.beh.chosenVolume==3) = 3;
sd.beh.programmedVolumeLeft(sd.beh.wentLeft==1&sd.beh.chosenVolume==1) = 1;
sd.beh.programmedVolumeRight(sd.beh.wentRight==1&sd.beh.chosenVolume==3) = 3;
sd.beh.programmedVolumeRight(sd.beh.wentRight==1&sd.beh.chosenVolume==1) = 1;

sd.beh.programmedVolumeLeft(sd.beh.programmedVolumeRight==3) = 1;
sd.beh.programmedVolumeLeft(sd.beh.programmedVolumeRight==1) = 3;
sd.beh.programmedVolumeRight(sd.beh.programmedVolumeLeft==3) = 1;
sd.beh.programmedVolumeRight(sd.beh.programmedVolumeLeft==1) = 3;

%programmed fluid
if fluidError==0;%Andrew added this

    sd.beh.programmedFluidLeft(sd.beh.wentLeft==1&sd.beh.chosenFluid==0) = 0;
    sd.beh.programmedFluidLeft(sd.beh.wentLeft==1&sd.beh.chosenFluid==1) = 1;
    sd.beh.programmedFluidRight(sd.beh.wentRight==1&sd.beh.chosenFluid==0) = 0;
    sd.beh.programmedFluidRight(sd.beh.wentRight==1&sd.beh.chosenFluid==1) = 1;

    sd.beh.programmedFluidLeft(sd.beh.programmedFluidRight==0) = 1;
    sd.beh.programmedFluidLeft(sd.beh.programmedFluidRight==1) = 0;
    sd.beh.programmedFluidRight(sd.beh.programmedFluidLeft==0) = 1;
    sd.beh.programmedFluidRight(sd.beh.programmedFluidLeft==1) = 0;
    
elseif fluidError==1;
    sd.beh.programmedFluidLeft = zeros(size(sd.beh.programmedFluidLeft));
    sd.beh.programmedFluidRight = zeros(size(sd.beh.programmedFluidRight));
end

%classify trials as belonging to particular blocks...
feat = cat(2,sd.beh.programmedVolumeLeft,sd.beh.programmedFluidLeft,...
    sd.beh.programmedVolumeRight, sd.beh.programmedFluidRight);
template = [3 0 1 1 ; 1 0 3 1 ; 3 1 1 0; 1 1 3 0 ] ; %changed for 4 blocks

sd.beh.blockType = NaN(nTrials,1);
for iT = 1:length(feat);
    if sum(isnan(feat(iT,:)))==0;
        sd.beh.blockType(iT) = find(all(repmat(feat(iT,:),4,1)==template,2));%changed to 4
    end
end

%fill in missing values
%find what the first trial had to be
t1 = find(~isnan(sd.beh.blockType),1,'first');
t1 = sd.beh.blockType(t1);
sd.beh.blockType(1) = t1;
for iT = 2:nTrials;
    if isnan(sd.beh.blockType(iT));
        sd.beh.blockType(iT) = sd.beh.blockType(iT-1);
    end
end
        
%ok, with all that sorted, go back and fill in the other variables
%completely

vals = template(sd.beh.blockType,:);
sd.beh.programmedVolumeLeft = vals(:,1);
sd.beh.programmedFluidLeft = vals(:,2);
sd.beh.programmedVolumeRight= vals(:,3);
sd.beh.programmedFluidRight = vals(:,4);

%get consecutive number of blocks (this is tricky, because they repeat)
sd.beh.blockTrialNumber_choice = NaN(nTrials,1);
sd.beh.blockTrialNumber_forced = NaN(nTrials,1);
sd.beh.blockTrialNumber_completed = NaN(nTrials,1);
sd.beh.blockTrialNumber = NaN(nTrials,1);
sd.beh.blockNumber = NaN(nTrials,1);
temp = sd.beh.blockType;
i = (1:nTrials)';
temp(temp==sd.beh.blockType(1)&i<(nTrials/2)) = NaN;
sd.beh.blockOrder = unique(temp(~isnan(temp)),'stable');
sd.beh.blockOrder = cat(1,sd.beh.blockType(1),sd.beh.blockOrder);

temp = sd.beh.blockType;
blockNumberInd = cell(length(sd.beh.blockOrder),1);
for iR = 1:length(sd.beh.blockOrder); % edited 10/29/19, Andrew changed in May 2019 on amw_ParseStrobes version, due to misaligning of blocks
	if iR == 1;
		 %blockNumberInd{iR} = find((i<(nTrials/3))&temp==sd.beh.blockOrder(1));
		 %temp(blockNumberInd{iR}) = NaN;
         
        switchInd = find(sd.beh.programmedVolumeLeft~=sd.beh.programmedVolumeLeft(1),1,'first');
		 blockNumberInd{iR} = find((i<(switchInd+10))&temp==sd.beh.blockOrder(1));
		 temp(blockNumberInd{iR}) = NaN;
	else
		 blockNumberInd{iR} = find(temp==sd.beh.blockOrder(iR));
		  temp(blockNumberInd{iR}) = NaN;
	end
	
	sd.beh.blockNumber(blockNumberInd{iR}) = iR;
	
end
	

%compute trial numbers within a block
for iR = 1:length(sd.beh.blockOrder);
	
	sd.beh.blockTrialNumber(sd.beh.blockNumber==iR) = (1:sum(sd.beh.blockNumber==iR))';
	
	sd.beh.blockTrialNumber_completed(sd.beh.blockNumber==iR&sd.beh.trialOutcome==3) = ...
		(1:sum(sd.beh.trialOutcome==3&sd.beh.blockNumber==iR))';
	
	sd.beh.blockTrialNumber_choice(sd.beh.blockNumber==iR&sd.beh.trialOutcome==3&sd.beh.choice==1) = ...
		(1:sum(sd.beh.choice==1&sd.beh.trialOutcome==3&sd.beh.blockNumber==iR))';
	
	sd.beh.blockTrialNumber_forced(sd.beh.blockNumber==iR&sd.beh.trialOutcome==3&sd.beh.forced==1) = ...
		(1:sum(sd.beh.forced==1&sd.beh.trialOutcome==3&sd.beh.blockNumber==iR))';
end



%define trials within a block as early or late (if block was long enough
%for this to matter)

sd.beh.earlyTrials = NaN(nTrials,1);
sd.beh.lateTrials = NaN(nTrials,1);
for iB = 1:length(sd.beh.blockOrder);
	clear keep
	keep = find(~isnan(sd.beh.blockTrialNumber_completed)&(sd.beh.blockNumber==iB));
	if length(keep)>40;
		sd.beh.earlyTrials(keep(1:20)) = 1;
		sd.beh.lateTrials(keep(end-20:end)) = 1;
	end
end

		







