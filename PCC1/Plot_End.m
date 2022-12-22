function Plot_End(disk_end_list)
%Plot_End 绘制末端点的轨迹
%   Input:
%   disk_end：所有disk_end的列表
plot3(disk_end_list(:,1),disk_end_list(:,2),disk_end_list(:,3),'b-','LineWidth',1);
end