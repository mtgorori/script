%% script for running the function simulate_usct
% clear; close all;
addpath(genpath('/USCTSim-master'))
addpath(genpath('/codes/TOF_pickers'))
IMCL_rate = linspace(0,20,21);
frq = 5e6;
for ii = 5
    for jj = 1:3
        myfilename = sprintf('H:/data/kwave/medium/2018_11_07_layer_medium/Layer_medium_boundary_%0.1fmm_ IMCL%d%%.mat',...
            ii,IMCL_rate(jj));
        load(myfilename)
        param.source.point_map = cast(linspace(1,100,100),'int8');
        param.source.waveform.freq = frq;
        param.t_end = 1e-04;
        pathname = sprintf('H:/data/kwave/result/2018_12_13_layer_medium_various/SA/boundary_%0.1fmm_IMCL%d%%/',...
            ii,IMCL_rate(jj));
        dst_path = pathname;
        simulate_usct(param, medium, dst_path);
    end
end