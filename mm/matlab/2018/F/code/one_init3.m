%%{ 
    function [Solu] = one_init3(Flight_table, Gate_table)
        %% խ��� N 
        FS = size(Flight_table);
        GS = size(Gate_table);
        Flight_nums = FS(1); %��������
        Gate_nums = GS(2);   %�ǻ�������
        
        Solu = zeros(Flight_nums, Gate_nums+1); % ��ʼ����
        
        Gate_time_net = zeros( 864*5 ,Gate_nums); % ���Ż� �м����   3��
        
        Gate_time = zeros(1, Gate_nums);% ��������ʱ��
        
        for i = 1:Flight_nums % Ϊÿ������ѡ��ǻ���
            
           %i        
           in_time1 = Flight_table(i, 1);       % �ú��ൽʱ��
           out_time1 = Flight_table(i, 2) + 45; % �ú����뿪ʱ�� + 45 
           gate_candidate = [];
           for j = 1:Gate_nums %����ÿһ���ǻ��ڣ�����һ������
               f1 = ((Flight_table(i,3)==0)&&((Gate_table(1,j)==1)));
               f2 = ((Flight_table(i,3)==1)&&((Gate_table(1,j)==0)));
               f3 = ((Flight_table(i,4)==0)&&((Gate_table(2,j)==1)));
               f4 = ((Flight_table(i,4)==1)&&((Gate_table(2,j)==0)));

               
               % f5 = ( Flight_table(i, 1) < Gate_time(j));
               f5 = (  sum(Gate_time_net( in_time1:out_time1-1, j)) >=1 ); % 45�ռ仹������===============
               
               if( f1 || f2 || f3 || f4 || f5 ) %������
               else % ����
                   gate_candidate = [gate_candidate; j]; % ���ʵĴ������
               end
           end
           
           if((out_time1 - in_time1)>800)%�� �ɻ� ռ��ʱ�����
               gate_candidate = [gate_candidate; Gate_nums+1];% ���һ�� ��ʱ��λ��Ϊѡ��
           end
           
           candi_size = size(gate_candidate);
           
           
           if(candi_size(1)>0) % �н�
               % ���ѡ��һ��
               candi_index = ceil(rand()*candi_size(1));
               index = gate_candidate(candi_index);
               
               if (index == Gate_nums+1) % ���������ѡ������ʱͣ��λ=====
                   Solu(i, Gate_nums+1) = 1;
                   continue
               end
               
               
           else %�޽������£��Ȳ�����ѡ����ʱͣ��λ=====
               Solu(i, Gate_nums+1) = 1;
               continue
           end

           Solu(i,index) = 1;
           
           in_time = Flight_table(i, 1);       %�ú��ൽʱ��
           out_time = Flight_table(i, 2) + 45; %�ú����뿪ʱ�� + 45 
           Gate_time_net(in_time:out_time-1, index) = 1; % 45�ռ仹������====================
           
           Gate_time(index) = Flight_table(i, 2) + 45;   
           
        end
    end
%%}
      