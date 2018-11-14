%%{ 
    function [Solu,Temp_gate_num, Gate_free_num] = one_init2(Flight_table, Gate_table)
        %% խ��� N 
        FS = size(Flight_table);
        GS = size(Gate_table);
        Flight_nums = FS(1); %��������
        Gate_nums = GS(2);   %�ǻ�������  N 45      W 24
        
        Solu = zeros(Flight_nums, 1+1); % ��ʼ���� ��id + �ɱ����
        
        Gate_time = zeros(1, Gate_nums);% ��������ʱ��

        for i = 1:Flight_nums % Ϊÿ������ѡ��ǻ���
            
           %i
           %
           %{
           % �޳�����
           if(Gate_nums == 45) % N
               if((i==1) ||(i==2) || (i==3) || (i==4) || (i==7) || (i==11) || (i==24) || (i==31)|| (i==45)|| (i==68) )
                  Solu(i, Gate_nums+1) = 1;
                  continue     
               end
           end
           %}
           
           gate_candidate = [];
           for j = 1:Gate_nums %����ÿһ���ǻ��ڣ�����һ������
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
           candi_size = size(gate_candidate);

           if(candi_size(1)>0) % �н�
               % ���ѡ��һ��
               candi_index = ceil(rand()*candi_size(1));
               index = gate_candidate(candi_index);% ��Ӧ�Ĺ̶��ǻ���
               if(candi_size(1)>=2) % ���������ϵĺ�ѡ�ǻ���
                   Solu(i, 1+1) = 1; % �ɱ����
               end
               
           else %�޽�
               Solu(i, 1) = Gate_nums+1;% ѡ����ʱ�ǻ���
               continue
           end

           Solu(i,1) = index; % ѡ��õǻ��� index
           Gate_time(index) = Flight_table(i, 2) + 45; % ���µǻ��� ����ʱ��
           
        end
		
        Temp_gate_num = sum( Solu(:,1) == Gate_nums+1 );  % ��ʱ�� ʹ������   ��
        Gate_free_num = 0;
        for j=1:Gate_nums
                if sum( Solu(:,1) == j ) == 0 % δռ��
                    Gate_free_num = Gate_free_num+1;% δռ������     �̶��� ��������   ��
                end
        end
        
        
    end
%%}
      