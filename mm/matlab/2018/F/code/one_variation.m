%%{ 
% ���ر����Ľ⣬�Լ� �� ��ʱ��ʹ������ �� �̶��ۿ�������
function [Solu_vari, Temp_gate_num, Gate_free_num] = one_variation(Solu_soure, Flight_table, Gate_table)
        %% խ��� N 
        FS = size(Flight_table);
        GS = size(Gate_table);
        Flight_nums = FS(1); %��������
        Gate_nums = GS(2);   %�ǻ�������
        Solu_vari = Solu_soure; % ��ʼ���������
        
        Gate_time = zeros(1, Gate_nums);% ��������ʱ��
        
        vari_point =  ceil(rand()*Flight_nums); 
        while(~Solu_soure(vari_point,Gate_nums+1+1))
            vari_point =  ceil(rand()*Flight_nums); % �������ʵı����
        end

        for i = 1 : vari_point-1 % ���������ǰ�� Gate_time
            index = find(Solu_soure(i,1:Gate_nums) == 1);% �����౻����ĵǻ���
            %if(index <= Gate_nums)
               Gate_time(index) = Flight_table(i, 2) + 45; 
            %end
        end

        for i = vari_point:Flight_nums % ֮���������µĸ���
            
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
               index = gate_candidate(candi_index);
               if(candi_size(1)>=2) % ���������ϵĺ�ѡ�ǻ���
                   Solu_vari(i, Gate_nums+1+1) = 1; % �ɱ����
               end
               
           else %�޽�
               Solu_vari(i, Gate_nums+1) = 1;
               continue
           end

           Solu_vari(i,index) = 1;% ѡ��õǻ���
           Gate_time(index) = Flight_table(i, 2) + 45;% ���µǻ��� ����ʱ��
        end
        
        
        Temp_gate_num = sum(Solu_vari(:,Gate_nums+1));  % ��ʱ�� ʹ������   ��
        Gate_free_num = 0;
        for j=1:Gate_nums
                if sum(Solu_vari(:,j))==0 % δռ��
                    Gate_free_num=Gate_free_num+1;% δռ������     �̶��� ��������   ��
                end
        end
             
end
%%}
      