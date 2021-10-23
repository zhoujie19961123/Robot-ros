% ��һ������
% ���μӼ�������
% �����������е��ĩ���˶���λ�ƣ��Ƕȣ�pos 
%          ��е��ĩ�����ٶȣ����ٶȣ�vs
%          ���ٶȼ��ٶ�accl���趨�Ӽ��ٶ�accl��ͬ��
%          ��ֵ����N
function lambda = Normalization(pos, vs, accl, N)
% �Ӽ��ٶε�ʱ���λ��
T1 = vs / accl;
S1 = (1/2) * accl * T1^2;
% ��ʱ��
Te = 2*T1 + (pos - 2*S1) / vs;
% ��һ������
S1_ = S1 / pos;
T1_ = T1 / Te;
T2_ = 1 - T1_;
accl_ = 2*S1_ / T1_^2;
% lambda��⹫ʽ
for i = 0: N
    t = i / N;
    if (t >= 0 && t <= T1_)
        lambda(i+1) = (1/2) * accl_ * t^2;
    elseif (t > T1_ && t <= T2_)
        lambda(i+1) = (1/2)*accl_*T1_^2 + accl_*T1_*(t - T1_);
    elseif (t > T2_ && t <= 1)
        lambda(i+1) = (1/2)*accl_*T1_^2 + accl_*T1_*(T2_ - T1_) + (1/2)*accl_*power(t - T2_, 2);
    end
end
            
end
