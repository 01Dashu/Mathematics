function [Solu, Temp_gate_num, Progress_time, Gate_used_num] = one_init2(Flight_table, Gate_table, Ticket_table, Progress_time_table)
   %% ���룺Flight_table ���α� 
    % ����� 303�� 6�У�  
    %{
    1.��ʱ��(1~4320) 2.��ʱ��(1~4320)  3.������(I(0) / D(1)) 4.������(I(0) / D(1))
    5.����(W(1) / N(0)) 6.���index(1~303)
    %}
    %% Gate_table �ǻ��ڱ�  6�� 69�У� 
    %{
     1.������(I(0) / D(1) /  I/D(2))  
     2.������(I(0) / D(1)/  I/D(2)) 
     3.�����ն���(T(0) / S(1)) 
     4.֧�ֻ���(W(1) / N(0))  
     5.����λ��(North=0 Center=1 South=2 East=3)
     6.���index(1~69)
    %}
    %%        Ticket_table ��Ʊ��
    % ��Ʊ�˿�ʱ��� 1649�� 6�У�
    %{ 
     1.�˿�����(1~2)   2.���ﺽ��ID(1~303)  3.��������ID(1~303)  4.ʱ���  5.���index(1~1649)
    %}
    
   %% Progress_time_table ����ʱ���
    % �ǻ�������ʱ��� 
    %{
            4��(����) DT(10) DS(11) IT(00) IS(01)
    4��(����) 
            1  DT(10)    
            2  DS(11) 
            3  IT(00) 
            4  IS(01) 
    %}
        
   %% �����Solu һ����  2�� ��һ��:����ĵǻ��� �ڶ��У��ɱ����
   %         Temp_gate_num ��ʱ��ʹ������ 
   %         Progress_time ����ʱ�� 
   %         Gate_num      �̶��ǻ���ʹ������
   
        FS = size(Flight_table);
        GS = size(Gate_table);
        %TS = size(Ticket_table);
        Flight_nums = FS(1); % ��������   303 
        Gate_nums = GS(2);   % �ǻ������� 69    70 Ϊ��ʱ�ǻ���
        % Ticket_nums = TS(1); % ��Ʊ Ʊ������ 1649
        
        Solu = zeros(Flight_nums, 1+1); % 303*2 ��ʼ���� ��id + �ɱ����
        
        Gate_time = zeros(1, Gate_nums);% 1*69  �ǻ��� ������ʱ��

        for i = 1:Flight_nums % Ϊÿ������ѡ��ǻ���
            
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
               index = gate_candidate(candi_index);% ��Ӧ�Ĺ̶��ǻ���
               if(candi_size(1)>=3) % ���������ϵĺ�ѡ�ǻ���
                   Solu(i, 1+1) = 1; % �ɱ���� ========================================
               end
               
           else %�޽�
               Solu(i, 1) = Gate_nums+1;% ѡ����ʱ�ǻ���
               continue
           end

           Solu(i,1) = index; % ѡ��õǻ��� index
           Gate_time(index) = Flight_table(i, 2) + 45; % ���µǻ��� ����ʱ��
           
        end
    %% ��������Ӧ��ֵ 
      [Temp_gate_num, Progress_time, Gate_used_num] = one_score(Solu, Flight_table, Gate_table, Ticket_table, Progress_time_table); 
%{     
%% Temp_gate_num ��ʱ��ʹ������ 
        Temp_gate_num = sum( Solu(:,1) == Gate_nums+1 );  % ��ʱ�� ʹ������   ��
        
%% Progress_time ����ʱ�� 
      
        Gate_free_num = 0;
        for j=1:Gate_nums
                if sum( Solu(:,1) == j ) == 0 % δռ��
                    Gate_free_num = Gate_free_num+1;% δռ������     �̶��� ��������   ��
                end
        end
        Gate_used_num = Gate_nums - Gate_free_num; % �̶��ǻ���ʹ������
        
%% Gate_num      �̶��ǻ���ʹ������
       Progress_time = 0;
       for k = 1:Ticket_nums % ����ÿ��Ʊ�� ���� ʱ��
           peop_nums = Ticket_table(k,1);% ����
           in_flight_id  = Ticket_table(k,2);% ������id
           out_flight_id = Ticket_table(k,3);% �ߺ���id
           % time_diff = Ticket_table(k,4);% ʱ��� ����ʱ��
           
           in_flight_type  = Flight_table(in_flight_id,3);  % ���ൽ����   I0 / D1
           out_flight_type = Flight_table(out_flight_id,4); % ����������   I0 / D1 
           
           in_gate_id = Solu(in_flight_id,1);   % ���ǻ���id  ����Ϊ��ʱ�ǻ���  Gate_nums+1
           out_gate_id = Solu(out_flight_id,1); % �ߵǻ���id
           
           % �����һ��Ϊ��ʱ�ǻ��� ������
           if( (in_gate_id == Gate_nums+1) || (out_gate_id == Gate_nums+1))
               continue;
           end
           
           in_gate_type = Gate_table(3,in_gate_id);   % ���ǻ��� �ն������� T0 / S1
           out_gate_type = Gate_table(3,out_gate_id); % �ߵǻ��� �ն������� T0 / S1  
           
           if((in_flight_type==1)&&(in_gate_type == 0))
             row_id = 1;
           else if((in_flight_type==1)&&(in_gate_type == 1))
             row_id = 2;
           else if((in_flight_type==0)&&(in_gate_type == 0))
             row_id = 3;
           else
             row_id = 4;
           end
           end
           end
           
           if((out_flight_type==1)&&(out_gate_type == 0))
             col_id = 1;
           else if((out_flight_type==1)&&(out_gate_type == 1))
             col_id = 2;
           else if((out_flight_type==0)&&(out_gate_type == 0))
             col_id = 3;
           else
             col_id = 4;
           end
           end
           end          
           
           temp_time = Progress_time_table(row_id,col_id);
           
           Progress_time = Progress_time + temp_time * peop_nums;   
       end 
 
%}
        
end

      