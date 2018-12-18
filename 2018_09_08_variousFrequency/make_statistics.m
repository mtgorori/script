load  /data/kwave/result/2018_09_08_variousFrequency/tof_cell_valid.mat
tmp_tof_cell = tof_cell;
load("/data/kwave/result/2018_08_12_realisticScatter/statistics.mat","tof_cell","rate_EMCLs")
disp(size(tmp_tof_cell))
rate_EMCLs = repmat(rate_EMCLs,6,1);
cat_tof_cell = cat(4,tof_cell,tmp_tof_cell);
tof_cell = cat_tof_cell;
frq = [2000e3, 1000e3, 500e3, 200e3, 100e3, 50e3];
frq = frq';
frq = repmat(frq,1,25);
aveSOS = zeros(6,25);%{frq, Num}
steSOS = zeros(6,25);
aveSOS2 = zeros(6,25);%{frq, Num}
steSOS2_0 = zeros(100,6,25);
steSOS2 = zeros(6,25);
varDiff_Point = zeros(6,25);
leng = zeros(1,100);
leng2 = zeros(1,100);
t_size = 40.e-3;
t_num = 200;%トランスデューサ数
r_num = t_num/2;
diff_point_each = zeros(r_num, 6,25);
t_pos = zeros(2, t_num);%センサ位置
t_pos(1,1:t_num/2) = -t_size/2:t_size/(t_num/2-1):t_size/2 ;%素子水平方向距離[m]
t_pos(2,1:t_num/2) = t_size/2;
t_pos(1,t_num/2+1:t_num) = t_pos(1,1:t_num/2);
t_pos(2,t_num/2+1:t_num) = -t_size/2;
for jj = 1:6
    for ii = 1:25
        [Min,ind]= min(cat_tof_cell(101:end,:,ii,jj),[],1);
        ind = ind+100;
        for k = 1: t_num/2
            leng(1,k) = norm(t_pos(:,k)-t_pos(:,ind(1,k)));
        end
        aveSOS(jj,ii) =sum(leng./Min)/(t_num/2);
        steSOS(jj,ii) =std(leng./Min,0,2)/sqrt(t_num/2);
        for k = 1: t_num/2
            leng2(1,k) = norm(t_pos(:,k)-t_pos(:,100+k));
        end
        for k = 1:t_num/2
            aveSOS2(jj,ii) = aveSOS2(jj,ii) + leng2(1,k)/cat_tof_cell(k+100,k,ii,jj);
            steSOS2_0(k,jj,ii) = leng2(1,k)/cat_tof_cell(k+100,k,ii,jj);
            diff_point_each(k,jj,ii) = (ind(1,k)-100) - k;
        end
        aveSOS2(jj,ii) = aveSOS2(jj,ii)/(t_num/2);
        steSOS2(jj,ii) = std(steSOS2_0(:,jj,ii))/sqrt(t_num/2);
        varDiff_Point(jj,ii) = var(diff_point_each(:,jj,ii),1,1);
    end
end

save("/data/kwave/result/2018_09_08_variousFrequency/statistics.mat",...
    "aveSOS","aveSOS2",'diff_point_each','steSOS','steSOS2','tof_cell','varDiff_Point','frq','rate_EMCLs')
cd '/data/kwave/result/2018_09_08_variousFrequency'
csvwrite('aveSOS.csv',aveSOS);
csvwrite('aveSOS2.csv',aveSOS2);
csvwrite('steSOS.csv',steSOS);
csvwrite('steSOS2.csv',steSOS2);
csvwrite('varDiff_Point.csv',varDiff_Point);
csvwrite('frq.csv',frq);
csvwrite('rate_EMCLs.csv',rate_EMCLs);