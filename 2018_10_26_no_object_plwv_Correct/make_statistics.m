load  /data/kwave/result/2018_10_15_variousFrequency_Correct/tof_cell.mat
load('/data/kwave/medium/2018_09_28_realisticScatter_variousIMCL/corrected/rate_EMCLs.mat','rate_EMCLs')
load("H:/data/configration/transducer_2board.mat")
rate_EMCLs = repmat(rate_EMCLs,6,1);
frq = [2000e3, 1000e3, 500e3, 200e3, 100e3, 50e3];
frq = frq';
frq = repmat(frq,1,25);
aveSOS_plwv = zeros(6,25);
load("H:/data/kwave/result/2018_10_15_variousFrequency_Correct/statistics.mat")
for jj = 3
    for ii = 1:25
        pathname = sprintf('H:/data/kwave/result/2018_10_15_variousFrequency_Correct/case%d_Freq%d/',ii,frq(jj)/(1e3));
        cd(pathname)
        load('rfdata.mat')
        load('kgrid.mat')
        time = threshold_picker_plnwv(rfdata,kgrid,'single');
        aveSOS_plwv(jj,ii) = t_facing_distance/time;
    end
end

cd('H:/data/kwave/result/2018_10_15_variousFrequency_Correct/')
save('statistics.mat','aveSOS','aveSOS2','diff_point_each','frq','rate_EMCLs','steSOS','steSOS2','tof_cell','varDiff_Point','aveSOS_plwv')
cd 'H:/data/kwave/result/2018_10_15_variousFrequency_Correct/'
csvwrite('aveSOS_plw.csv',aveSOS_plwv);