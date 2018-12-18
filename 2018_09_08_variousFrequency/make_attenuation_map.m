frq = [1000e3, 500e3, 200e3, 100e3, 50e3];
attenuation_cell = zeros(200,100,25,5);
for jj = 1:5
    for ii = 1:25
        pathname = sprintf('I:/backup/data/kwave/result/2018_09_08_variousFrequency/case%d_Freq%d/',ii,frq(jj)/(1e3));
        cd(pathname)
        load('rfdata.mat')
        load('kgrid.mat')
        attenuation_cell(:,:,ii,jj) = threshold_picker(rfdata,kgrid,cast(frq(jj)/1e3,'int16'));
        disp('done')
    end
end
pathname = sprintf('/data/kwave/result/2018_09_08_variousFrequency');
cd(pathname)
save('attenuation_cell','attenuation_cell');