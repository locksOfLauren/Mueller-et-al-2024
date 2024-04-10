function [out]=segmented_behErrs_shifted_NComms(c_err,varargin);

%used for paper
%takes errs output from betweenChoice_errs, segment to match d' segments
process_varargin(varargin);

 %all errors, 2 sessions grouped, used session 2 as first session because
 %first recording session doesn't have enough units, matach with recording
 %session
c_1 = c_err.prcntAll_errs(c_err.sessions>1 & c_err.sessions<4);%2-4
c_1 = nanmean(c_1);
c_2 = c_err.prcntAll_errs(c_err.sessions>3 &c_err.sessions<6);%3-4
c_2 = nanmean(c_2);
c_3 = c_err.prcntAll_errs(c_err.sessions>5 &c_err.sessions<8);%5-6
c_3 = nanmean(c_3);
c_4 = c_err.prcntAll_errs(c_err.sessions>7 &c_err.sessions<10);%7-8
c_4 = nanmean(c_4);
c_5 = c_err.prcntAll_errs(c_err.sessions>9 &c_err.sessions<12);%9-10
c_5 = nanmean(c_5);
c_6 = c_err.prcntAll_errs(c_err.sessions>11 &c_err.sessions<14);%11-12
c_6 = nanmean(c_6);
c_7 = c_err.prcntAll_errs(c_err.sessions>13 &c_err.sessions<16);%13-14
c_7 = nanmean(c_7);
c_8 = c_err.prcntAll_errs(c_err.sessions>15 &c_err.sessions<18);%15-16
c_8 = nanmean(c_8);

allErrs_2bin_session = cat(1,c_1,c_2,c_3,c_4,c_5,c_6,c_7,c_8);



out.allErrs_2bin_session=allErrs_2bin_session;

