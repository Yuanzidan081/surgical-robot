function h=Plot_Disk_Center(disk_center)
%PLOT_DISK 绘制关节中心

h=plot3(disk_center(:,1),disk_center(:,2),disk_center(:,3));
set(h,'LineWidth',1.5);
set(h,'MarkerSize',2);
set(h,'Marker','o');
set(h,'LineStyle','-');
end

