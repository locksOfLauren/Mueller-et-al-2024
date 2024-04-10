function [pw,vw,asy,v2p] = LM_waveWidths(mWV)

%mWV is the mean waveform of a unit
%To be consistent, should we call mWV just wv like you do in the
%amw_ClassifyCells_FsiMsn function?

nPoints = length(mWV);% define the variable nPoints, nPoints is the length of mWV (mWV is a cell array generated as the second output of the amw_GetAllWaveforms function,each row in the array represents the wave values of one unit)

%convert waveforms into time durations

if nPoints>100; %If the value of nPoints is greater than 100 is true,then divide the value by 10, and further divide by 40,000 (since the units were sampled at 40000Hz) and multiply by 1000 to convert into time duration. Call the duration, windowLen.
    windowLen = ((nPoints/10)/40000)*1000; %Why do we care if nPoints is greater than 100?
else 
    windowLen = (nPoints/40000)*1000;%Otherwise,divide nPoints by the sample rate and multiply by 1000 to convert into duration and call the duration windowLen
end

%Change format if it's weird

if length(mWV)~=size(mWV,1);%If the length of the cell array mWV does not equal the size of the first dimension of the mWV matrix is true, then switch it.
    mWV = mWV';% At some point mWV is obviously organized in an undesirable way so we want to switch the orientation?
end


% find peak & valley; assume one peak & take valley that follows it
[pval,pind] = max(mWV);%find the maximum value in the mWV vector, output this value as pval (peak value), also output pind (peak index) to indicate where max value occurs
[vval,vind] = min(mWV(pind:end)); %find the minimum value in the mWV vector that occurs after the point at which the peak was found,output this value as vval (valley value), also output vind (valley index) to indicate where min value occurs 
vind = vind + pind - 1;%Change vind to the previous vind value plus one spot beyond the pind value. I believe the purpose of this is to find the length between valley and peak, but I'm not sure why we take one spot beyond the peak?
[vval2,vvald2] = min(mWV(1:pind));%find the minimum value in the mWV vector that occurs before the point at which the peak is found,output this value as vval2 (valley value 2), also output vvald2 (valley index 2, you don't wind up using this) to indicate where the value occurs

% find half-widths, peak
%Does this look at before and after peak separately?

half = pval / 2;% calculate half peak, divide pval by 2 and call it half
temp = mWV(1:pind) - half; %first look at the beginning of the peak. Within mWV take the values from the beginning of the vector until the peak occurs and subtract the half peak value from each row, name this vector of values temp
temp(temp < 0) = NaN;%if any of the values within the temp vector are below zero replace values with NaNs
%first sample above half, now check which one is closer
[vpre_peakH,ipre_peakH] = min(temp); % Find the minimum within the updated vector of values, output the minimum value as vpre_peakH, and the location of minimum value as ipre_peakH
%Does ipre_peakH tell us the point at which the rise to the peak starts?


%I'm lost, I'm not sure why we are doing these separately and comparing? 

if ipre_peakH < 1%if the location of the lowest value is less than 1 is true(I guess I don't really understand how this would be possible since you replaced anything below zero with NaN)
    if abs(mWV(ipre_peakH) - half) > abs(mWV(ipre_peakH - 1) - half)%And if the absolute value of the minimum in the vector mWV that is above zero and occurs before the peak minus half the peak value is greater than
        %the absolute value of the minimum in the vector mWV that is above
        %zero and occurs before the peak minus one minus half the peak value is true,
        %Why not just use ipre_peakH instead of mWV(ipre_peakH) - half?
        ipre_peakH = ipre_peakH - 1; %Then subtract one from the location of the minimum in the vector mWV that is above zero and occurs before the peak and call it ipre_peakH
    end
end

%Are we looking after the peak now?
temp = mWV(pind:end) - half;  %look at the fall of the peak. Within mWV take the values from the peak until the end of the wave and subtract the half peak value from each row, name this vector of values temp
temp(temp < 0) = NaN;%if any of the values within the temp vector are below zero replace values with NaNs
% first sample above half, now check which one is closer
[vpost_peakH,ipost_peakH] = min(temp); %Find the minimum within the updated vector of values, output the minimum value as vpost_peakH, and the location of minimum value as ipost_peakH
%Does ipost_peakH tell us the point at which the fall of the peak ends?
ipost_peakH = ipost_peakH + pind - 1;%Add the location of the minimum point after the peak to the location of the peak itself and subtract one,call this point ipost_peakH
if ipost_peakH == nPoints %if ipost_peakH (the sum of the minimum point after the peak and the peak minus one) is the same as nPoints (the length of mWV)is true
    ipost_peakH = nPoints-1;%Then subtract one from nPoints and call it ipost_peakH
end

%Compare
if abs(mWV(ipost_peakH) - half) > abs(mWV(ipost_peakH + 1) - half)%If the absolute value of the minimum in the vector mWV that is above zero and occurs after the peak minus half the peak value is greater than
        %the absolute value of the minimum in the vector mWV that is above
        %zero and occurs after the peak plus one minus half the peak value is true,
        %Why not just use ipost_peakH instead of mWV(ipost_peakH) - half?
   ipost_peakH = ipost_peakH + 1; %Then add one to the location of the minimum in the vector mWV that is above zero and occurs before the peak and call it ipost_peakH
end

% find half-widths, valley
mWVi = -mWV;%Take the mWV vector (the mean waveform of a unit)and multiply values by negative one, call it mWVi
half = -vval / 2;% Calculate half valley by taking the -vval (now positive value of the valley of mWV), divide it in half and call it half 
%I think we are inverting these so that they are positive values but why does that matter?
temp = mWVi(pind:vind) - half; %Take the values occuring between the peak and the valley of vector mWVi and subtract half valley from each row, call new vector temp
temp(temp < 0) = NaN;%Replace values occuring within temp that are below zero with NaNs

% first sample below half, now check which one is closer
[vpre_valH,ipre_valH] = min(temp); %Find the lowest value occuring between the peak and the valley of vector mWVi (now with half valley subtracted)that is above zero, output the minimum value as vpre_valH, and the location of minimum value as ipre_valH.
%Is this finding the start of the valley?
ipre_valH = ipre_valH + pind - 1;%Add the location of the lowest value of the valley to the location of the peak subtract one and call it ipre_valH
if abs(mWVi(ipre_valH) - half) > abs(mWVi(ipre_valH - 1) - half)%If the absolute value of the number occuring at ipre_valH in the mWVi vector minus half valley is greater than the absolute value of the number occuring at ipre_valH in the mWVi vector minus one minus half valley is true
   ipre_valH = ipre_valH - 1; %Then subtract one from the location ipre_valH and call it ipre_valH
end

temp = mWVi(vind:end) - half; temp(temp < 0) = NaN;%Take the values between the valley until the end of vector mWVi and subtract half valley from each row, call new vector temp, replace all zeros with NaNs
% first sample above half, now check which one is closer
[vpost_valH,ipost_valH] = min(temp);%Find the lowest value between the valley and the end of vector mWVi (now with half valley subtracted)that is above zero, output the minimum value as vpost_valH, and the location of minimum value as ipost_valH.
ipost_valH = ipost_valH + vind - 1;%subtract one from the location ipost_valH plus the location of the valley and call it ipost_valH

if ipost_valH < nPoints%If the location ipost_valH is less than nPoints(the length of mWV)
    if abs(mWVi(ipost_valH) - half) > abs(mWVi(ipost_valH + 1) - half) %And the absolute value of the number occuring at ipost_valH in the mWVi vector minus half valley is greater than the absolute value of the number occuring at ipost_valH in the mWVi vector minus one minus half valley is true
        ipost_valH = ipost_valH + 1;%Then add one to the location ipost_valH and call it ipost_valH 
    end
end

pw = (ipost_peakH - ipre_peakH)*(windowLen/nPoints);%calculation for peak width output, subtract the ipre_peakH location (beginning until the peak)from ipost_peakH location (peak to end), multiply by duration divided by length of the mean waveform of a unit
vw = (ipost_valH - ipre_valH)*(windowLen/nPoints);%calculation for valley width output, subtract the ipre_valH location (peak to valley)from ipost_valH location (valley to end), multiply by duration divided by length of the mean waveform of a unit
asy = ((-vval2)-(-vval)) / ((-vval2)+(-vval));% I think you're finding the difference between the valleys that occur both before and after the peak and then calculating some sort of asymmetrical valley ratio?
v2p = (vind-pind)*(windowLen/nPoints);%calculation for valley to peak output, subtract the location of the peak from the location of the valley, multiply by duration divided by length of the mean waveform of a unit

%show when there are weird values 
if pw < 0 | vw < 0 %if peak width is less than zero or valley width is less than zero throw this error message
   disp('Error: durations < 0'); 
end