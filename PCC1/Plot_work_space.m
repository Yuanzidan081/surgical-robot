function h=Plot_work_space(disk_end_all)
%生成工作空间
h=surf(disk_end_all(:,:,1),disk_end_all(:,:,2),disk_end_all(:,:,3));

% h=plot3(disk_end_all(:,1),disk_end_all(:,2),disk_end_all(:,3),'+')
%set(h,'MarkerSize',6)
% s=repmat([10],numel(disk_end_all(:,3)),1);
% s=s(:);
% h=scatter3(disk_end_all(:,1),disk_end_all(:,2),disk_end_all(:,3),'SizeData',5,'CData',disk_end_all(:,3));
% set(h,'Marker','+');

% colormap("jet");
%colorbar;
end

