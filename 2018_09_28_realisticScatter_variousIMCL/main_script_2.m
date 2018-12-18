%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('I:/backup/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
tof_cell6 = zeros(200,100,25,5);
frq = 500e3;
kk = 2;
for ii = 1:25
    myfilename = sprintf('/data/kwave/medium/2018_09_28_realisticScatter_variousIMCL/case%d_IMCL%0.1f.mat',ii,kk/10);
    load(myfilename)
    param.source.point_map = cast(linspace(1,100,100),'int8');
    param.source.waveform.freq = frq;
    param.t_end = 1e-04;
    pathname = sprintf('I:/backup/data/kwave/result/2018_09_28_realisticScatter_variousIMCL/case%d_IMCL%0.1f/',ii,kk/10);
    dst_path = pathname;
    simulate_usct(param, medium, dst_path);
    cd(pathname)
    load('rfdata.mat')
    load('kgrid.mat')
    tof_data = threshold_picker( rfdata,kgrid,500 );
    tof_cell6(:,:,ii,2) = tof_data;
end

save('I:\backup\data\kwave\result\2018_09_28_realisticScatter_variousIMCL/tof_cell6','tof_cell6');