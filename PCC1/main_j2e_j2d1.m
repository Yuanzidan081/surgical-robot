clc
clear all
close all
%% 1.关节空间到驱动空间逆运动学 由弯曲角度换算出绳长的变化量
%% 3.关节空间到操作空间正运动学 由弯曲角度换算出末端的位置
% 绘制一个动图用的theta和len，绘制工作空间theta和len就注释掉
len=10;
theta=linspace(0,pi/18,len);


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
[e,c,l,h,f]=Get_Disk_Info(18,theta(i),pi/6,1.38,1.62,[0,0,0]);
%绘制Backbone
Plot_Disk_Center(c);
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
%drawnow

%%绘制gif
f = getframe(gcf);
imind = frame2im(f);
[imind,cm] = rgb2ind(imind,256);
if i == 1
	imwrite(imind,cm,'demo.gif','gif', 'Loopcount',inf,'DelayTime',0.1);
else
    imwrite(imind,cm,'demo.gif','gif','WriteMode','append','DelayTime',0.2);
end

end
Plot_End(Disk_end_list);

%绳长的变化量实际计算
Delta_disk_wire_length_act1=disk_wire_length1-disk_wire_length1(1,:);
Delta_disk_wire_length_act2=disk_wire_length2-disk_wire_length2(1,:);
%按照理论模型计算绳长的变化量
%Delta_disk_wire_length_sim
%随机数绘制工作空间ver1
% len=1000;
%theta的范围是0-10度，phi的范围是0-360度
%theta_phi=[pi/180*rand(len,1),2*pi*rand(len,1)];
% for i=1:len
% [e,~,~,~,~]=Get_Disk_Info(18,theta_phi(i,1),theta_phi(i,2),1.38,1.62,[0,0,0]);
% disk_end_all(i,:)=e;
% end


theta_step=pi/1800;
phi_step=pi/36;
% theta_ws_max=pi/18;
% theta_ws_min=0;
% phi_ws_max=2*pi;
% phi_ws_min=0;
theta_ws=0:theta_step:pi/18;
phi_ws=0:phi_step:2*pi;
cnt=1;
for i=1:length(theta_ws)
    for j=1:length(phi_ws)
        [e,~,~,~,~]=Get_Disk_Info(18,theta_ws(i),phi_ws(j),1.38,1.62,[0,0,0],[]);
        %disk_end_all(cnt,:)=e;
        disk_end_all(i,j,:)=e;
        cnt=cnt+1;
    end
end
%load disk_end_all363701ws.mat disk_end_all
figure;
h=Plot_work_space(disk_end_all)

axis([-50,50,-50,50,0,30]);
xlabel('x/mm');
ylabel('y/mm');
zlabel('z/mm');
title('工作空间绘制');
axis equal;

% %% 用子图的方式绘制各线的长度
% figure;
% subplot(2,2,1)
% plot(theta*180/pi,Delta_disk_wire_length_act2(:,1),'-o',Color='r');
% %plot(theta*180/pi,Delta_disk_wire_length_act1(:,1),'r-o',...
% %    theta*180/pi,Delta_disk_wire_length_act2(:,1),'b--s');
% title('绳1长度和弯曲角度的关系');
% xlabel('弯曲角度\alpha/\circ');
% ylabel('绳1长度/mm');
% subplot(2,2,2)
% plot(theta*180/pi,Delta_disk_wire_length_act2(:,2),'-o',Color='r');
% %plot(theta*180/pi,Delta_disk_wire_length_act1(:,2),'r-o',...
% %    theta*180/pi,Delta_disk_wire_length_act2(:,2),'b--s');
% title('绳2长度和弯曲角度的关系');
% xlabel('弯曲角度\alpha/\circ');
% ylabel('绳2长度/mm');
% subplot(2,2,3)
% plot(theta*180/pi,Delta_disk_wire_length_act2(:,3),'-o',Color='r');
% %plot(theta*180/pi,Delta_disk_wire_length_act1(:,3),'r-o',...
% %    theta*180/pi,Delta_disk_wire_length_act2(:,3),'b--s');
% title('绳3长度和弯曲角度的关系');
% xlabel('弯曲角度\alpha/\circ');
% ylabel('绳3长度/mm');
% subplot(2,2,4)
% plot(theta*180/pi,Delta_disk_wire_length_act2(:,4),'-o',Color='r');
% %plot(theta*180/pi,Delta_disk_wire_length_act1(:,4),'r-o',...
% %    theta*180/pi,Delta_disk_wire_length_act2(:,4),'b--s');
% title('绳4长度和弯曲角度的关系');
% xlabel('弯曲角度\alpha/\circ');
% ylabel('绳4长度/mm');

%% 用一张图的方式绘制各线的长度变化量
figure;
plot(theta*180/pi,Delta_disk_wire_length_act2(:,1),'r-*',...
    theta*180/pi,Delta_disk_wire_length_act2(:,2),'c-o',...
    theta*180/pi,Delta_disk_wire_length_act2(:,3),'k-+',...
    theta*180/pi,Delta_disk_wire_length_act2(:,4),'m-s');
title('绳长变化量和弯曲角度的关系');
xlabel('弯曲角度\alpha/\circ');
ylabel('绳长变化量/mm');
legend({'L1','L2','L3','L4'},'Location','northwest');



%使用两种求绳长变化量的算法的差别非常的小 根据实际进行选取
disp('1.1两种求取绳长变化量的差距');
disp(Delta_disk_wire_length_act2-Delta_disk_wire_length_act1);
disp('1.2.1 1号孔和3号孔线对求和(算法2)');
disp(Delta_disk_wire_length_act2(:,1)+Delta_disk_wire_length_act2(:,3));
disp('1.2.2 2号孔和4号孔线对求和(算法2)');
disp(Delta_disk_wire_length_act2(:,2)+Delta_disk_wire_length_act2(:,4));



