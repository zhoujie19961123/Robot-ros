% 轨迹规划中，首先建立机器人模型，6R机器人模型，名称Six_Link。
%GTC50  标准的DH建立的可以使用
%抓具末端相对于末端坐标系的位置为[0,-0.0303,0.9921]
%             theta     d        a        alpha       offset 
    L1 = Link([0        1.195    0.75   pi/2],     'standard');
    L2 = Link([0         0       1          0],    'standard');
    L3 = Link([0         0      2.65        0],    'standard');
    L4 = Link([0         0      1.39        0],    'standard');
    L5 = Link([0         0      0.1975     -pi/2], 'standard'); 
    L6 = Link([0      0.1455     0          pi/2],  'standard');
    L7 = Link([0      0.228      0          0],     'standard');
   %角度限制大臂（64.99,119.09），现在位置为119.09 ，5mm
   %        二臂（-118.47，-67.66） ，现在位置为-104.03，150mm
   %        三臂（-89.79，0.617）  ，现在位置为-73.73，100mm
   %        %抓具（-95.23，18.17），现在位置为-28.29，230mm  -28.29*pi/180
   %Six_Link = SerialLink([L1,L2,L3,L4,L5,L6,L7]);
   %Six_Link.plot([0,119.09*pi/180,-104.03*pi/180,-73.73*pi/180,-28.29*pi/180,pi/2,0]);
   Six_Link = SerialLink([L1,L2,L3,L4,L5]);
   Six_Link.plot([0,119.09*pi/180,-104.03*pi/180,-73.73*pi/180,-28.29*pi/180]);
   Six_Link.teach()