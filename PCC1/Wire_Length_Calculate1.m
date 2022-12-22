function Wire_Length = Wire_Length_Calculate1(Hole_pos1,Hole_pos2)
%WIRE_LENGTH_CALCULATE 给定两个洞的坐标计算线的长度
%   Input:
%   Hole_pos1:第一个洞的坐标 3*1行向量
%   Hole_pos2:第二个洞的坐标 3*1行向量

Wire_Length=sqrt((Hole_pos1(1)-Hole_pos2(1))^2+(Hole_pos1(2)-Hole_pos2(2))^2+(Hole_pos1(3)-Hole_pos2(3))^2);
end

