%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('\USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
tof_cell15 = zeros(200,100,75,11);
frq = 500e3;
kk = 10;
for ii = 26:75
    myfilename = sprintf('/data/kwave/medium/2018_09_28_realisticScatter_variousIMCL/corrected/case%d_IMCL%0.1f.mat',ii,kk/10);
    load(myfilename)
    param.source.point_map = cast(linspace(1,100,100),'int8');
    param.source.waveform.freq = frq;
    param.t_end = 1e-04;
    pathname = sprintf('/data/kwave/result/2018_09_28_realisticScatter_variousIMCL/Correct/case%d_IMCL%0.1f/',ii,kk/10);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
    cd(pathname)
    load('rfdata.mat')
    load('kgrid.mat')
    tof_data = threshold_picker( rfdata,kgrid,500 );
    tof_cell15(:,:,ii,6) = tof_data;
end

save('/data/kwave/result/2018_09_28_realisticScatter_variousIMCL/Correct/tof_cell15','tof_cell15');