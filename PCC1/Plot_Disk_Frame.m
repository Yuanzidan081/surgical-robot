function Plot_Disk_Frame(disk_center,disk_center_orientation_scale)
%PLOT_DISK_FRAME 绘制关节的连体坐标系
n=length(disk_center);
for i=1:n
    plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_scale{1}(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_scale{1}(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_scale{1}(i,3)],'-','Color','r');
    plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_scale{2}(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_scale{2}(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_scale{2}(i,3)],'-','Color','g');
    plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_scale{3}(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_scale{3}(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_scale{3}(i,3)],'-','Color','b');  
end
end

