%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
frq = 2e6;
% frq = 500e3;
tof_cell = zeros(200,1,10,5);%dim={receiver, transmitter, width, unvoid}
for ii = 5:5:50
    for jj = 0:5:20
        myfilename = sprintf('H:/data/kwave/medium/2018_10_18_IMCLpath_variousSize/case8_IMCL_width_%dmm_void_%0.1f%%.mat',2*ii/10,(jj*2/400)*100);
        load(myfilename)
        param.source.point_map = cast(linspace(50,50,1),'int8');
        param.source.waveform.freq = frq;
        param.t_end = 1e-04;
        pathname = sprintf('H:/data/kwave/result/2018_10_18_IMCLpath_variousSize/case8_IMCL_width_%dmm_void_%0.1f%%_2MHz',2*ii/10,(jj*2/400)*100);
        dst_path = pathname;
        simulate_usct(param, medium, dst_path);
        cd(pathname)
        load('rfdata.mat')
        load('kgrid.mat')
        tof_data = threshold_picker( rfdata,kgrid,500 );
        save('tof_data.mat','tof_data');
        tof_cell(:,1,ii/5,jj/5+1) = tof_data;
    end
end
save('H:/data/kwave/result/2018_10_18_IMCLpath_variousSize/tof_cell_frq2MHz.mat','tof_cell');
