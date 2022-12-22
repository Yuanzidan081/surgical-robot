function Global_Translate_Vector = Global_Translate(Global_Homogeneous_Matrix)%(i,theta,phi,disk_interval)
%GLOBBAL_TRANSLATE 使用递归进行全局坐标系下平移向量的求解
%   Input:
%   i:第几个关节的编号
%   theta:弯曲角 定义是两个关节在弯曲平面内的夹角
%   phi:旋转角，定义为与x轴的夹角
%   Output:
%   Global_Translate_Vector: 全局坐标系下平移向量
% if i==1
%     Global_Translate_Vector=[0,0,0]';%Local_Translate(theta,phi,disk_interval);
% else
%     Global_Translate_Vector=Global_Translate(i-1,theta,phi,disk_interval)+Global_Rotation(i-1,theta,phi)*Local_Translate(theta,phi,disk_interval);
% end
Global_Translate_Vector=Global_Homogeneous_Matrix(1:3,4);
end

