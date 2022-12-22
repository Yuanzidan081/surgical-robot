function Global_Rotation_Matrix = Global_Rotation(Global_Homogeneous_Matrix)%(i,theta,phi)
%GLOBAL_ROTATION 使用递归进行全局坐标系下旋转矩阵的求解
%   Input:
%   i:第几个关节的编号
%   theta:弯曲角 定义是两个关节在弯曲平面内的夹角
%   phi:旋转角，定义为与x轴的夹角
%   Output:
%   Global_Rotation_Matrix: 局部坐标系下的旋转矩阵
%if i==1
%    Global_Rotation_Matrix=Local_Rotation(theta,phi);
%    Global_Rotation_Matrix=[1,0,0;
%                            0,1,0;
%                            0,0,1];
%else
%    Global_Rotation_Matrix=Global_Rotation(i-1,theta,phi)*Local_Rotation(theta,phi);
%end
Global_Rotation_Matrix=Global_Homogeneous_Matrix(1:3,1:3);
end

