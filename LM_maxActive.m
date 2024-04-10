function [maxActive] = LM_maxActive(ranked,varargin);
%find percent of cells maximally active during trial epochs

%get ranked from LM_sortPeakNorm
process_varargin(varargin);


%preallocate space
maxLocation = nan(length(ranked),1);

    [max_num,max_idx] = max(ranked(:,:),[],2,'omitnan');
   

%truncate beginning of trial onset

    for i = 1:length(max_idx);%for truncated trial length          
            if max_idx(i) < 11; %fixation
             maxLocation(i) = 1;   
        elseif (max_idx(i) < 21  & max_idx(i) > 10 );%odor sampling
            maxLocation(i) = 2; 
        elseif (max_idx(i) < 30  & max_idx(i) > 21 );%movement
            maxLocation(i) = 3; 
        elseif (max_idx(i) < 40  & max_idx(i) > 29 );%Outcome anticipation
            maxLocation(i) = 4; 
        elseif (max_idx(i) < 58  & max_idx(i) > 39 );%Outcome consumption
            maxLocation(i) = 5; 
        end
    end
    
 


    tot_Fixation = (sum(maxLocation == 1));
    Fixation = (sum(maxLocation == 1)/length(maxLocation))*100;

    tot_OdorSampling = (sum(maxLocation ==2));
    OdorSampling = (sum(maxLocation ==2)/length(maxLocation))*100;

    tot_Movement = (sum(maxLocation ==3));
    Movement = (sum(maxLocation ==3)/length(maxLocation))*100;

    tot_OutcomeAnticipation = (sum(maxLocation == 4));
    OutcomeAnticipation = (sum(maxLocation == 4)/length(maxLocation))*100;

    tot_OutcomeConsumption=(sum(maxLocation == 5));
    OutcomeConsumption = (sum(maxLocation == 5)/length(maxLocation))*100;
    Pop_size = length(maxLocation);



    
    maxActive.Fixation = Fixation;
    maxActive.tot_Fixation =tot_Fixation;
    
    maxActive.OdorSampling = OdorSampling;
    maxActive.tot_OdorSampling=tot_OdorSampling;
     
    maxActive.Movement = Movement;
    maxActive.tot_Movement=tot_Movement;
    
    maxActive.OutcomeAnticipation = OutcomeAnticipation;
    maxActive.tot_OutcomeAnticipation=tot_OutcomeAnticipation;
    
    maxActive.OutcomeConsumption =  OutcomeConsumption;
    maxActive.tot_OutcomeConsumption = tot_OutcomeConsumption;
    maxActive.Pop_size=Pop_size;
    
    