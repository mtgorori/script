%% script for running the function simulate_usct
clear; close all;
addpath(genpath('\USCTSim-master'))
addpath(genpath('\codes'))
cd('\data\kwave\param')
load('param_2board.mat')
cd('\data\kwave\medium\2018_09_04_angleScatter')
load property.mat
kgrid= makeGrid(param.grid.Nx, param.grid.dx, param.grid.Ny, param.grid.dy);
tof_cell  = zeros(200,100,10);%{Receiver, Transmitter, ERate, Num, }
aveSOS = zeros(1,10);%{ERate, Num}
steSOS = zeros(1,10);
aveSOS2 = zeros(1,10);%{ERate, Num}
steSOS2_0 = zeros(100,10);
steSOS2 = zeros(1,10);
leng = zeros(1,100);
leng2 = zeros(1,100);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;

for ii = 1:length(angles)
    cd \data\kwave\medium\2018_09_04_angleScatter
    myfilename = sprintf('case%d',ii);
    load(myfilename);
    param.source.point_map = cast(linspace(1,100,100),'int8');
    cd \data\kwave\result\2018_09_04_angleScatter
    dst_path = myfilename;
    simulate_usct(param, medium, dst_path);
    cd(myfilename)
    load('rfdata.mat')
    load('kgrid.mat')
    tof_data = threshold_picker( rfdata,kgrid );
    cd('\result\2018_09_04_angleScatter');
    save(myfilename,'tof_data');
    tof_cell(:,:,ii) = tof_data;
    [Min,ind]= min(tof_cell(101:end,:,ii));
    ind = ind+100;
    for k = 1: t_num/2
        leng(1,k) = norm(t_pos(:,k)-t_pos(:,ind(1,k)));
    end
    aveSOS(1,ii) =sum(leng./Min)/(t_num/2);
    steSOS(1,ii) =std(leng./Min,0,2)/sqrt(t_num/2);
    for k = 1: t_num/2
        leng2(1,k) = norm(t_pos(:,k)-t_pos(:,100+k));
    end
    for jj = 1:t_num/2
        aveSOS2(1,ii) = aveSOS2(1,ii) + leng2(1,jj)/tof_cell(jj+100,jj,ii);
        steSOS2_0(jj,ii) = leng2(1,jj)/tof_cell(jj+100,jj,ii);
    end
    aveSOS2(1,ii) = aveSOS2(1,ii)/(t_num/2);
    steSOS2(1,ii) = std(steSOS2_0(:,ii))/sqrt(t_num/2);
end

 cd('\result\2018_09_04_angleScatter');
myfilename = sprintf('2018_09_04_aveSOS&steSOS');
save(myfilename,'aveSOS','steSOS','tof_cell','aveSOS2','steSOS2','angles');