 clc
 clear
 

Flight_table = xlsread('data\Flight_table.xlsx');% ����� 303�� 6��
Gate_table = xlsread('data\Gate_table.xlsx');    % �ǻ��ڱ� 6�� 69��
Ticket_table = xlsread('data\Ticket_table.xlsx');% ��Ʊ�˿�ʱ��� 1649�� 6��
Progress_time_table = xlsread('data\Progress_time_table.xlsx');% �ǻ�������ʱ���
Trans_time_table = xlsread('data\Trans_time_table.xlsx');% ����ʱ���
Work_time_table = xlsread('data\Work_time_table.xlsx');  % ����ʱ���

Solu = xlsread('ans_three.xlsx'); 

%%{
FS = size(Flight_table);
GS = size(Gate_table);
TS = size(Ticket_table);
Flight_nums = FS(1); % ��������   303 
Gate_nums = GS(2);    % �ǻ������� 69      70 Ϊ��ʱ�ǻ���
Ticket_nums = TS(1);  % ��Ʊ Ʊ������ 1649

%% Temp_gate_num ��ʱ��ʹ������ 
Temp_gate_num = sum( Solu(:,1) == Gate_nums+1 );  % ��ʱ�� ʹ������   ��   52

%% Gate_num      �̶��ǻ���ʹ������

Gate_free_num = 0;
for j=1:Gate_nums
        if sum( Solu(:,1) == j ) == 0 % δռ��
            Gate_free_num = Gate_free_num+1;% δռ������     �̶��� ��������   ��
        end
end
Gate_used_num = Gate_nums - Gate_free_num; % �̶��ǻ���ʹ������

%% a �ɹ����䵽�ȼ��ڵĺ��� �����ͱ���  ��W �� N �ֿ�
        flight_success_id = find(Solu(:,1) ~= Gate_nums+1); % �ɹ�����ĺ��� id
        flight_success_num = size(flight_success_id,1);     % ����
        % �ɹ�����ĺ���
        success_W =[];% ����� W
        success_N =[];% խ��� N
        for i = 1:flight_success_num % ÿ���ɹ������ ����
           flight_id = flight_success_id(i);% ����id
           flight_type = Flight_table(flight_id,5); % ��������  (N=0,W=1)
           if(flight_type == 1) 
               success_W = [success_W; flight_id];
           else 
               success_N = [success_N; flight_id];
           end
        end

        % ����ʧ�ܵĺ��� 
        flight_fail_id = find(Solu(:,1) == Gate_nums+1); % ����ʧ�ܵĺ���
        flight_fail_num = size(flight_fail_id,1);     % ���� 
        fail_W =[];% ����� W
        fail_N =[];% խ��� N
        for i = 1:flight_fail_num % ÿ������
           flight_id = flight_fail_id(i);% ����id
           flight_type = Flight_table(flight_id,5); % ��������  (N=0,W=1)
           if(flight_type == 1) 
               fail_W = [fail_W; flight_id];
           else 
               fail_N = [fail_N; flight_id];
           end
        end 

        W_success_num = size(success_W,1) * 2; % һ���ɻ� ��������  �ɹ������ �����
        W_num = W_success_num + size(fail_W,1)*2;
        W_flight_succ_rate = W_success_num/W_num; % W �ɹ��������

        N_success_num = size(success_N,1)*2;   % һ���ɻ� ��������  �ɹ������ խ���
        N_num = N_success_num + size(fail_N,1)*2;
        N_flight_succ_rate = N_success_num/N_num; % N �ɹ��������

%% b��  T ��  �� S�͵ǻ���ʹ�������Լ� ��ʹ�õĵǻ����� 20����� ƽ��ʹ���� 
        Gate_T=[];
        flight_T =[];
        Gate_S=[];
        flight_S =[];
        for k = 1:flight_success_num % ÿ���ɹ������ ����
           flight_id = flight_success_id(k);% ����id
           Gate_id = Solu(flight_id,1); % ������� �ǻ���id
           Gate_type = Gate_table(3, Gate_id); % �ն������� T=0, S=1 
           if(Gate_type == 0)
              Gate_T = [Gate_T; Gate_id]; % T���� �ǻ���id
              flight_T = [flight_T; flight_id];% ��Ӧ��¼�� ����id
           else
              Gate_S = [Gate_S; Gate_id]; % S���� �ǻ���id
              flight_S = [flight_S; flight_id];% ��Ӧ��¼�� ����id
           end
        end
        
        Gate_T_use_num = size(Gate_T,1); % T�͵ǻ��� ����
        T_used_num= size(unique(Gate_T),1); % T�͵ǻ��� ʹ������
        Gate_S_use_num = size(Gate_S,1); % S�͵ǻ��� ����
        S_used_num= size(unique(Gate_S),1); % S�͵ǻ��� ʹ������
        
        % T��ʹ����
        % Gate_T_unique = unique(Gate_T); 
        % Gate_use_time_rate = zeros(size(Gate_T_unique,1),1); % ʹ�õĲ�ͬ�� T�͵ǻ�������
        Gate_use_time_T = zeros(Gate_nums,1);% 69*1 ʹ��ʱ��
        for g =1:Gate_T_use_num
            Gate_id  = Gate_T(g);   % �ǻ��� id
            flight_id = flight_T(g);% ����id
            in_time  = Flight_table(flight_id,1); % ���ൽʱ��
            out_time = Flight_table(flight_id,2); % �����뿪ʱ��
            if in_time < 24*60
                in_time = 24*60; % 20�����ʱ��
            end
            if out_time > 24*60*2
                out_time = 24*60*2;% 20 �����ʱ��
            end
            use_time = out_time - in_time; % �ôκ���ռ��ʱ��
            Gate_use_time_T(Gate_id) = Gate_use_time_T(Gate_id) + use_time;
        end
        % T_used_num = sum(Gate_use_time_T ~= 0); % ռ��ʱ�䲻Ϊ0 �� �� ���Ǳ�ʹ����     T�͵ǻ��� ʹ������
        T_used_rate = sum(Gate_use_time_T) /( 24*60*T_used_num);% ��ʹ��ʱ�� / ������ʱ��
        
         
        % S��ʹ����
        % Gate_T_unique = unique(Gate_T); 
        % Gate_use_time_rate = zeros(size(Gate_T_unique,1),1); % ʹ�õĲ�ͬ�� T�͵ǻ�������
        Gate_use_time_S = zeros(Gate_nums,1);% 69*1 ʹ��ʱ��
        for g =1:Gate_S_use_num
            Gate_id  = Gate_S(g);   % �ǻ��� id
            flight_id = flight_S(g);% ����id
            in_time  = Flight_table(flight_id,1); % ���ൽʱ��
            out_time = Flight_table(flight_id,2); % �����뿪ʱ��
            if in_time < 24*60
                in_time = 24*60; % 20�����ʱ��
            end
            if out_time > 24*60*2
                out_time = 24*60*2;% 20 �����ʱ��
            end
            use_time = out_time - in_time; % �ôκ���ռ��ʱ��
            Gate_use_time_S(Gate_id) = Gate_use_time_S(Gate_id) + use_time;
        end
        % S_used_num = sum(Gate_use_time_S  ~= 0); % ռ��ʱ�䲻Ϊ0 �� �� ���Ǳ�ʹ����  S�͵ǻ�������
        S_used_rate = sum(Gate_use_time_S)  /( 24*60*S_used_num);% ��ʹ��ʱ�� / ������ʱ��
               
        
%% c�� ����ʧ���ÿ����� �� ����
      fail_passenger_nums = 0;
      passenger_nums = 0;
      
      passenger_time_nums_id = [];
      
      passenger_tension_nums_id = [];
      
   %  ʱ�� /���ų̶�
       Progress_time = 0;% ����ʱ��         
       Trans_time = 0; % ����ʱ��
       Walk_time = 0; % ����ʱ��
       Change_time = 0; % �ܻ���ʱ��
       Flight_time = 0; % �������� ����ʱ��
      
       for k = 1:Ticket_nums % ����ÿ��Ʊ�� ���� ʱ��
           peop_nums = Ticket_table(k,1);    % ����
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
           
           in_gate_loc = Gate_table(5,in_gate_id);    % ���ǻ��� �ն��� λ�� North=0 Center=1 South=2 East=3
           out_gate_loc = Gate_table(5,out_gate_id);  % �ߵǻ��� �ն��� λ�� North=0 Center=1 South=2 East=3 
           
           %% ȷ��  ����ʱ��� �� ����ʱ��� ����id
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
           
           %% ����ʱ��� λ�� id
           row = in_gate_type*3 + 1 + in_gate_loc;
           col = out_gate_type*3 + 1 + out_gate_loc;
           
           %% ��Ӧ ���е�ʱ�� 
           temp_time_proc = Progress_time_table(row_id,col_id);
           temp_time_trans = Trans_time_table(row_id,col_id);
           temp_time_walk = Work_time_table(row,col);
           
           in_time  = Flight_table(in_flight_id,1); % ������id ��ʱ��
           out_time = Flight_table(out_flight_id,2);% �ߺ���id ��ʱ��
		   
           all_time = temp_time_proc + temp_time_trans + temp_time_walk; % ������ʱ�� ����
		   % all_time = temp_time_proc ; % ����ʱ�� ���
             
		   if all_time < (out_time-in_time)
			% ���˳ɹ�
			   Change_time_ =  all_time * peop_nums;
            % �ɹ� �ÿ�����
            
           else
               all_time = 360; % 6 Сʱ  �˷� 
		    % ����ʧ��
		       Change_time_ =  all_time * peop_nums; % 6 Сʱ  �˷� 
		    % ����ʧ�� �ÿ�����
               fail_passenger_nums = fail_passenger_nums + peop_nums; % ����ʧ�ܵ� �ÿ�����
           end
           passenger_nums = passenger_nums + peop_nums; % �ܳ˿� 
           
           Flight_time_ = (out_time-in_time) * peop_nums; % ��Ʊ�� ��������ʱ��
           
           Tension_ = Change_time_/Flight_time_;  % ��Ʊ�� �˿ͽ��ų̶�
           
           passenger_tension_nums_id = [passenger_tension_nums_id; [Tension_, peop_nums]]; % ���ų̶� & �˿����� 
           
           Change_time = Change_time + Change_time_;% �ܻ���ʱ��
            
           passenger_time_nums_id = [passenger_time_nums_id; [all_time, peop_nums]]; % ����ʱ�� & �˿�����
           
		   Flight_time   = Flight_time + Flight_time_; % ��Ȩ���� ����ʱ���
       end  
       
       %% ����ʧ�ܵĳ˿����� �� ����
        fail_passenger_rate = fail_passenger_nums/passenger_nums;  % ����ʧ�ܵĳ˿����� �� ����
       
       %% �ÿ� ����ʱ�� �ֲ�
        max_time  = max(passenger_time_nums_id(:,1)); % ���ʱ��
        max_time5 = ceil(max_time/5)*5;% ��ȡ��5��
        passenger_time_num = zeros(max_time5/5,1);   % �ÿ�ʱ��ֲ�
        % passenger_time_rate = zeros(max_time5/5,1);   % �ÿ�ʱ��ֲ� ����
        for lk = 1:size(passenger_time_nums_id,1)
            time = passenger_time_nums_id(lk,1);     % ʱ��
            pass_num = passenger_time_nums_id(lk,2); % �˿�����
            passenger_time_num(ceil(time/5)) = passenger_time_num(ceil(time/5)) +  pass_num;
        end
        passenger_time_rate = passenger_time_num/passenger_nums;
        
       %% �ÿ� ���ų̶� �ֲ� 
        % passenger_tension_nums_id;
        max_tension = ceil(max(passenger_tension_nums_id(:,1))/0.1)*0.1;% �� ȡ�� 0.1��
        passenger_tension_num = zeros(max_tension/0.1, 1);   % �ÿ�ʱ��ֲ�
        for lk = 1:size(passenger_tension_nums_id,1)
            tension = passenger_tension_nums_id(lk,1);  % ���ų̶�
            pass_num = passenger_tension_nums_id(lk,2); % �˿�����
            passenger_tension_num(ceil(tension/0.1)) = passenger_tension_num(ceil(tension/0.1)) +  pass_num;
        end
        passenger_tension_rate = passenger_tension_num/passenger_nums; 
        
      %% �� ����ʱ�� = ����ʱ�� + ����ʱ�� + ����ʱ��
      %  Change_time  = Progress_time + Trans_time + Walk_time; % �� ����ʱ��
        
      %% �ÿ����廻�˽��ų̶�
       Tension = Change_time / Flight_time;
%}
