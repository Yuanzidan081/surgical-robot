function Plot_Disk_Hole(disk_hole)
%PLOT_DISK_HOLE 绘制孔洞
color={'#FF0000','#D95319','#EDB120','#77AC30'};
for i =1:4
    plot3(disk_hole{i}(:,1),disk_hole{i}(:,2),disk_hole{i}(:,3),'-','Color',color{i},'LineWidth',1.5);
end
end

