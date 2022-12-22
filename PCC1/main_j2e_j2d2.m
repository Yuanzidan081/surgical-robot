clc
clear all
close all
%% 1.关节空间到驱动空间逆运动学 由弯曲角度换算出绳长的变化量
%% 3.关节空间到操作空间正运动学 由弯曲角度换算出末端的位置


% 360度phi 弯曲最大角度查看绳长变化量的最大值

len=361;
%theta=linspace(0,pi/18,len);
phi=linspace(0,2*pi,len);

%获取关节空间到驱动空间运动学的各个信息：
% 关节中心的位置
% 绳的位置
% 各个关节的坐标系位置
figure1 = figure;
axes1 = axes('Parent',figure1);
%title('偏转角\pi/6，弯曲角从0-9\circ，18个关节')
hold(axes1,'on');

view(axes1,[60,30]);
axis(axes1,[-10 10 -10 10 0 10]);
axis equal
grid on
xlabel('x/mm');
ylabel('y/mm');
zlabel('z/mm');

for i=1:len
%base=[i,0,0];
[e,c,l,h,f]=Get_Disk_Info(18,pi/18,phi(i),1.38,1.62,[0,0,0]);
%绘制Backbone
% Plot_Disk_Center(c);
Disk_end_list(i,:)=e;
%要画线只画出始末 不然太乱了
% if i==1 || i== len
%     Plot_Disk_Hole(h);
% end

%画出连体坐标系
%Plot_Disk_Frame(c,f);
axis equal
% 绳长的总长:通过函数Wire_Length_Calculate1和Wire_Length_Calculate2求得的
disk_wire_length1(i,:)=sum(l{1});
disk_wire_length2(i,:)=sum(l{2});
%绘制动图的时候打开看效果
%pause(0.1)
% drawnow

%%绘制gif
% f = getframe(gcf);
% imind = frame2im(f);
% [imind,cm] = rgb2ind(imind,256);
% if i == 1
% 	imwrite(imind,cm,'demo.gif','gif', 'Loopcount',inf,'DelayTime',0.1);
% else
%     imwrite(imind,cm,'demo.gif','gif','WriteMode','append','DelayTime',0.2);
% end

end
Plot_End(Disk_end_list);
axis([-20,20,-20,20,-0,40]);
%绳长的变化量实际计算
Delta_disk_wire_length_act1=disk_wire_length1-disk_wire_length1(1,:);
Delta_disk_wire_length_act2=disk_wire_length2-disk_wire_length2(1,:);
%按照理论模型计算绳长的变化量
%Delta_disk_wire_length_sim
%随机数绘制工作空间
% len=10000;
% %theta的范围是0-10度，phi的范围是0-360度
% theta_phi=[pi/180*rand(len,1),2*pi*rand(len,1)];
% for i=1:len
% [e,~,~,~,~]=Get_Disk_Info(18,theta_phi(i,1),theta_phi(i,2),1.38,1.62,[0,0,0]);
% disk_end_all(i,:)=e;
% end
% Plot_work_space(disk_end_all);


figure2 = figure;
plot(phi*180/pi,Delta_disk_wire_length_act2(:,1),'r-*',...
    phi*180/pi,Delta_disk_wire_length_act2(:,2),'c-o',...
    phi*180/pi,Delta_disk_wire_length_act2(:,3),'k-+',...
    phi*180/pi,Delta_disk_wire_length_act2(:,4),'m-s');
title('绳长变化量和弯曲角度的关系');
xlabel('弯曲角度\alpha/\circ');
ylabel('绳长变化量/mm');
legend({'L1','L2','L3','L4'},'Location','northwest');

disp('L1最大变化绳长');
disp(max(abs(Delta_disk_wire_length_act2(:,1))));
disp('L2最大变化绳长');
disp(max(abs(Delta_disk_wire_length_act2(:,2))));
disp('L3最大变化绳长');
disp(max(abs(Delta_disk_wire_length_act2(:,3))));
disp('L4最大变化绳长');
disp(max(abs(Delta_disk_wire_length_act2(:,4))));