function Wire_Length = Wire_Length_Calculate2(disk_hole_rho,disk_interval,theta,phi,j)
%WIRE_LENGTH_CALCULATE 给定两个洞的坐标计算线的长度
%   Input:
%   disk_hole_rho:关节的半径
%   disk_interval：关节的间距
%   theta,phi,j
if theta==0
    Wire_Length=disk_interval;
else
    Wire_Length=(disk_interval/theta-disk_hole_rho*cos(phi-pi/2*(j-1)))*(2*sin(theta/2));
end

end

