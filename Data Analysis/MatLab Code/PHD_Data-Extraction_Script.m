
% - This first line is to select the folder I want
folder_name = uigetdir

% - Now that you've selected the folder, execute all these lines of code
A = folder_name;
pth = strcat(A,'\');
rawlist = getrawdata(pth,'randycode');
% = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 

c_rawlist = lev_prob(rawlist.data);
Var = c_rawlist;

[PHD_DAT] = phd_dat(Var);
[HOLD_TIMES] = hold_times(c_rawlist);








