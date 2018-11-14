%%{ 
% ���ر����Ľ⣬�Լ� �� ��ʱ��ʹ������ �� �̶��ۿ�������
function [Solu_vari] = two_variation( Solu_soure, Flight_table, Gate_table) %���1��
        FS = size(Flight_table);
        GS = size(Gate_table);
        %TS = size(Ticket_table);
        Flight_nums = FS(1); % ��������   303 
        Gate_nums = GS(2);   % �ǻ������� 69    70 Ϊ��ʱ�ǻ���
        %Ticket_nums = TS(1); % ��Ʊ Ʊ������ 1649
        
        Solu_vari = Solu_soure; % ��ʼ���������
       
        Gate_time = zeros(1, Gate_nums);% 1*69  �ǻ��� ������ʱ��
 
        % �����
        vari_point =  ceil(rand()*(Flight_nums-1)); 
        while(~Solu_soure(vari_point, 1+1))         % �ڶ���Ϊ �Ƿ���� ����
            vari_point =  ceil(rand()*(Flight_nums-1)); % �������ʵı���� 1 ~ N-1
        end

        for k = 1 : vari_point-1 % ���������ǰ�� Gate_time
            index = Solu_soure(k,1); % �����౻����ĵǻ��� �п���Ϊ��ʱͣ���� Gate_nums+1
            if(index <= Gate_nums)
               Gate_time(index) = Flight_table(k, 2) + 45; 
            end
        end

        for i = vari_point:Flight_nums % ֮���������µĸ���
           gate_candidate = [];
           for j = 1:Gate_nums %����ÿһ���ǻ��ڣ�����Щ����
               % ���Ͳ�ƥ��
               f0 = (Flight_table(i,5) ~= Gate_table(4,j)); % ����ƥ�� W-W N-N
               % ���κ͵ǻ��� ���ڹ���ƥ�� ��ƥ������
               % ���ﲻƥ��
               f1 = ((Flight_table(i,3)==0)&&((Gate_table(1,j)==1)));% ID 
               f2 = ((Flight_table(i,3)==1)&&((Gate_table(1,j)==0)));% DI
               % ������ƥ��
               f3 = ((Flight_table(i,4)==0)&&((Gate_table(2,j)==1)));% ID
               f4 = ((Flight_table(i,4)==1)&&((Gate_table(2,j)==0)));% DI
               % �ǻ��� ����ʱ��Ҫ�� 
               f5 = ( Flight_table(i, 1) <= Gate_time(j));% 45���ӿ���
               
               if( f0 || f1 || f2 || f3 || f4 || f5 ) %������
               else % ����
                   gate_candidate = [gate_candidate; j]; % ���ʵĴ������
               end
           end
           candi_size = size(gate_candidate);

           if(candi_size(1)>0) % �н�
               % ���ѡ��һ��
               candi_index = ceil(rand()*candi_size(1));
               index1 = gate_candidate(candi_index);% ��Ӧ�Ĺ̶��ǻ���
               if(candi_size(1)>=3) % ���������ϵĺ�ѡ�ǻ��� ==========================
                   Solu_vari(i, 1+1) = 1; % �ɱ����
               end
               
           else %�޽�
               Solu_vari(i, 1) = Gate_nums+1;% ѡ����ʱ�ǻ���
               continue
           end

           Solu_vari(i,1) = index1; % ѡ��õǻ��� index
           Gate_time(index1) = Flight_table(i, 2) + 45; % ���µǻ��� ����ʱ��
        end           
end
%%}
      