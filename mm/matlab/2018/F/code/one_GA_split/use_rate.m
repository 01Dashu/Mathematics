
%{
SW   = xlsread('SW_src2.xlsx'); %Լ��
FW =  xlsread('Flight_W.xlsx'); %Լ��

use_rate_ = zeros(1,24); % �ǻ���ʹ����

for i = 1:24 % ÿ���ǻ���
    flight_id = find(SW(:,i) == 1); % ��¼�ĺ���id
    flight_id_size = size(flight_id);
    use_time = 0;
    if flight_id_size(1) >0 % �õǻ��ڱ�ʹ����
        for  j = 1 : flight_id_size(1)
             fid = flight_id(j); % �����
             in_time  = FW(fid,1); % ��ʱ��
             out_time = FW(fid,2); % �뿪ʱ��
             if in_time < 24*60
                in_time = 24*60;
             end
             if out_time > 24*60*2
                out_time = 24*60*2;
             end
             use_time = use_time + out_time - in_time;
        end
    end
    use_rate_(i) = use_time/(24*60);
    % �ǻ���δ��ʹ��
end
%}

SN = xlsread('SN_src2.xlsx'); %Լ��
FN =  xlsread('Flight_N.xlsx'); %Լ��

use_rate_ = zeros(1,45); % �ǻ���ʹ����

for i = 1:45 % ÿ���ǻ���
    flight_id = find(SN(:,i) == 1); % ��¼�ĺ���id
    flight_id_size = size(flight_id);
    use_time = 0;
    if flight_id_size(1) >0 % �õǻ��ڱ�ʹ����
        for  j = 1 : flight_id_size(1)
             fid = flight_id(j); % �����
             in_time  = FN(fid,1); % ��ʱ��
             out_time = FN(fid,2); % �뿪ʱ��
             if in_time < 24*60
                in_time = 24*60;
             end
             if out_time > 24*60*2
                out_time = 24*60*2;
             end
             use_time = use_time + out_time - in_time;
        end
    end
    use_rate_(i) = use_time/(24*60);
    % �ǻ���δ��ʹ��
end