%%{ 
% ����
% in�� �����Ľ� solu_cros ������� Flight_table���ǻ������ͱ� Gate_table������� cros_point
% ���㽻��  k֮��Ļ���ȫ�� ����
function [solu_cros_check] = one_crossover_check(solu_cros, Flight_table, Gate_table, cros_point)
    FS = size(Flight_table);
    GS = size(Gate_table);
    Flight_nums = FS(1);      % ��������   ��������
    Gate_nums = GS(2);        % �ǻ�������
    solu_cros_check = solu_cros; % ��ʼ�� ���� �˲� ��Ľ�
    
% ��� �����н⣬�� ���� ���� ���н� ======================================== 
    % ���� �����ǰ�� Gate_time
    Gate_time = zeros(1, Gate_nums);% ��������ʱ��
    for k = 1 : cros_point-1 
        index = solu_cros(k,1); % �����౻����ĵǻ��� �п���Ϊ��ʱͣ���� Gate_nums+1
        if(index <= Gate_nums)
           Gate_time(index) = Flight_table(k, 2) + 45; 
        end
    end
    
    % 
    for i = cros_point:Flight_nums % ��� ������ ���� �����ʵ����²���
        gate_candidate = [];
        for j = 1:Gate_nums %����ÿһ���ǻ��ڣ�����һЩ����
           f1 = ((Flight_table(i,3)==0)&&((Gate_table(1,j)==1)));
           f2 = ((Flight_table(i,3)==1)&&((Gate_table(1,j)==0)));
           f3 = ((Flight_table(i,4)==0)&&((Gate_table(2,j)==1)));
           f4 = ((Flight_table(i,4)==1)&&((Gate_table(2,j)==0)));
           f5 = ( Flight_table(i, 1) <= Gate_time(j));% 45���ӿ���
           if( f1 || f2 || f3 || f4 || f5 ) %������
           else % ����
               gate_candidate = [gate_candidate; j]; % ���ʵĴ������
           end
        end
        
       %% ��� ԭ����� �Ƿ���� 
        index_src = solu_cros(i,1);% ԭ�����
        if( sum(gate_candidate == index_src) > 0) % �û���� �Ѿ����ʣ��������²���
		    Gate_time(index_src) = Flight_table(i, 2) + 45;% ���µǻ��� ����ʱ��
            continue; % ���� �� ���ʵ� �����
        end
        
        %% ԭ ����� �����ʣ� ��������µ� �����
        candi_size = size(gate_candidate);
        if(candi_size(1)>0) % �н�
           % ���ѡ��һ��
           candi_index = ceil(rand()*candi_size(1));
           index_selt = gate_candidate(candi_index); % ѡ��һ�� ��Ӧ�Ĺ̶��ǻ��� id
           if(candi_size(1)>=2) % ���������ϵĺ�ѡ�ǻ���
               solu_cros_check(i, 1+1) = 1; % ��עΪ  �ɱ����
           end

        else %�޽�
           solu_cros_check(i, 1) = Gate_nums+1;% ѡ����ʱ�ǻ���
           continue
        end
     
        solu_cros_check(i,1) = index_selt;% ѡ��õǻ���
        Gate_time(index_selt) = Flight_table(i, 2) + 45;% ���µǻ��� ����ʱ��
    end

end
%%}
      