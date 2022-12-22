function Local_Rotation_Matrix = Local_Rotation(theta,phi)
%LOCAL_ROTATION 求解局部坐标系下的旋转矩阵
%   Input:
%   theta:弯曲角 定义是两个关节在弯曲平面内的夹角
%   phi:旋转角，定义为与x轴的夹角
%   Output:
%   Local_Rotation_Matrix: 局部坐标系下的旋转矩阵

%Local_Rotation_Matrix=[cos(phi)^2*(cos(theta)-1)+1, sin(phi)*cos(phi)*(cos(theta)-1),cos(phi)*sin(theta);
    %sin(phi)*cos(phi)*(cos(theta)-1),cos(phi)^2*(1-cos(theta))+cos(theta),sin(phi)*sin(theta);
    %-cos(phi)*sin(theta),-sin(phi)*sin(theta),cos(theta)];
%和上面是一样的
    Local_Rotation_Matrix=[(cos(phi))^2*cos(theta)+(sin(phi))^2, sin(phi)*cos(phi)*(cos(theta)-1),cos(phi)*sin(theta);
    sin(phi)*cos(phi)*(cos(theta)-1),(sin(phi))^2*cos(theta)+(cos(phi))^2,sin(phi)*sin(theta);
    -cos(phi)*sin(theta),-sin(phi)*sin(theta),cos(theta)];
%Local_Rotation_Matrix=[(cos(phi))^2*cos(theta)+(sin(phi))^2, sin(phi)*cos(phi)*(cos(theta)-1),cos(phi)*cos(theta);
%    sin(phi)*cos(phi)*(cos(theta)-1),(sin(phi))^2*cos(theta)+(cos(phi))^2,sin(phi)*cos(theta);
%   -cos(phi)*sin(theta),-sin(phi)*sin(theta),sin(theta)];
end

