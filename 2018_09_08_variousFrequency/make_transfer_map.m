load('/data/kwave/result/2018_09_08_variousFrequency/tof_cell_valid.mat')
frq = [2000e3, 1000e3, 500e3, 200e3, 100e3, 50e3];
fwhm_cell = zeros(25,6);
profile_fwhm = zeros(100,25,6);
for jj = 2:6
    for ii = 1:25
        pathname = sprintf('I:/backup/data/kwave/result/2018_09_08_variousFrequency/case%d_Freq%d',ii,frq(jj)/(1e3));
        cd(pathname)
        load('rfdata.mat')
        load('kgrid.mat')
        center_time = round(tof_cell(150,50,ii,jj)/kgrid.dt);
        profile_fwhm(:,ii,jj) = sum(abs(rfdata(round(center_time):round(center_time)+100,101:200,50)),1);
        fwhm_cell(ii,jj) = fwhm(profile_fwhm(:,ii,jj),1:100);
        figure(1);
        plot(profile_fwhm(:,ii,jj));
        xlabel('ëféqî‘çÜ');
        ylim([0 2])
        myfilename0 = sprintf('/case%d_freq%d',ii,frq(jj)/(1e3));
        myfilename = strcat('/data/kwave/result/2018_09_08_variousFrequency/fwhm_profiles',myfilename0);
        exportfig(myfilename,'png',[300,300]);
        disp('done')
    end
end
pathname = sprintf('/data/kwave/result/2018_09_08_variousFrequency');
cd(pathname)
save('fwhm_cell','fwhm_cell');
save('profile_fwhm','profile_fwhm');