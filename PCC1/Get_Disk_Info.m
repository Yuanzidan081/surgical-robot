function [disk_end,disk_center,disk_wire_length,disk_hole,disk_center_orientation_scale] = Get_Disk_Info(n,theta,phi,disk_interval,rho,base,base_glbal_frame)
%绘制圆盘 认为没有厚度
%   Input:
%   n:圆盘的数量
%   theta:弯曲角的序列 定义是两个关节在弯曲平面内的夹角
%   phi:旋转角的序列，定义为与x轴的夹角
%   rho:孔离中心的距离
%   disk_interval:关节之间的距离
%   base:基座的位置
%   Output:
%   disk_center:圆盘的中心三维全局坐标
%   disk_wire_length:每一段驱动线的长度
%   disk_hole:圆盘的孔三维全局坐标
%   disk_center_orientation_scale:圆盘的连体坐标系的x y z用三个矩阵构成的元胞数组 矩阵1-3对应x-z 每一行对应每一段


% if length(theta)==1
%     theta=theta*ones(n,1);
% end
% if length(phi)==1
%     phi=phi*ones(n,1);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%代码从这里开始%%%%%%%%%%%%%%%%%%%%%%%%%%%
disk_hole_rho=rho;
%四周洞的局部坐标Ver1
% disk_hole1_Local_pos=rho*[1,0,0]';
% disk_hole2_Local_pos=rho*[0,1,0]';
% disk_hole3_Local_pos=rho*[-1,0,0]';
% disk_hole4_Local_pos=rho*[0,-1,0]';

%四周洞的局部坐标Ver2：每一行是编号1-4的洞的坐标
disk_hole_Local_pos=rho*[1,0,0;0,1,0;-1,0,0;0,-1,0];
for i=1:n
    Global_Homogeneous_Matrix=Global_Homogeneous(i,theta,phi,disk_interval,base_glbal_frame);
    disk_center_orientation{i}=Global_Rotation(Global_Homogeneous_Matrix);
    disk_center_orientation_x(i,:)=(disk_center_orientation{i}(1:3,1))';
    disk_center_orientation_y(i,:)=(disk_center_orientation{i}(1:3,2))';
    disk_center_orientation_z(i,:)=(disk_center_orientation{i}(1:3,3))';
    %全局坐标系下的孔中心
    disk_center_pos=Global_Translate(Global_Homogeneous_Matrix);
    disk_center(i,:)=disk_center_pos';
end

%相对于基座移动关节中心
disk_center=disk_center+base;
disk_end=disk_center(end,:);
%%在Plot_Disk中计算四周洞代码Ver1
% for i=1:n
%     disk_hole1(i,:)=disk_center(i,:)+(disk_center_orientation{i}*disk_hole1_Local_pos)';
%     disk_hole2(i,:)=disk_center(i,:)+(disk_center_orientation{i}*disk_hole2_Local_pos)';
%     disk_hole3(i,:)=disk_center(i,:)+(disk_center_orientation{i}*disk_hole3_Local_pos)';
%     disk_hole4(i,:)=disk_center(i,:)+(disk_center_orientation{i}*disk_hole4_Local_pos)';
% end

%%在Plot_Disk中计算四周洞代码Ver2
for i=1:4
    for j=1:n
        disk_hole{i}(j,:)=disk_center(j,:)+(disk_center_orientation{j}*(disk_hole_Local_pos(i,:))')';
    end
end

%计算各段绳子的长度Ver1: 每一列为编号对应的绳子 每一行对应每一段
% for i=1:n-1
%     disk_wire_length(i,1)=Wire_Length_Calculate(disk_hole1(i,:),disk_hole1(i+1,:));
%     disk_wire_length(i,2)=Wire_Length_Calculate(disk_hole2(i,:),disk_hole2(i+1,:));
%     disk_wire_length(i,3)=Wire_Length_Calculate(disk_hole3(i,:),disk_hole3(i+1,:));
%     disk_wire_length(i,4)=Wire_Length_Calculate(disk_hole4(i,:),disk_hole4(i+1,:));
% end

% 两种计算绳子长度的方法放在Wire_Length_Calculate1和Wire_Length_Calculate2里
% for i=1:4
%     for j=1:n-1
%         disk_wire_length(j,i)=Wire_Length_Calculate(disk_hole{i}(j,:),disk_hole{i}(j+1,:));
%     end
% end

for i=1:4
    for j=1:n-1
        disk_wire_length{1}(j,i)=Wire_Length_Calculate1(disk_hole{i}(j,:),disk_hole{i}(j+1,:));
        disk_wire_length{2}(j,i)=Wire_Length_Calculate2(disk_hole_rho,disk_interval,theta,phi,i);
    end
end

% if disk_interval<2
%     disk_center_orientation_x_scale=disk_center_orientation_x/2;
%     disk_center_orientation_y_scale=disk_center_orientation_y/2;
%     disk_center_orientation_z_scale=disk_center_orientation_z/2;
% else
%     disk_center_orientation_x_scale=disk_center_orientation_x;
%     disk_center_orientation_y_scale=disk_center_orientation_y;
%     disk_center_orientation_z_scale=disk_center_orientation_z;
% end
disk_center_orientation_x_scale=disk_center_orientation_x;
disk_center_orientation_y_scale=disk_center_orientation_y;
disk_center_orientation_z_scale=disk_center_orientation_z;

disk_center_orientation_scale={disk_center_orientation_x_scale,...
                                disk_center_orientation_y_scale,...
                                disk_center_orientation_z_scale};
%绘图
% figure1 = figure;
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');

%绘制关节：移植到Plot_Disk_Center里了
% plot3(disk_center(:,1),disk_center(:,2),disk_center(:,3),'-*','Color','k','MarkerSize',5,'LineWidth',2);

%绘制四周孔洞Ver1
% plot3(disk_hole1(:,1),disk_hole1(:,2),disk_hole1(:,3),'-o','Color','c');
% plot3(disk_hole2(:,1),disk_hole2(:,2),disk_hole2(:,3),'-o','Color','c');
% plot3(disk_hole3(:,1),disk_hole3(:,2),disk_hole3(:,3),'-o','Color','c');
% plot3(disk_hole4(:,1),disk_hole4(:,2),disk_hole4(:,3),'-o','Color','c');

%绘制四周孔洞Ver2：移植到Plot_Disk_Hole里了
% for i =1:4
% plot3(disk_hole{i}(:,1),disk_hole{i}(:,2),disk_hole{i}(:,3),'-o','Color','c');
% end


%scatter3(disk_hole1(:,1),disk_hole1(:,2),disk_hole1(:,3));
%scatter3(disk_hole2(:,1),disk_hole2(:,2),disk_hole2(:,3));
%scatter3(disk_hole3(:,1),disk_hole3(:,2),disk_hole3(:,3));
%scatter3(disk_hole4(:,1),disk_hole4(:,2),disk_hole4(:,3));
%绘制连体的坐标系Ver1
% for i=1:n
%     plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_x_scale(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_x_scale(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_x_scale(i,3)],'-','Color','r');
%     plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_y_scale(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_y_scale(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_y_scale(i,3)],'-','Color','g');
%     plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_z_scale(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_z_scale(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_z_scale(i,3)],'-','Color','b');  
% end

%绘制连体的坐标系Ver2:移植到Plot_Disk_Frame里了

% for i=1:n
%     plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_scale{1}(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_scale{1}(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_scale{1}(i,3)],'-','Color','r');
%     plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_scale{2}(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_scale{2}(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_scale{2}(i,3)],'-','Color','g');
%     plot3([disk_center(i,1);disk_center(i,1)+disk_center_orientation_scale{3}(i,1)],[disk_center(i,2);disk_center(i,2)+disk_center_orientation_scale{3}(i,2)],[disk_center(i,3);disk_center(i,3)+disk_center_orientation_scale{3}(i,3)],'-','Color','b');  
% end

%xlabel('x');
%ylabel('y');
%zlabel('z');
% xlim(axes1,[-5 5]);
% ylim(axes1,[-10 5]);
% zlim(axes1,[0 10]);

end

