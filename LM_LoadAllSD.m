function sd = LM_LoadAllSD(fn,varargin)

%process_varargin(varargin);

sd = cell(size(fn));
for iS = 1:length(fn);

   sd_temp = LM_LoadSessionData(fn{iS});
    sd_temp = LM_ParseStrobes(sd_temp);%original
      if isempty(sd_temp.beh.sessionStartTime);
       disp('Behavior error')
   else
       sd{iS} = sd_temp;
   end
end