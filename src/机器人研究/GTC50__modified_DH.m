%改进型的DH建立的不好，不能用
%GTC50_7自由度机械臂
%             theta     d        a        alpha       offset 
    L1 = Link([0        1.195    0         0],      'modified');
    L2 = Link([0         0      0.75      pi/2],    'modified');
    L3 = Link([0         0       1          0],     'modified');
    L4 = Link([0         0      2.65        0],     'modified');
    L5 = Link([0         0      1.39        0],     'modified');
    L6 = Link([0         0      0.2453      -pi/2],    'modified'); 
   
    L7 = Link([0         0      0.2281        pi/2],    'modified'); 
   %角度限制大臂（119.09，64.99），现在位置为119.09，5mm
   %        二臂（-118.43，-67.652） ，现在位置为-104.03，150mm
   %        三臂（-89.616，-0.621）  ，现在位置为-73.73，100mm
   %        %抓具（22.555，-66.944），现在位置为28.29，230mm  18.5*pi/180 ,28.29*pi/180
  Six_Link = SerialLink([L1,L2,L3,L4,L5,L6,L7]);
  Six_Link.plot([0,119.09*pi/180,-104.03*pi/180,-73.73*pi/180,8.09*pi/180,0,0]);

   Six_Link.teach()