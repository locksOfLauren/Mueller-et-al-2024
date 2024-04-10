function [out] = betweenChoice_errs_withinChoiceErr_NComms(behVals,varargin);

%USED 
process_varargin(varargin);
%behVals = output from LM_forced_free_errs

%objectives
%1- how many times is there a correct free choice trial, optimal reward size
%chosen, with the following forced choice trial incorrect
postFree_forcedErr = [];

%2- how many occurences is there a free choice following a forced choice
free_forced_occ = [];

%3- how many times is there a correct forced choice trial followed by a suboptimal
%free choice
postForced_freeErr = [];

%4- how many occurences is there a forced choice following a free choice
forced_free_occ = [];

%5- types of errors combined
acrossChoice_err = [];

%6- total occurences 
acrossChoice_occ = [];

%%
%7- how many times is there a correct free choice trial, optimal reward size
%chosen, with the following free choice trial incorrect
postFree_freeErr = [];

%8- how many occurences is there a free choice following a forced choice
free_free_occ = [];

%9- how many times is there a correct forced choice trial, with the following forced choice trial incorrect
postForced_forcedErr = [];

%10- how many occurences is there a free choice following a forced choice
forced_forced_occ = [];


%5- within errors combined
withinChoice_err = [];

%6- total occurences 
withinChoice_occ = [];


prcntFree_forcedErr = [];
prcntForced_freeErr = [];
prcntAll_errs = [];

prcntFree_freeErr = [];
prcntForced_forcedErr = [];
prcentAll_withinErrs = [];

for i = 1:length(behVals.sessions)
    %temp_trials = behVals.trialNumber{i};
    temp_forced_error = behVals.forced_error{i};
    temp_free_error = behVals.free_error{i};%suboptimal
    temp_forced_correct = behVals.forced_correct{i};
    temp_free_correct = behVals.free_correct{i};
    temp_free = behVals.free{i};
    temp_forced = behVals.forced{i};
    
    % objective 1
    for iA = 1:length(temp_free_correct)-1;
        if temp_free_correct(iA)==1 & temp_forced_error(iA+1)==1;
            temp_postFree_forcedErr(iA) = 1;
        else temp_postFree_forcedErr(iA) = 0;
        end
    end
    
    % objective 2
    for iB = 1:length(temp_free)-1;
        if temp_free(iB) == 1 & temp_forced(iB+1) == 1 
            temp_free_forced_occ(iB) = 1;
        else temp_free_forced_occ(iB) = 0;
        end
    end
    
    
    % objective 3
    
    for iC = 1:length(temp_forced_correct)-1;
        if temp_forced_correct(iC)==1 & temp_free_error(iC+1)==1;
            temp_postForced_freeErr(iC) = 1;
        else temp_postForced_freeErr(iC) = 0;
        end
    end
    
    %objective 4
    
        for iD = 1:length(temp_forced)-1;
             if temp_forced(iD) == 1 & temp_free(iD+1) == 1 
            temp_forced_free_occ(iD) = 1;
            else temp_forced_free_occ(iD) = 0;
             end
        end
        
        % objective 5
       temp_acrossChoice_err = temp_postForced_freeErr == 1 | temp_postFree_forcedErr == 1;
       
       % objective 6
       temp_acrossChoice_occ = temp_forced_free_occ ==1|temp_free_forced_occ ==1;
        
        
        temp_prcntFree_forcedErr = (sum(temp_postFree_forcedErr)/sum(temp_free_forced_occ))*100;
        temp_prcntForced_freeErr = (sum(temp_postForced_freeErr)/sum(temp_forced_free_occ))*100;
        temp_prcntAll_errs = sum(temp_acrossChoice_err)/sum(temp_acrossChoice_occ)*100;
        
        %%
           % objective 7
    for iE = 1:length(temp_free_correct)-1;
        if temp_free_correct(iE)==1 & temp_free_error(iE+1)==1;
            temp_postFree_freeErr(iE) = 1;
        else temp_postFree_freeErr(iE) = 0;
        end
    end
    
    %% objective 8
    for iF = 1:length(temp_free)-1;
        if temp_free(iF) == 1 & temp_free(iF+1) == 1 
            temp_free_free_occ(iF) = 1;
        else temp_free_free_occ(iF) = 0;
        end
    end
    
        
  %% objective 9

  
      for iG = 1:length(temp_forced_correct)-1;
        if temp_forced_correct(iG)==1 & temp_forced_error(iG+1)==1;
            temp_postForced_forcedErr(iG) = 1;
        else temp_postForced_forcedErr(iG) = 0;
        end
      end
    
      %% objective 10
      
          for iH = 1:length(temp_forced)-1;
        if temp_forced(iH) == 1 & temp_forced(iH+1) == 1 
            temp_forced_forced_occ(iH) = 1;
        else temp_forced_forced_occ(iH) = 0;
        end
          end
    
           %% objectives 11 and 12
           
                   % objective 11
       temp_withinChoice_err = temp_postForced_forcedErr == 1 | temp_postFree_freeErr == 1;
       
       % objective 12
       temp_withinChoice_occ = temp_forced_forced_occ ==1|temp_free_free_occ ==1;
        
        
        temp_prcntFree_freeErr = (sum(temp_postFree_freeErr)/sum(temp_free_free_occ))*100;
        temp_prcntForced_forcedErr = (sum(temp_postForced_forcedErr)/sum(temp_forced_forced_occ))*100;
        temp_prcentAll_withinErrs = sum(temp_withinChoice_err)/sum(temp_withinChoice_occ)*100;
  


  prcntFree_forcedErr = cat(1,prcntFree_forcedErr,temp_prcntFree_forcedErr);
  prcntForced_freeErr = cat(1,prcntForced_freeErr,temp_prcntForced_freeErr);
  prcntAll_errs = cat(1,prcntAll_errs,temp_prcntAll_errs);
  
    prcntFree_freeErr = cat(1,prcntFree_freeErr,temp_prcntFree_freeErr);
    prcntForced_forcedErr = cat(1,prcntForced_forcedErr,temp_prcntForced_forcedErr);
    prcentAll_withinErrs = cat(1,prcentAll_withinErrs,temp_prcentAll_withinErrs);
  
  
  out.prcntAll_errs =prcntAll_errs;
  out.prcntFree_forcedErr = prcntFree_forcedErr;
  out.prcntForced_freeErr = prcntForced_freeErr;
  out.sessions = behVals.sessions;
  out.ID = behVals.ID;
  out.prcntFree_freeErr = prcntFree_freeErr;
 out.prcntForced_forcedErr = prcntForced_forcedErr;
out.prcentAll_withinErrs = prcentAll_withinErrs;

end
  
  

