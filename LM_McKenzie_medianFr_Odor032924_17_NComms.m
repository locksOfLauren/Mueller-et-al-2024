function [cellResponses,x1,x2] = LM_McKenzie_medianFr_Odor032924_17_NComms(sd,varargin)

%divide trials for purpose of RDM with non arbitrary diagonal


dt = 0.5; %firing rate bin size (s)
minTrials = 1;

process_varargin(varargin);

%preallocate
%dimensionality of cellResponses are:
% nCells by x time points by x trial types (16 trial types here)
% time points are:
% pre,lightOn,odorPoke,odorOn,fluidPoke,outcome,lightOff,postTrial.
% trialTypes are:
% LLV,RLV,LSV,RSV,LLC,RLC,LSC,RSC

cellResponses = [];



for iS = 1:length(sd); %assume sd is a cell array of structures, each containing a single session's data
   disp(strcat(num2str(iS),'/',num2str(length(sd))));
    if ~isempty(sd{iS});
        
        %count cells in this session
        nCells = length(sd{iS}.S);
        
        %compute the firing rates of all cells
        F = FiringRate(sd{iS}.S,dt,'array',1,'gaussBlur',0);
        
        %find the time stamps we care about, take all completed free and
        %forced choice trials
        keep = sd{iS}.beh.trialOutcome==3&...
            ~(sd{iS}.beh.error==1)&...
            (sd{iS}.beh.blockNumber > 1);
            
        lightOn = sd{iS}.beh.lightsOn(keep);
        odorPoke = sd{iS}.beh.odorPoke(keep);
        fluidPoke = sd{iS}.beh.fluidPoke(keep);
        lightOff = sd{iS}.beh.lightsOff(keep);
        
        %trial identity matrix--pull info to tell us what happened on each trial
        forced = sd{iS}.beh.forced(keep)==1;
        wentLeft = sd{iS}.beh.wentLeft(keep)==1;
        rwdSize = sd{iS}.beh.chosenVolume(keep)==3;
        flavor = sd{iS}.beh.chosenFluid(keep)==1;

        %calculate zscored FR
        %make the peths
        %preallocate

        peth = [];
        
        for iC = 1:nCells;
          


            [p3,x1] = tsdPETH_amw(F{iC}, odorPoke+0.5, 'window', [0 0.5]); 
       
            [p10,x2] = tsdPETH_amw(F{iC}, odorPoke+0.5, 'window', [0.2 0.7]);   
       
            
         
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
             
             peth = cat(3,peth,cat(2,(p3),(p10)));

               
    


        end
        
        %package according to trial type for each cell
        %forced
        nTime = size(peth,2);
        for iC = 1:nCells;
            temp = [];
            f_LLV = cell(1,nTime);%forced
            f_LLC = cell(1,nTime);
            f_LSV = cell(1,nTime);
            f_LSC = cell(1,nTime);
            f_RLV = cell(1,nTime);
            f_RLC = cell(1,nTime);
            f_RSV = cell(1,nTime);
            f_RSC = cell(1,nTime);              
            c_LLV = cell(1,nTime);%free
            c_LLC = cell(1,nTime);
            c_LSV = cell(1,nTime);
            c_LSC = cell(1,nTime);
            c_RLV = cell(1,nTime);
            c_RLC = cell(1,nTime);
            c_RSV = cell(1,nTime);
            c_RSC = cell(1,nTime);  
           

        
            for iT = 1:size(peth,2);
                
                %forced
                
                 %LLV
                keep = forced == 1&wentLeft==1&rwdSize==1&flavor==1;
                f_LLV{iT} = peth(keep,iT,iC);

                %LLC
                keep = forced == 1&wentLeft==1&rwdSize==1&flavor==0;
                f_LLC{iT} = peth(keep,iT,iC);

                %LSV
                keep = forced == 1&wentLeft==1&rwdSize==0&flavor==1;
                f_LSV{iT} =peth(keep,iT,iC); 

                %LSC
                keep = forced == 1&wentLeft==1&rwdSize==0&flavor==0;
                f_LSC{iT} =peth(keep,iT,iC);

                %RLV
                keep = forced == 1&wentLeft==0&rwdSize==1&flavor==1;
                f_RLV{iT} = peth(keep,iT,iC);

                %RLC
                keep = forced == 1&wentLeft==0&rwdSize==1&flavor==0;
                f_RLC{iT} = peth(keep,iT,iC);    

                %RSV
                keep = forced == 1&wentLeft==0&rwdSize==0&flavor==1;
                f_RSV{iT} = peth(keep,iT,iC);    

                %RSC
                keep = forced == 1&wentLeft==0&rwdSize==0&flavor==0;
                f_RSC{iT} = peth(keep,iT,iC);  

                %free choice
                %LLV
                keep = forced == 0&wentLeft==1&rwdSize==1&flavor==1;
                c_LLV{iT} = peth(keep,iT,iC);

                %LLC
                keep = forced == 0&wentLeft==1&rwdSize==1&flavor==0;
                c_LLC{iT} = peth(keep,iT,iC);

                %LSV
                keep = forced == 0&wentLeft==1&rwdSize==0&flavor==1;
                c_LSV{iT} =peth(keep,iT,iC); 

                %LSC
                keep = forced == 0&wentLeft==1&rwdSize==0&flavor==0;
                c_LSC{iT} =peth(keep,iT,iC);

                %RLV
                keep = forced == 0&wentLeft==0&rwdSize==1&flavor==1;
                c_RLV{iT} = peth(keep,iT,iC);

                %RLC
                keep = forced == 0&wentLeft==0&rwdSize==1&flavor==0;
                c_RLC{iT} = peth(keep,iT,iC);    

                %RSV
                keep = forced == 0&wentLeft==0&rwdSize==0&flavor==1;
                c_RSV{iT} = peth(keep,iT,iC);    

                %RSC
                keep = forced == 0&wentLeft==0&rwdSize==0&flavor==0;
                c_RSC{iT} = peth(keep,iT,iC); 
                             
                
                
            end

          temp = cat(3,f_LLV,f_LLC,f_LSV,f_LSC,f_RLV,f_RLC,f_RSV,f_RSC,c_LLV,c_LLC,c_LSV,c_LSC,c_RLV,c_RLC,c_RSV,c_RSC);
            cellResponses = cat(1,cellResponses,temp);
        end
       
        end
        
    end
end 