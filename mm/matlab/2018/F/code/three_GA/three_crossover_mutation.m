%%{ 
% ����
% in�� ��Ⱥ grop_soure ������� Flight_table���ǻ������ͱ� Gate_table��������� cros_weight
% ���㽻��  k֮��Ļ���ȫ�� ����
function [grop_cros] = three_crossover_mutation(grop_soure, Flight_table, Gate_table, cros_weight)
    FS = size(Flight_table);
    %GS = size(Gate_table);
    grop_size = size(grop_soure);
    grop_nums = grop_size(3); % ��Ⱥ����
    Flight_nums = FS(1);      % ��������   ��������
    % Gate_nums = GS(2);      % �ǻ�������

    grop_cros = grop_soure; % ��ʼ����������Ⱥ
    %disp(Flight_nums);
    
    for i = 1 : 2 : grop_nums% ǰ���������� ��������Ӵ����ٴӽ����֮���飬�����ʵĻ���ʹ�ñ���������ʵĻ���
       % ���㽻���������� cros_point
       cros_point = ceil(rand() * (Flight_nums-1)); % 1 ~ N-1
       % disp(cros_point);
       
       % ˫�㽻��  cros_point1 cros_point2
       %{
        flag = 1;
        while flag == 1
            cros_point1 = ceil(rand() * Flight_nums);
            cros_point2 = ceil(rand() * Flight_nums);
            if cros_point2 > cros_point1
                flag = 0;
                break;
            end
        end
       %}
       
       % ����            ========================================
       if cros_weight > rand() % ���ս�����ʽ��н���
           a = grop_soure(cros_point:Flight_nums,:,i);
           b = grop_soure(cros_point:Flight_nums,:,i+1);
           grop_cros(cros_point:Flight_nums,:,i) = b;
           grop_cros(cros_point:Flight_nums,:,i+1) = a;
           
       % ��� �����н⣬�� ���� ���� ���н� ======================================== 
           grop_cros(:,:,i) = three_crossover_check(grop_cros(:,:,i), Flight_table, Gate_table, cros_point);
           grop_cros(:,:,i+1) = three_crossover_check(grop_cros(:,:,i), Flight_table, Gate_table, cros_point);
       end

    end
end
%%}
      