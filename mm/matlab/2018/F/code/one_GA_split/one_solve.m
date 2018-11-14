
clc;
clear;
%% F:AGAP Problem

%% Problem 1
%function one_init
    Gate_W_nums = 24;
    Flight_W_nums  = 49;
    %Solution_W = zeros(Flight_W_nums,1+1);% �� ��
    Gate_W   = xlsread('Gate_W.xlsx'); %Լ��
    Flight_W = xlsread('Flight_W.xlsx'); %Լ��

    Gate_N_nums = 45;
    Flight_N_nums  = 254;
    % Solution_N = zeros(Flight_N_nums,1+1);
    Gate_N   = xlsread('Gate_N.xlsx'); %Լ��
    Flight_N = xlsread('Flight_N.xlsx'); %Լ��
    
    %% ����
    %{
    rowrankW = randperm(size(Flight_W, 1));
    Flight_W = Flight_W(rowrankW,:);
    
    rowrankN = randperm(size(Flight_N, 1));
    Flight_N = Flight_N(rowrankN,:);
    %}
    %% ��ʼ�� ��ʼ��Ⱥ�еĸ������Ž�
    %best_solution_W;
    best_Temp_gate_num_W_T = 100; % ���Ž� ��ʱ��ʹ������   Խ��Խ��  ���ȼ����
    best_Gate_free_num_W_T  = 0;   % ���Ž� �̶��� ��������  Խ��Խ��
    best_Score_W_init = -10000;
    
    best_Temp_gate_num_N_T = 100; % ���Ž� ��ʱ��ʹ������
    best_Gate_free_num_N_T  = 0;   % ���Ž� �̶��� ��������
    best_Score_N_init = -10000;
    
    % ��̭���õĲ����µ�
    best_Temp_gate_num_W_T_new = 100; % ���Ž� ��ʱ��ʹ������   Խ��Խ��  ���ȼ����
    best_Gate_free_num_W_T_new  = 0;   % ���Ž� �̶��� ��������  Խ��Խ��
    best_Score_W_new = -10000;
    
    best_Temp_gate_num_N_T_new = 100; % ���Ž� ��ʱ��ʹ������
    best_Gate_free_num_N_T_new  = 0;   % ���Ž� �̶��� ��������
    best_Score_N_new = -10000;
%{ 
    % ���һ��
    GS_N = size(Gate_N);
    Gate_nums_N = GS_N(2);   %�ǻ�������

    Solution_N = one_init2(Flight_N, Gate_N); %���1��

    Temp_gate_num_N = sum(Solution_N(:,Gate_nums_N+1)); % ��ʱ�� ʹ������   ��
    max1_N=0;
    for k=1:Gate_nums_N
         if sum(Solution_N(:,k))==0 %δռ��
            max1_N=max1_N+1;%δռ������     �̶��� ��������   ��
         end
    end 
%} 

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
   
%% ���Ÿ���
    %best_Solution_W=[];
    best_Score_W = -10000; % �÷�
    %best_Solution_N=[];
    best_Score_N = -10000; % 
   
   
%% ������ʼ��Ⱥ =====================================================================================
   NP_W = zeros(Flight_W_nums, 2, I_NP); % ��ʼ�����Ⱥ��
   NP_N = zeros(Flight_N_nums, 2, I_NP);
   
   max_itr = 300; % 500�ε��� �� ѡһ���õ� ���� ΪΪ��Ⱥ�еĸ���
   for n =1:I_NP
        str1 = sprintf('generate %d individual...',n);
        disp(str1)
        for i=1:max_itr
           
        %% W
            [Solution_W, Temp_gate_num_W,Gate_free_num_W] = one_init2(Flight_W, Gate_W); %���1��
           % Solution_W = one_init3(Flight_W, Gate_W); %���1��
            Score_W_init = Temp_gate_num_W * -100 + Gate_free_num_W;  %�ø���÷�

            if(Score_W_init > best_Score_W_init)
                best_Solution_W_init = Solution_W;
                best_Score_W_init = Score_W_init;
            end
            
        %% N
            [Solution_N, Temp_gate_num_N, Gate_free_num_N] = one_init2(Flight_N, Gate_N); %���1��
            %Solution_N = one_init3(Flight_N, Gate_N); %���1��
            Score_N_init = Temp_gate_num_N * -100 + Gate_free_num_N;  %�ø���÷�
   
            if(Score_N_init > best_Score_N_init)
                best_Solution_N_init  = Solution_N;
                best_Score_N_init = Score_N_init; %�÷�
            end      
        end  
       NP_W(:,:,n) =  best_Solution_W_init ;
       NP_N(:,:,n) =  best_Solution_N_init ;
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
   
   NP_W = one_crossover_mutation(NP_W, Flight_W, Gate_W, C_weight);
   NP_N = one_crossover_mutation(NP_N, Flight_N, Gate_N, C_weight);
   
%% ����  ======================================================================
    V_num = floor(V_weight * I_NP); % �����������
    str1 = sprintf('variation individual num %d ', V_num);
    disp(str1);
    
    c = randperm(numel(1:I_NP));
    V_NP = c(1:V_num);% �����������
    for m =1:V_num
        % str1 = sprintf('variation %d individual. ', m);
        % str1
        %W
        [NP_W(:,:,V_NP(m)) , Temp_gate_num_W, Gate_free_num_W] = one_variation( NP_W(:,:,V_NP(m)) , Flight_W, Gate_W);
        %N
        [NP_N(:,:,V_NP(m)) , Temp_gate_num_N, Gate_free_num_N] = one_variation( NP_N(:,:,V_NP(m)) , Flight_N, Gate_N); 
    end

%% ѡ��  ==============================================================================================
    str1 = sprintf('begin  select.');
    disp(str1)   
    % ���� ��Ӧ��ֵ
    NP_W_OBJ = zeros(I_NP,2);%�洢ÿ�� ���� ����Ӧ��ֵ (�� ��ʱ��ʹ������ �� �̶��ڿ������� �����ĵ÷�) �� ����Ⱥ�е�id
    NP_N_OBJ = zeros(I_NP,2);% score = ��ʱ��ʹ������*-100 + �̶��ڿ�������
    for k = 1:I_NP
        [Temp_gate_num_W, Gate_free_num_W] = one_score(NP_W(:,:,k),Gate_W_nums);
        NP_W_OBJ(k,1) = Temp_gate_num_W * -100 + Gate_free_num_W;  %�ø���÷�
        NP_W_OBJ(k,2) = k;% ����Ⱥ�е�id

        [Temp_gate_num_N, Gate_free_num_N] = one_score(NP_N(:,:,k),Gate_N_nums);
        NP_N_OBJ(k,1) = Temp_gate_num_N * -100 + Gate_free_num_N;
        NP_N_OBJ(k,2) = k;
    end
    % ����
    NP_W_OBJ = sortrows(NP_W_OBJ,-1); %���յ�һ�� ��������   ����ǰ��ĸ��� ��
    NP_N_OBJ = sortrows(NP_N_OBJ,-1); %���յ�һ�� ��������
    
    % ѡ����õĸ���
    if(NP_W_OBJ(1,1) > best_Score_W)
        best_Score_W = NP_W_OBJ(1,1); % �÷�
        best_Solution_W = NP_W(:,:,NP_W_OBJ(1,2)); % ��ǰ��õĸ���
    end

    if(NP_N_OBJ(1,1) > best_Score_N)
        best_Score_N = NP_N_OBJ(1,1); % �÷�
        best_Solution_N = NP_N(:,:,NP_N_OBJ(1,2)); % ��ǰ��õĸ���
    end

    
%% �����µĸ��� =======================================================================================

    died_num = floor((1-S_weight) * I_NP) ; % ��Ҫ��̭�� ��������
    died_id_W = NP_W_OBJ(I_NP - died_num + 1 : I_NP, 2);% ��̭���治�õĸ���
    died_id_N = NP_N_OBJ(I_NP - died_num + 1 : I_NP, 2);% ��̭���治�õĸ���
    
    str1 = sprintf('begin  generate %d new individuals', died_num);
    disp(str1)  
    
     max_itr = 300; % 500�ε��� �� ѡһ���õ� ���� ΪΪ��Ⱥ�еĸ���
    for l = 1: died_num
            str1 = sprintf('generate %d th new  individual',l);
            disp(str1)
            for i=1:max_itr

            %% W
              [Solution_W_new, Temp_gate_num_W,Gate_free_num_W] = one_init2(Flight_W, Gate_W); %���1��
              % Solution_W = one_init3(Flight_W, Gate_W); %���1��
              Score_W_new = Temp_gate_num_W * -100 + Gate_free_num_W;  %�ø���÷�
                
              if(Score_W_new > best_Score_W_new)
                    best_Solution_W_T_new = Solution_W_new;
                    best_Score_W_new = Score_W_new;
              end
            
            %% N
              [Solution_N_new, Temp_gate_num_N, Gate_free_num_N] = one_init2(Flight_N, Gate_N); %���1��
               %Solution_N = one_init3(Flight_N, Gate_N); %���1��
              Score_N_new = Temp_gate_num_N * -100 + Gate_free_num_N;  %�ø���÷�
                
              if(Score_N_new > best_Score_N_new)
                    best_Solution_N_T_new = Solution_N_new;
                    best_Score_N_new = Score_N_new;
              end    
             
            end  
           NP_W(:,:,died_id_W(l)) =  best_Solution_W_T_new ;
           NP_N(:,:,died_id_N(l)) =  best_Solution_N_T_new ;
    end
end

%%}

