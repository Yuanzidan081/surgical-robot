
clc
clear all
close all
%% 2.驱动空间到关节空间正运动学 由绳长的变化量换算出弯曲角度
%% 4.操作空间到关节空间逆运动学 由末端的位置换算出弯曲角度
pulley_radius=20;
%计算的是
%给定一个轨迹 根据正运动学计算出来的
n=2;
len=11;
% theta_test=linspace(0,2*pi,len);
% r_test=14.435386;
% z_test=15.753459*ones(size(theta_test));
% x_test=r_test*cos(theta_test);
% y_test=r_test*sin(theta_test);
% %scatter3(x_test,y_test,z_test,'o','MarkerFaceColor',[0 .75 .75])
% %逆运动学求解
% for i=1:len
%     phi_i(i,:)=atan2(y_test(i),x_test(i));
%     if phi_i(i,:)<0
%         phi_i(i,:)=phi_i(i,:)+2*pi;
%     end
%     if phi_i(i,:)==0
%         theta_n=atan(x_test(i)/z_test(i))*2;
%     else
%         e=(y_test(i))^2/((z_test(i))^2*(sin(phi_i(i)))^2);
%         theta_n=acos((1-e)/(e+1));
%     end
%     theta_i(i,:)=theta_n/n;
% end
figure;


%正运动学求解
phi_f=(linspace(0,2*pi,len))';
theta_f=pi/18;
for i=1:len
%base=[i,0,0];
[e_f,c_f,l_f,h_f,f_f]=Get_Disk_Info(n,theta_f,phi_f(i),15,1.62,[0,0,0]);
x_test(i,:)=e_f(1);
y_test(i,:)=e_f(2);
z_test(i,:)=e_f(3);
eF(i,:)=e_f;
%绘制Backbone
h1=Plot_Disk_Center(c_f);
hold on;
%画出连体坐标系
%Plot_Disk_Frame(c,f);
axis equal
end
plot3(x_test,y_test,z_test,'LineWidth',1.5);

% % 算法1 通过末端位置反求旋转角度
% for i=1:len
%     phi_i(i,:)=atan2(y_test(i),x_test(i));
%     if phi_i(i,:)<0
%         phi_i(i,:)=phi_i(i,:)+2*pi;
%     end
%     if phi_i(i,:)==0
%         theta_n=atan(x_test(i)/z_test(i))*2;
%     else
%         e=(y_test(i))^2/((z_test(i))^2*(sin(phi_i(i)))^2);
%         theta_n=acos((1-e)/(e+1));
%     end
%     theta_i(i,:)=theta_n/n;
% end

% 算法2：通过末端位置反求旋转角度
for i=1:len
    phi_i(i,:)=atan2(y_test(i),x_test(i));
    if phi_i(i,:)<0
        phi_i(i,:)=phi_i(i,:)+2*pi;
    end
    theta_i(i,:)=2*atan2((sqrt((y_test(i))^2+(x_test(i))^2)),(z_test(i)))/(n-1);
    %disp(sqrt((y_test(i))^2+(x_test(i))^2));
    %disp(z_test(i));
    disp(theta_f);
end

for i=1:len
%base=[i,0,0];
[e_i,c_i,l_i,h_i,f_i]=Get_Disk_Info(n,theta_i(i),phi_i(i),15,1.62,[0,0,0]);
eI(i,:)=e_i;
%绘制Backbone
h2=Plot_Disk_Center(c_i);

set(h2,'color',[0,1,1]);
hold on;
%画出连体坐标系
%Plot_Disk_Frame(c,f);
axis equal
end
grid on;
xlabel('x/mm');
ylabel('y/mm');
zlabel('z/mm');
legend([h1,h2],'正运动学绘制','逆运动学绘制');

%%%%%%%%后面要修改
theta_f=theta_f*ones(len,1);

figure
plot(eI-eF,'LineWidth',1.5);
legend({'x','y','z'});
title('x、y、z末端点正逆运动学坐标的误差图');
xlabel('测试点序号');
ylabel('error/mm');
figure
plot(sqrt((eI(:,1)-eF(:,1)).^2+(eI(:,2)-eF(:,2)).^2+(eI(:,3)-eF(:,3)).^2), ...
    'LineWidth',1.5);
title('末端点正逆运动学距离的误差图');
xlabel('测试点序号');
ylabel('error/mm');
figure
subplot(221);
plot(1:numel(phi_f),phi_f,1:numel(phi_i),phi_i);
legend({'正运动学','逆运动学'});
title('\phi正运动学和逆运动学比较')
subplot(223);
plot(1:numel(phi_f),phi_f-phi_i);
title('\phi正运动学和逆运动学差值比较')
subplot(222);
plot(1:numel(theta_f),theta_f,1:numel(theta_i),theta_i);
legend({'正运动学','逆运动学'});
title('\theta正运动学和逆运动学比较')
subplot(224);
plot(1:numel(theta_f),theta_f-theta_i);