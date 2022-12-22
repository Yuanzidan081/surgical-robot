function Global_Homogeneous_Matrix = Global_Homogeneous(i,theta,phi,disk_interval,base_glbal_frame)
%GLOBAL_ROTATION 使用递归进行全局坐标系下齐次变换矩阵的求解
%   Input:
%   i:第几个关节的编号
%   theta:弯曲角 定义是两个关节在弯曲平面内的夹角
%   phi:旋转角，定义为与x轴的夹角
%   disk_interval：节盘之间的间距
%   base_glbal_frame:各段基盘的全局坐标系 如果为空就是缺省的标准齐次矩阵

%   Output:
%   Global_Rotation_Matrix: 局部坐标系下的旋转矩阵

if i==1
    if isempty(base_glbal_frame)   
%    Global_Rotation_Matrix=Local_Rotation(theta,phi);
        Global_Homogeneous_Matrix=[1,0,0,0;
                            0,1,0,0;
                            0,0,1,0;
                            0,0,0,1];
    else
        Global_Homogeneous_Matrix=base_glbal_frame;
    end
else
    Global_Homogeneous_Matrix=Global_Homogeneous(i-1,theta,phi,disk_interval,base_glbal_frame)*Local_Homogeneous(theta,phi,disk_interval);
end
end

