function Local_Homogeneous_Matrix = Local_Homogeneous(theta,phi,disk_interval)
%LOCAL_HOMOGENEOUS 局部坐标系下的齐次矩阵
%   Input:
%   theta:弯曲角 定义是两个关节在弯曲平面内的夹角
%   phi:旋转角，定义为与x轴的夹角
%   Output:
%   Local_Homogeneous_Matrix: 局部坐标系下的齐次矩阵
Local_Homogeneous_Matrix=[Local_Rotation(theta,phi),Local_Translate(theta,phi,disk_interval);
    0,0,0,1];
end

