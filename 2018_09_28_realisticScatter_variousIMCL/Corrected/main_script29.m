%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('//Ht-pc/h/USCTSim-master'))
addpath(genpath('//Ht-pc/h/codes/TOF_pickers'))

frq = 500e3;
kk = 38;
for ii = 1:75
    myfilename = sprintf('//Ht-pc/h/data/kwave/medium/2018_09_28_realisticScatter_variousIMCL/corrected/case%d_IMCL%0.1f.mat',ii,kk/10);
    load(myfilename)
    param.source.point_map = cast(linspace(1,100,100),'int8');
    param.source.waveform.freq = frq;
    param.t_end = 1e-04;
    pathname = sprintf('//Ht-pc/h/data/kwave/result/2018_10_15_realisticScatter_variousIMCL_Correct/case%d_IMCL%0.1f/',ii,kk/10);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
    cd(pathname)
    load('rfdata.mat')
    load('kgrid.mat')
    tof_data = threshold_picker( rfdata,kgrid,500 );
    savefilename = sprintf('//Ht-pc/h/data/kwave/result/2018_10_15_realisticScatter_variousIMCL_Correct/case%d_IMCL%0.1f/tof_data',ii,kk/10');
    save(savefilename,'tof_data');
end