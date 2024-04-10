function [cellResponses] = LM_GenerateDichotomyVectors_time_NComms(sd,varargin)




dt = 0.5; %

minTrials = 15; 

process_varargin(varargin);

%preallocate
%dimensionality of cellResponses is:
% nCells by x time points by x trial types
% time points are:
% pre,lightOn,odorPoke,odorOn,fluidPoke,outcome,lightOff,postTrial.
% trialTypes are:
% LLV,RLV,LSV,RSV,LLC,RLC,LSC,RSC
%dichotomies = [];
di_1 = [];
di_2 = [];
di_3 = [];
di_4 = [];
di_5 = [];
di_6 = [];
di_7 = [];
di_8 = [];
di_9 = [];
di_10 = [];
di_11 = [];
di_12 = [];
di_13 = [];
di_14 = [];
di_15 = [];
di_16 = [];
di_17 = [];
di_18 = [];
di_19 = [];
di_20 = [];
di_21 = [];
di_22 = [];
di_23 = [];
di_24 = [];
di_25 = [];
di_26 = [];
di_27 = [];
di_28 = [];
di_29 = [];
di_30 = [];
di_31 = [];
di_32 = [];
di_33 = [];
di_34 = [];
di_35 = [];

for iS = 1:length(sd); %assume sd is a cell array of structures, each containing a single session's data
   disp(strcat(num2str(iS),'/',num2str(length(sd))));
    if ~isempty(sd{iS});
        
        %count cells in this session
        nCells = length(sd{iS}.S);
        
        %compute the firing rates of all cells
        F = FiringRate(sd{iS}.S,dt,'array',1,'gaussBlur',0);
        
        %find the time stamps we care about
       
             keep = sd{iS}.beh.trialOutcome==3&... 
            ~(sd{iS}.beh.error==1)&...
            sd{iS}.beh.forced==1&...
            sd{iS}.beh.correct==1&...
            sd{iS}.beh.blockTrialNumber_forced>4&...
            (sd{iS}.beh.blockNumber > 1);

            
  
        lightOn = sd{iS}.beh.lightsOn(keep);
        odorPoke = sd{iS}.beh.odorPoke(keep);
        fluidPoke = sd{iS}.beh.fluidPoke(keep);
        lightOff = sd{iS}.beh.lightsOff(keep);
        
        %trial identity matrix--pull info to tell us what happened on each trial
        forced = sd{iS}.beh.forced(keep)==1;
        wentLeft = sd{iS}.beh.wentLeft(keep)==1;
        blockNumber = sd{iS}.beh.blockNumber(keep);
        rwdSize = sd{iS}.beh.chosenVolume(keep)==3;
        flavor = sd{iS}.beh.chosenFluid(keep)==1;
        
        %make the peths
        %preallocate
        peth = [];
        
        for iC = 1:nCells;

    [p2,x2] = tsdPETH_LM(F{iC}, odorPoke, 'window', [0 0.5]); %odor poke, 500 ms in well
    [p3,x3] = tsdPETH_LM(F{iC}, odorPoke+0.5, 'window', [0 0.5]); %odor on, 500 ms odor on
    [p4,x4] = tsdPETH_LM(F{iC}, fluidPoke, 'window', [-0.5 0]);%movement, 500 ms prior to fluid well entry



    peth = cat(3,peth,cat(2,(p2),(p3),(p4)));%used, good


        end
        
        %package according to trial type for each cell
        nTime = size(peth,2);
        for iC = 1:nCells;
            temp = [];
            D = cell(1,nTime);%D,LLV
            C = cell(1,nTime);%C,LLC
            A = cell(1,nTime);%A,LSV
            B = cell(1,nTime);%B,LSC
            F = cell(1,nTime);%F,RLV
            E = cell(1,nTime);%E,RLC
            G = cell(1,nTime);%G,RSV
            H = cell(1,nTime);%H,RSC
                  
        
            for iT = 1:size(peth,2);
                %LLV
                keep = wentLeft==1&rwdSize==1&flavor==1;
                D{iT} = peth(keep,iT,iC);%D
                
                %LLC
                keep = wentLeft==1&rwdSize==1&flavor==0;
                C{iT} = peth(keep,iT,iC);%C
                
                %LSV
                keep = wentLeft==1&rwdSize==0&flavor==1;
                A{iT} =peth(keep,iT,iC); %A
                
                %LSC
                keep = wentLeft==1&rwdSize==0&flavor==0;
                B{iT} =peth(keep,iT,iC);%B
                
                %RLV
                keep = wentLeft==0&rwdSize==1&flavor==1;
                F{iT} = peth(keep,iT,iC);%F
                
                %RLC
                keep = wentLeft==0&rwdSize==1&flavor==0;
                E{iT} = peth(keep,iT,iC); %E   
                
                %RSV
                keep = wentLeft==0&rwdSize==0&flavor==1;
                G{iT} = peth(keep,iT,iC);%G    
                
                %RSC
                keep = wentLeft==0&rwdSize==0&flavor==0;
                H{iT} = peth(keep,iT,iC); %H 


            end
            
            temp_di_1 = cat(3,A,B,C,D,E,F,G,H);%1 = direction dichotomy
            di_1 = cat(1,di_1,temp_di_1);
            
            temp_di_2 = cat(3,A,B,C,E,D,F,G,H);%
            di_2 = cat(1,di_2,temp_di_2);
            
            temp_di_3 = cat(3,A,B,C,F,D,E,G,H);%
            di_3 = cat(1,di_3,temp_di_3);
            
            temp_di_4 = cat(3,A,B,C,G,D,E,F,H);%
            di_4 = cat(1,di_4,temp_di_4);
            
            temp_di_5 = cat(3,A,B,C,H,D,E,F,G);%
            di_5 = cat(1,di_5,temp_di_5);
            
            temp_di_6 = cat(3,A,B,D,E,C,F,G,H);%
            di_6 = cat(1,di_6,temp_di_6);
            
            temp_di_7 = cat(3,A,B,D,F,C,E,G,H);%
            di_7 = cat(1,di_7,temp_di_7);
            
            temp_di_8 = cat(3,A,B,D,G,C,E,F,H);%
            di_8 = cat(1,di_8,temp_di_8);
            
            temp_di_9 = cat(3,A,B,D,H,C,E,F,G);%
            di_9 = cat(1,di_9,temp_di_9);
                
            temp_di_10 = cat(3,A,B,E,F,C,D,G,H);%10 = side of value switch
            di_10 = cat(1,di_10,temp_di_10);
                
           temp_di_11 = cat(3,A,B,E,G,C,D,F,H);
            di_11 = cat(1,di_11,temp_di_11);
               
            temp_di_12 = cat(3,A,B,E,H,C,D,F,G);%
            di_12 = cat(1,di_12,temp_di_12);
     
            temp_di_13 = cat(3,A,B,F,G,C,D,E,H);%
            di_13 = cat(1,di_13,temp_di_13);
         
            temp_di_14 = cat(3,A,B,F,H,C,D,E,G);%
            di_14 = cat(1,di_14,temp_di_14);
        
            temp_di_15 = cat(3,A,B,G,H,C,D,E,F);%15 = size dichotomy 
            di_15 = cat(1,di_15,temp_di_15);
        
            temp_di_16 = cat(3,A,C,D,E,B,F,G,H);%
            di_16 = cat(1,di_16,temp_di_16);
       
            temp_di_17 = cat(3,A,C,D,F,B,E,G,H);%
            di_17 = cat(1,di_17,temp_di_17);
      
            temp_di_18 = cat(3,A,C,D,G,B,E,F,H);%
            di_18 = cat(1,di_18,temp_di_18);
            
            temp_di_19 = cat(3,A,C,D,H,B,E,F,G);%
            di_19 = cat(1,di_19,temp_di_19);
            
            temp_di_20 = cat(3,A,C,E,F,B,D,G,H);%
            di_20 = cat(1,di_20,temp_di_20);
         
           temp_di_21 = cat(3,A,C,E,G,B,D,F,H);
            di_21 = cat(1,di_21,temp_di_21);
             
            temp_di_22 = cat(3,A,C,E,H,B,D,F,G);%
            di_22 = cat(1,di_22,temp_di_22);

            temp_di_23 = cat(3,A,C,F,G,B,D,E,H);%
            di_23 = cat(1,di_23,temp_di_23);

            temp_di_24 = cat(3,A,C,F,H,B,D,E,G);%
            di_24 = cat(1,di_24,temp_di_24);
 
            temp_di_25 = cat(3,A,C,G,H,B,D,E,F);%
            di_25 = cat(1,di_25,temp_di_25);
   
            temp_di_26 = cat(3,A,D,E,F,B,C,G,H);%
            di_26 = cat(1,di_26,temp_di_26);
    
            temp_di_27 = cat(3,A,D,E,G,B,C,F,H);%
            di_27 = cat(1,di_27,temp_di_27);
    
            temp_di_28 = cat(3,A,D,E,H,B,C,F,G);%
            di_28 = cat(1,di_28,temp_di_28);
         
            temp_di_29 = cat(3,A,D,F,G,B,C,E,H);%29 = flavor dichotomy
            di_29 = cat(1,di_29,temp_di_29);
     
            temp_di_30 = cat(3,A,D,F,H,B,C,E,G);%
            di_30 = cat(1,di_30,temp_di_30);

           temp_di_31 = cat(3,A,D,G,H,B,C,E,F);
            di_31 = cat(1,di_31,temp_di_31);
            
            temp_di_32 = cat(3,A,E,F,G,B,C,D,H);%
            di_32 = cat(1,di_32,temp_di_32);

            temp_di_33 = cat(3,A,E,F,H,B,C,D,G);%
            di_33 = cat(1,di_33,temp_di_33);

            temp_di_34 = cat(3,A,E,G,H,B,C,D,F);%
            di_34 = cat(1,di_34,temp_di_34);
 
            temp_di_35 = cat(3,A,F,G,H,B,C,D,E);%
            di_35 = cat(1,di_35,temp_di_35);       

              
                              
            end

        end
end

cellResponses.di_1 = di_1;
cellResponses.di_2 = di_2;
cellResponses.di_3 = di_3;
cellResponses.di_4 = di_4;
cellResponses.di_5 = di_5;
cellResponses.di_6 = di_6;
cellResponses.di_7 = di_7;
cellResponses.di_8 = di_8;
cellResponses.di_9 = di_9;
cellResponses.di_10 = di_10;
cellResponses.di_11 = di_11;
cellResponses.di_12 = di_12;
cellResponses.di_13 = di_13;
cellResponses.di_14 = di_14;
cellResponses.di_15 = di_15;
cellResponses.di_16 = di_16;
cellResponses.di_17 = di_17;
cellResponses.di_18 = di_18;
cellResponses.di_19 = di_19;
cellResponses.di_20 = di_20;
cellResponses.di_21 = di_21;
cellResponses.di_22 = di_22;
cellResponses.di_23 = di_23;
cellResponses.di_24 = di_24;
cellResponses.di_25 = di_25;
cellResponses.di_26 = di_26;
cellResponses.di_27 = di_27;
cellResponses.di_28 = di_28;
cellResponses.di_29 = di_29;
cellResponses.di_30 = di_30;
cellResponses.di_31 = di_31;
cellResponses.di_32 = di_32;
cellResponses.di_33 = di_33;
cellResponses.di_34 = di_34;
cellResponses.di_35 = di_35;
end


