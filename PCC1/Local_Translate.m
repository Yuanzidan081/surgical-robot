function Local_Translate_Vector = Local_Translate(theta,phi,disk_interval)
%LOCAL_TRANSLATE 求解局部坐标系下的平移向量
%   Input:
%   theta:弯曲角 定义是两个关节在弯曲平面内的夹角
%   phi:旋转角，定义为与x轴的夹角
%   Output:
%   Local_Translate_Vector: 局部坐标系下的平移向量
%if abs(theta)<0.01
if theta==0
    Local_Translate_Vector=[0;0;disk_interval];
else
    Local_Translate_Vector=[cos(phi)*(1-cos(theta))*disk_interval/theta;
        sin(phi)*(1-cos(theta))*disk_interval/theta;
        sin(theta)*disk_interval/theta];
end
end

