frq = [2000e3, 1000e3, 500e3, 200e3, 100e3, 50e3];
tof_cell = zeros(200,100,25,6);
for jj = 1:6
    for ii = 1:25
        %     pathname = sprintf('/data/kwave/result/2018_09_08_variousFrequency/case%d_Freq%d/',ii,frq(jj)/(1e3));
        pathname = sprintf('/data/kwave/result/2018_09_08_variousFrequency/Corrected/case%d_Freq%d/',ii,frq(jj)/(1e3));
        cd(pathname)
        load('rfdata.mat')
        load('kgrid.mat')
        tof_cell(:,:,ii,jj) = threshold_picker(rfdata,kgrid,frq(jj)/1e3);
        disp('done')
    end
end
pathname = sprintf('/data/kwave/result/2018_09_08_variousFrequency/Corrected');
cd(pathname)
save('tof_cell','tof_cell');

