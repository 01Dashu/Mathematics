%%{ 
%  ��ʱ��ʹ������  ʱ��/���ų̶� �̶���ʹ������
function [Temp_gate_num, Tension, Gate_used_num] = three_score(Solu, Flight_table, Gate_table, Ticket_table, Progress_time_table, Trans_time_table,Work_time_table) 
% Progress_time   Change_time
        %FS = size(Flight_table);
        GS = size(Gate_table);
        TS = size(Ticket_table);
        % Flight_nums = FS(1); % ��������   303 
        Gate_nums = GS(2);   % �ǻ������� 69    70 Ϊ��ʱ�ǻ���
        Ticket_nums = TS(1); % ��Ʊ Ʊ������ 1649
        
        
%% Temp_gate_num ��ʱ��ʹ������ 
        Temp_gate_num = sum( Solu(:,1) == Gate_nums+1 );  % ��ʱ�� ʹ������   ��
        
%% Gate_num      �̶��ǻ���ʹ������
      
        Gate_free_num = 0;
        for j=1:Gate_nums
                if sum( Solu(:,1) == j ) == 0 % δռ��
                    Gate_free_num = Gate_free_num+1;% δռ������     �̶��� ��������   ��
                end
        end
        Gate_used_num = Gate_nums - Gate_free_num; % �̶��ǻ���ʹ������
        
%%  ʱ�� /���ų̶�
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
           
           in_gate_loc = Gate_table(5,in_gate_id);   % ���ǻ��� �ն��� λ�� North=0 Center=1 South=2 East=3
           out_gate_loc = Gate_table(5,out_gate_id); % �ߵǻ��� �ն��� λ�� North=0 Center=1 South=2 East=3 
           
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
           
           % ����ʱ��� λ��
           row = in_gate_type*3 + 1 + in_gate_loc;
           col = out_gate_type*3 + 1 + out_gate_loc;
           
           temp_time_proc = Progress_time_table(row_id,col_id);
           temp_time_trans = Trans_time_table(row_id,col_id);
           temp_time_walk = Work_time_table(row,col);
           
           in_time  = Flight_table(in_flight_id,1); % ������id ��ʱ��
           out_time = Flight_table(out_flight_id,2);% �ߺ���id ��ʱ��
		   
           all_time = temp_time_proc + temp_time_trans + temp_time_walk; % ������ʱ��
		   
		   if all_time < (out_time-in_time)
			% ���˳ɹ�
			   %Progress_time = Progress_time + temp_time_proc * peop_nums;   % ����ʱ��
			   %Trans_time    = Trans_time    + temp_time_trans * peop_nums;  % ����ʱ��
			   %Walk_time     = Walk_time     + temp_time_walk * peop_nums;   % ����ʱ�� Walk_time
			   
			   Change_time = Change_time + all_time * peop_nums;
		   else
		    % ����ʧ��
		       Change_time = Change_time + 360 * peop_nums; % 6 Сʱ  �˷� 
		   
		   end
		   
		   
		   Flight_time   = Flight_time   + (out_time-in_time)*peop_nums; % ��Ȩ���� ����ʱ���
       end  
       
        
      %% �� ����ʱ�� = ����ʱ�� + ����ʱ�� + ����ʱ��
       % Change_time  = Progress_time + Trans_time + Walk_time; % �� ����ʱ��
        
      %% �ÿ����廻�˽��ų̶�
       Tension = Change_time / Flight_time;
         
end
%%}
      