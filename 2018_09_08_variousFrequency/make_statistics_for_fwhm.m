load("/data/kwave/result/2018_09_08_variousFrequency/statistics.mat")
load("/data/kwave/result/2018_09_08_variousFrequency/fwhm_cell.mat")
fwhm_cell = fwhm_cell';
load("/data/kwave/result/2018_09_08_variousFrequency/profile_transfer.mat")

save("/data/kwave/result/2018_09_08_variousFrequency/statistics2.mat",...
    "aveSOS","aveSOS2",'diff_point_each','steSOS','steSOS2','tof_cell','varDiff_Point','frq','rate_EMCLs','fwhm_cell','profile_transfer')

cd '/data/kwave/result/2018_09_08_variousFrequency'
csvwrite('fwhm_cell.csv',fwhm_cell);