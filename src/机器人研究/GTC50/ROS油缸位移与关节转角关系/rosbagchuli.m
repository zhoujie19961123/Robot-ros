%%元胞内容引用  https://jingyan.baidu.com/article/ca00d56c19d041e99eebcfdf.html
position=zeros(505,7);
for i=1:505
    position(i,1)=data{i,1}.Position(1,1);
    position(i,2)=data{i,1}.Position(2,1);
    position(i,3)=data{i,1}.Position(3,1);
    position(i,4)=data{i,1}.Position(4,1);
    position(i,5)=data{i,1}.Position(5,1);
    position(i,6)=data{i,1}.Position(6,1);
    position(i,7)=data{i,1}.Position(7,1);
end

for i=1:3099
    plot3(position(i,1),position(i,2),position(i,3),'r.','markersize',5);
    hold on
end