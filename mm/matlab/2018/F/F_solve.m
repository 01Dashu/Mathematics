
clc;
clear;
%% F:AGAP Problem

%% 1. ��������===========================================   
    Gate_nums = 69;    % �ܵǻ�������
    Flight_nums = 303;  % �ܺ�������
    
   %% ����� 303�� 6�У�  
   %{
1.��ʱ��(1~4320)    2.��ʱ��(1~4320)
3.������(I(0) / D(1))  4.������(I(0) / D(1))
    5.����(W(1) / N(0))   6.���index(1~303)
   %}
    Flight_table = xlsread('data\Flight_table.xlsx');
   
   %% �ǻ��ڱ� 6�� 69�У� 
   %{
     1.������(I(0) / D(1) /  I/D(2))  
     2.������(I(0) / D(1)/  I/D(2)) 
     3.�����ն���(T(0) / S(1)) 
     4.֧�ֻ���(W(1) / N(0))  
     5.����λ��(North=0 Center=1 South=2 East=3)
     6.���index(1~69)
   %} 
   Gate_table = xlsread('data\Gate_table.xlsx');
   
   %% ��Ʊ�˿�ʱ��� 1649�� 5�У�
   %{ 
      1.�˿�����(1~2)   2.���ﺽ��ID(1~303)  
3.��������ID(1~303)  4.ʱ���  
5.���index(1~1649)
   %}
   Ticket_table = xlsread('data\Ticket_table.xlsx');
   
   %% �ǻ�������ʱ��� 4��(����) DT(10) DS(11) IT(00) IS(01)  4��(����) DT(10) DS(11) IT(00) IS(01)
   Progress_time_table = xlsread('data\Progress_time_table.xlsx');
   
   %% ����ʱ�� 4*4
   Trans_time_table = xlsread('data\Trans_time_table.xlsx');
   
   %% ����ʱ�� 
   Work_time_table = xlsread('data\Work_time_table.xlsx');
    
%% 2. �㷨�������� ================================
%% ���Ÿ���
    best_Temp_gate_num= 1000; % ���Ž���ʱ��ʹ������Խ��Խ�����ȼ����
    best_Progress_time  = 10000000;  %���Ž� �˿� ����ʱ��Խ��Խ��  ��
    %best_Change_time   = 100000000; % ���Ž�˿���תʱ��Խ��Խ��  ��
    best_time_or_tension = 1000000;  % ���ų̶�                    ��
    best_Gate_num  = 10000;          % ���Ž� �̶��� ʹ������  Խ��Խ��     ���
    % best_Score = -10000; % �÷�
   
%% ��Ⱥ��������  Ϊ���� ��5~10��   500��
   I_NP = 500; 
        
%% ����������                     100��
   I_itermax = 100; 
        
%% ������� Variation
   V_weight = 0.4;
   
%% ������� crossover  �������Ҫ��飬ʹ�ñ������������н��ɿ�ѡ��
   C_weight = 0.4;
   
%% ѡ�� Sele ���µĸ���   0.8
   S_weight = 0.8;

  
%% 3. ������ʼ��Ⱥ ========================
    % ��ʼ�� ��ʼ��Ⱥ�еĸ������Ž�
    % ��ʼ��
    best_Temp_gate_num_init=1000;%���Ž���ʱ��ʹ������Խ�ٺ����ȼ����
    best_Progress_time_init=10000000;% ���Ž�˿͹���ʱ��        ��
    %best_Change_time_init=100000000; %���Ž����תʱ��         ��
    best_time_or_tension_init =1000000;  % ���ų̶�==========   ��
    best_Gate_num_init  = 10000;  % ���Ž� �̶���ʹ������Խ��Խ�� ���
    % best_Score_init = -10000;       % �÷�
    
NP = zeros(Flight_nums, 2, I_NP); 
% 303*2 ��ʼ�����Ⱥ��  ��һ��:����ĵǻ��� �ڶ��У��ɱ����
   
    max_itr = 200; % 200�ε��� �� ѡһ���õ� ���� ��Ϊ��Ⱥ�еĸ���
    for n =1:I_NP
        str1 = sprintf('generate %d individual...',n);
        disp(str1)
        for i=1:max_itr
% ���룺���α� �ǻ��ڱ� ��Ʊ��Ticket_table  �˿�ʱ���Progress_time_table   
% ����ʱ��� Trans_time_table   ����ʱ��� Work_time_table
% �����һ���� ��ʱ��ʹ������   ����ʱ��/���ų̶�  �̶��ǻ���ʹ������ 
 [Solution, Temp_gate_num_init, time_or_tension_init, Gate_num_init] = three_init2( Flight_table, Gate_table,Ticket_table,  Progress_time_table, Trans_time_table, Work_time_table ); 

if((Temp_gate_num_init < best_Temp_gate_num_init )||...
 ((Temp_gate_num_init == best_Temp_gate_num_init ) && ( time_or_tension_init <  best_time_or_tension_init))||...
 ((Temp_gate_num_init == best_Temp_gate_num_init ) && ( time_or_tension_init == best_time_or_tension_init) && ( Gate_num_init < best_Gate_num_init))) 
%    ��ʱ�ڸ���  ��  ��ʱ��ʹ��������ͬ, �ҽ��Ŷ�С  ��  ��ʱ��ʹ������ �ͽ��Ŷ���ͬ, �ҹ̶���ʹ��������

  best_Solution_init       = Solution;
  best_Temp_gate_num_init = Temp_gate_num_init; % ���ٵ� ��ʱ�� ʹ������
  best_time_or_tension_init = time_or_tension_init; % ���ٵ� ����ʱ��/���ų̶�
  best_Gate_num_init     = Gate_num_init;     % ���ٵ� �̶��� ʹ������
                
end
               
end  
NP(:,:,n) =  best_Solution_init ;% ��ʼ����
   end

%% 4. ��ʼ����=============================================
   % 5 -> 6 -> 7 -> 8 -> 5 -> 6 -> 7 -> 8 -> ...
for ll =1:I_itermax
   str1 = sprintf(' %d iter...',ll);
   disp(str1);
   
%% 5. ���� �� ʹ�ñ����� �������н��ɿ��н�===================
   str1 = sprintf('begin crossover ...');
   disp(str1);
   
   NP = three_crossover_mutation(NP, Flight_table, Gate_table, C_weight);
   
%% 6. ����  =================================================
    V_num = floor(V_weight * I_NP); % �����������
    str1 = sprintf('variation individual num %d ', V_num);
    disp(str1);
    c = randperm(numel(1:I_NP));
    V_NP = c(1:V_num);% �����������
    for m =1:V_num
     [NP(:,:,V_NP(m))]=three_variation(NP(:,:,V_NP(m)),Flight_table, Gate_table); 
    end

%% 7. ѡ��  ===============================================
    str1 = sprintf('begin  select.');
    disp(str1)   
    % ���� ��Ӧ��ֵ
    NP_OBJ = zeros(I_NP,4);
% �洢ÿ�� ���� ����Ӧ��ֵ ( �� ��ʱ��ʹ������ ��  ����ʱ��/���ų̶�  ��  �̶���ʹ������  ) �� ����Ⱥ�е�id
    for k = 1:I_NP
        [T, P, G] = three_score(NP(:,:,k), Flight_table, Gate_table, Ticket_table, Progress_time_table, Trans_time_table, Work_time_table);
        NP_OBJ(k,1:3) = [T, P, G];   
        NP_OBJ(k,4) = k;% ����Ⱥ�е�id
    end
    
    % �� ��һ�� �ڶ��� ������ ���� 
    NP_OBJ = sortrow(NP_OBJ);
    
    % ѡ����õĸ���
    if((NP_OBJ(1,1) < best_Temp_gate_num )||...
     ((NP_OBJ(1,1) == best_Temp_gate_num ) && ( NP_OBJ(1,2) <  best_time_or_tension))||...
     ((NP_OBJ(1,1) == best_Temp_gate_num ) && (  NP_OBJ(1,2) == best_time_or_tension) && ( NP_OBJ(1,3) < best_Gate_num))) 
      % ��ʱ�ڸ���   ��  ��ʱ��ʹ��������ͬ,�ҽ��Ŷ�С  ��  ��ʱ��ʹ������ �ͽ��Ŷ���ͬ,�ҹ̶���ʹ��������
     best_Solution      = NP(:,:,NP_OBJ(1,4));  % ��
     best_Temp_gate_num = NP_OBJ(1,1);       % ���ٵ� ��ʱ�� ʹ������
     best_time_or_tension = NP_OBJ(1,2);     % ���ٵ� ����ʱ��/���ų̶�
     best_Gate_num     = NP_OBJ(1,3);        % ���ٵ� �̶��� ʹ������
    end

    
%% 8. �����µĸ��� ===========================================

    died_num = ceil((1-S_weight) * I_NP) ; % ��Ҫ��̭�� ��������
    died_id = NP_OBJ(I_NP - died_num + 1 : I_NP, 4);% ��̭���治�õĸ���

    str1 = sprintf('begin  generate %d new individuals', died_num);
    disp(str1)  
    
    % �����µ�
    best_Temp_gate_num_new=1000;%���Ž���ʱ��ʹ������Խ�ٺ����ȼ����
    best_Progress_time_new=10000000; % ���ų˿͹���ʱ��       ��
    %best_Change_time_new=100000000;% ���Ž�˿���תʱ��       ��
    best_time_or_tension_new = 1000000;% ���ų̶�
    best_Gate_num_new  = 10000;    %���Ž�̶���ʹ������Խ��Խ�����
    %  best_Score_new = -10000;         % �÷�
    
     max_itr = 200; % 200�ε��� �� ѡһ���õ� ���� ΪΪ��Ⱥ�еĸ���
    for l = 1: died_num
        str1 = sprintf('generate %d th new  individual',l);
        disp(str1)
        for i=1:max_itr
 % ���룺���α� �ǻ��ڱ�  ��Ʊ�� Ticket_table  �˿�ʱ��� Progress_time_table����ʱ��� Trans_time_table ����ʱ��� Work_time_table
 % �����һ���� ��ʱ��ʹ������  ����ʱ��/���ų̶�  �̶��ǻ���ʹ������
[Solution, Temp_gate_num_new, time_or_tension_new, Gate_num_new] 
=three_init2(Flight_table, Gate_table, Ticket_table, Progress_time_table, Trans_time_table,  Work_time_table); %���1��
   if((Temp_gate_num_new < best_Temp_gate_num_new )||...
    ((Temp_gate_num_new==best_Temp_gate_num_new)&& ( time_or_tension_new <  best_time_or_tension_new))||...
    ((Temp_gate_num_new==best_Temp_gate_num_new)&& ( time_or_tension_new == best_time_or_tension_new) && ( Gate_num_new < best_Gate_num_new))) 
 %    ��ʱ�ڸ���   ��  ��ʱ��ʹ��������ͬ,�ҽ��Ŷ�С�� ��ʱ��ʹ������ �ͽ��Ŷ���ͬ,�ҹ̶���ʹ��������
   best_Solution_new       = Solution;
   best_Temp_gate_num_new = Temp_gate_num_new; %���ٵ���ʱ��ʹ������
   best_time_or_tension_new = time_or_tension_new; % ���ٵ� ����ʱ��
   best_Gate_num_new     = Gate_num_new;  % ���ٵ� �̶��� ʹ������
                
            end 
         end  
       NP(:,:,died_id(l)) =  best_Solution_new ; % �¸����滻��̭�ĸ���
    end
    
end
