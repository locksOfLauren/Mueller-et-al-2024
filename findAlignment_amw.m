function ix = findAlignment_amw(tsd,times)

ix = NaN(length(times),1);
for iT = 1:length(times);
   [~, ix(iT)] = min(abs(tsd.range-times(iT)));
end