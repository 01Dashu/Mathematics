
clc;
clear;
%% F:AGAP Problem

%% 1. ��������===========================================   
    Gate_nums = 69;    % �ܵǻ�������
    Flight_nums = 303; % �ܺ�������
    
   %% ����� 303�� 6�У�  
   %{
    1.��ʱ��(1~4320) 2.��ʱ��(1~4320)  3.������(I(0) / D(1)) 4.������(I(0) / D(1))
    5.����(W(1) / N(0)) 6.���index(1~303)
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
   
   %% ��Ʊ�˿�ʱ��� 1649�� 6�У�
   %{ 
     1.�˿�����(1~2)   2.���ﺽ��ID(1~303)  3.��������ID(1~303)  4.ʱ���  5.���index(1~1649)
   %}
   Ticket_table = xlsread('data\Ticket_table.xlsx');
   
   %% �ǻ�������ʱ��� 4��(����) DT(10) DS(11) IT(00) IS(01)  4��(����) DT(10) DS(11) IT(00) IS(01)
   Progress_time_table = xlsread('data\Progress_time_table.xlsx');
   
   %% ����ʱ��
   Trans_time_table = xlsread('data\Trans_time_table.xlsx');
   
   %% ����ʱ�� 
   Work_time_table = xlsread('data\Work_time_table.xlsx');
    
%% 2. �㷨�������� ======================================================================
%% ���Ÿ���
    best_Temp_gate_num= 100;       % ���Ž� ��ʱ��ʹ������   Խ��Խ��  ���ȼ����
    best_Progress_time = 10000000; % ���Ž� �˿� ����ʱ��    Խ��Խ��      ��
    best_Change_time   = 100000000;% ���Ž� �˿� ��תʱ��    Խ��Խ��      ��
    best_time_or_tension = 1000000;  % ���ų̶� ================           ��
    best_Gate_num  = 0;            % ���Ž� �̶��� ʹ������  Խ��Խ��      ���
    best_Score = -10000;           % �÷�
   
%% ��Ⱥ��������  Ϊ���� ��5~10��   500��
   I_NP = 50; 
        
%% ����������                   100��
   I_itermax = 100; 
        
%% ������� Variation
  V_weight = 0.4;
   
%% ������� crossover  �������Ҫ��飬ʹ�ñ������������н��ɿ�ѡ��
  C_weight = 0.4;
   
%% ѡ�� Sele ���µĸ���            0.85
   S_weight = 0.8;

%{
best_Temp_gate_num_init = 10000;      % ���Ž� ��ʱ��ʹ������   Խ��Խ��  ���ȼ����
best_Progress_time_init = 10000000;   % ���Ž� �˿� ����ʱ��              ��
best_Change_time_init   = 100000000;  % ���Ž� �˿� ��תʱ��              ��
best_Gate_num_init      = 10000;      % ���Ž� �̶��� ʹ������  Խ��Խ��   ���  
max_itr = 10000;
for i=1:max_itr
    i
    % ���룺���α� �ǻ��ڱ� ��Ʊ�� �˿�ʱ���
    % �����һ���� ��ʱ��ʹ������ ����ʱ�� �̶��ǻ���ʹ������
    [Solution, Temp_gate_num_init, time_or_tension, Gate_num_init] = three_init2(Flight_table, Gate_table,Ticket_table,Progress_time_table,Trans_time_table,Work_time_table); %���1��
    % Solution_W = one_init3(Flight_W, Gate_W); %���1��
    % Score_W_init = Temp_gate_num_W * -100 + Gate_free_num_W;  %�ø���÷�

    if((Temp_gate_num_init < best_Temp_gate_num_init )||...
      ((Temp_gate_num_init == best_Temp_gate_num_init ) && ( Progress_time_init <  best_Progress_time_init))||...
      ((Temp_gate_num_init == best_Temp_gate_num_init ) && ( Progress_time_init == best_Progress_time_init) && ( Gate_num_init < best_Gate_num_init))) 
        %    ��ʱ�ڸ���                   ��  ��ʱ�� ʹ������ ��ͬ,�� ���пڶ�
        best_Solution_init       = Solution;
        best_Temp_gate_num_init = Temp_gate_num_init; % ���ٵ� ��ʱ�� ʹ������
        best_Progress_time_init = Progress_time_init; % ���ٵ� ����ʱ��
        best_Gate_num_init      = Gate_num_init;      % ���ٵ� �̶��� ʹ������
    end
 end  
 %}  
   
%%{   
%% ������ʼ��Ⱥ ====================================================================
    % ��ʼ�� ��ʼ��Ⱥ�еĸ������Ž�
    % ��ʼ��
    best_Temp_gate_num_init = 10000;      % ���Ž� ��ʱ��ʹ������   Խ��Խ��  ���ȼ����
    best_Progress_time_init = 10000000;   % ���Ž� �˿� ����ʱ��              ��
    best_Change_time_init   = 100000000;  % ���Ž� �˿� ��תʱ��              ��
    best_time_or_tension_init = 1000000;  % ���ų̶� ================
    best_Gate_num_init  = 10000;          % ���Ž� �̶��� ʹ������  Խ��Խ��   ���
    best_Score_init = -10000;             % �÷�
    
    NP = zeros(Flight_nums, 2, I_NP); % 303*2 ��ʼ�����Ⱥ��  ��һ��:����ĵǻ��� �ڶ��У��ɱ����
   
    max_itr = 200; % 500�ε��� �� ѡһ���õ� ���� ��Ϊ��Ⱥ�еĸ���
    for n =1:I_NP
        str1 = sprintf('generate %d individual...',n);
        disp(str1)
        for i=1:max_itr
            % ���룺���α� �ǻ��ڱ� ��Ʊ�� �˿�ʱ���  ����ʱ�� ����ʱ��
            % �����һ���� ��ʱ��ʹ������ ����ʱ�� �̶��ǻ���ʹ������ 
            [Solution, Temp_gate_num_init, time_or_tension_init, Gate_num_init] = three_init2(Flight_table, Gate_table,Ticket_table,Progress_time_table,Trans_time_table,Work_time_table); %���1��
            % Solution_W = one_init3(Flight_W, Gate_W); %���1��
            % Score_W_init = Temp_gate_num_W * -100 + Gate_free_num_W;  %�ø���÷�

            if((Temp_gate_num_init < best_Temp_gate_num_init )||...
              ((Temp_gate_num_init == best_Temp_gate_num_init ) && ( time_or_tension_init <  best_time_or_tension_init))||...
              ((Temp_gate_num_init == best_Temp_gate_num_init ) && ( time_or_tension_init == best_time_or_tension_init) && ( Gate_num_init < best_Gate_num_init))) 
                %    ��ʱ�ڸ���                   ��  ��ʱ�� ʹ������ ��ͬ,�� ���пڶ�
                best_Solution_init        = Solution;
                best_Temp_gate_num_init   = Temp_gate_num_init; % ���ٵ� ��ʱ�� ʹ������
                best_time_or_tension_init = time_or_tension_init; % ���ٵ� ����ʱ��
                best_Gate_num_init        = Gate_num_init;      % ���ٵ� �̶��� ʹ������
                
            end
               
         end  
       NP(:,:,n) =  best_Solution_init ;
   end
%%}  

%%{
%% ��ʼ����===========================================================================================
for ll =1:I_itermax
   str1 = sprintf(' %d iter...',ll);
   disp(str1);
   
%% ���� �� ʹ�ñ������������н��ɿ��н�
   str1 = sprintf('begin crossover ...');
   disp(str1);
   
    NP = three_crossover_mutation(NP, Flight_table, Gate_table, C_weight);
   
%% ����  ======================================================================
    V_num = floor(V_weight * I_NP); % �����������
    str1 = sprintf('variation individual num %d ', V_num);
    disp(str1);
    
    c = randperm(numel(1:I_NP));
    V_NP = c(1:V_num);% �����������
    for m =1:V_num
     %[NP(:,:,V_NP(m)), Temp_gate_num_init, Progress_time_init, Gate_num_init] = three_variation( NP(:,:,V_NP(m)), Flight_table, Gate_table,Ticket_table,Progress_time_table); %���1��
     [NP(:,:,V_NP(m))] = three_variation( NP(:,:,V_NP(m)), Flight_table, Gate_table); %���1��
    end

%% ѡ��  ==============================================================================================
    str1 = sprintf('begin  select.');
    disp(str1)   
    % ���� ��Ӧ��ֵ
    NP_OBJ = zeros(I_NP,4);%�洢ÿ�� ���� ����Ӧ��ֵ (�� ��ʱ��ʹ������ �� ����ʱ�� ��  �̶���ʹ������  ) �� ����Ⱥ�е�id
    for k = 1:I_NP
        [T, P, G] = three_score(NP(:,:,k), Flight_table, Gate_table, Ticket_table, Progress_time_table, Trans_time_table, Work_time_table);
        NP_OBJ(k,1:3) = [T, P, G];   
        NP_OBJ(k,4) = k;% ����Ⱥ�е�id
    end
    
    % ����
    NP_OBJ = sortrow(NP_OBJ);
    
    % ѡ����õĸ���
    if((NP_OBJ(1,1) < best_Temp_gate_num )||...
      ((NP_OBJ(1,1) == best_Temp_gate_num ) && ( NP_OBJ(1,2) <  best_time_or_tension))||...
      ((NP_OBJ(1,1) == best_Temp_gate_num ) && (  NP_OBJ(1,2) == best_time_or_tension) && ( NP_OBJ(1,3) < best_Gate_num))) 
        %    ��ʱ�ڸ���                   ��  ��ʱ�� ʹ������ ��ͬ,�� ���пڶ�
        best_Solution      = NP(:,:,NP_OBJ(1,4));     % ��
        best_Temp_gate_num = NP_OBJ(1,1);             % ���ٵ� ��ʱ�� ʹ������
        best_time_or_tension = NP_OBJ(1,2);           % ���ٵ� ����ʱ��
        best_Gate_num      = NP_OBJ(1,3);             % ���ٵ� �̶��� ʹ������
    end

    
%% �����µĸ��� =======================================================================================

    died_num = ceil((1-S_weight) * I_NP) ; % ��Ҫ��̭�� ��������
    died_id = NP_OBJ(I_NP - died_num + 1 : I_NP, 4);% ��̭���治�õĸ���

    str1 = sprintf('begin  generate %d new individuals', died_num);
    disp(str1)  
    
    % �����µ�
    best_Temp_gate_num_new = 100;      % ���Ž� ��ʱ��ʹ������   Խ��Խ��  ���ȼ����
    best_Progress_time_new = 10000000; % ���Ž� �˿� ����ʱ��              ��
    best_Change_time_new   = 100000000;% ���Ž� �˿� ��תʱ��              ��
    best_time_or_tension_new = 1000000;% ���ų̶�
    best_Gate_free_num_new  = 0;       % ���Ž� �̶��� ʹ������  Խ��Խ��   ���
    best_Score_new = -10000;           % �÷�
    
     max_itr = 200; % 500�ε��� �� ѡһ���õ� ���� ΪΪ��Ⱥ�еĸ���
    for l = 1: died_num
        str1 = sprintf('generate %d th new  individual',l);
        disp(str1)
        for i=1:max_itr
            % ���룺���α� �ǻ��ڱ� ��Ʊ�� �˿�ʱ���
            % �����һ���� ��ʱ��ʹ������ ����ʱ�� �̶��ǻ���ʹ������
            [Solution, Temp_gate_num_new, time_or_tension_new, Gate_num_new] = three_init2(Flight_table, Gate_table,Ticket_table,Progress_time_table,Trans_time_table,Work_time_table); %���1��
            % Solution_W = one_init3(Flight_W, Gate_W); %���1��
            % Score_W_init = Temp_gate_num_W * -100 + Gate_free_num_W;  %�ø���÷�

            if((Temp_gate_num_new < best_Temp_gate_num_new )||...
              ((Temp_gate_num_new == best_Temp_gate_num_new ) && ( time_or_tension_new <  best_time_or_tension_new))||...
              ((Temp_gate_num_new == best_Temp_gate_num_new ) && ( time_or_tension_new == best_time_or_tension_new) && ( Gate_num_new < best_Gate_num_new))) 
                %    ��ʱ�ڸ���                   ��  ��ʱ�� ʹ������ ��ͬ,�� ���пڶ�
                best_Solution_new        = Solution;
                best_Temp_gate_num_new   = Temp_gate_num_new; % ���ٵ� ��ʱ�� ʹ������
                best_time_or_tension_new = time_or_tension_new; % ���ٵ� ����ʱ��
                best_Gate_num_new        = Gate_num_new;      % ���ٵ� �̶��� ʹ������
                
            end 
         end  
       NP(:,:,died_id(l)) =  best_Solution_new ;
    end
    
end

%%}

