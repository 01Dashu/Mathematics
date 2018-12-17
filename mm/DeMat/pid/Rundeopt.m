%********************************************************************
% ��������㷨   PID������ ����
%********************************************************************

%% �Ż�ֹͣ ����
		F_VTR = 0; 
% Ŀ�꺯���Ĳ�������   KP  KI  KD
		I_D = 3; 
% ���� �ķ�Χ
      FVr_minbound = [0 0 0]; 
      FVr_maxbound = [100 1 1]; 
      I_bnd_constr = 1;        %1: ʹ��Լ��     
%% ��Ⱥ��������  Ϊ���� ��5~10��
		I_NP = 40;  
%% ����������
		I_itermax = 60; 
%% ���� ���� DE-stepsize F_weight ex [0, 2]]
		F_weight = 0.85; 
%% �������  crossover probabililty constant ex [0, 1]
		F_CR = 0.7; 

%% �㷨ѡ��
% I_strategy     1 --> DE/rand/1:          ����� DE������������㷨ģ��   ����  ��׼���� ����ѡȡ
%                2 --> DE/local-to-best/1: ³���Ժ� ����������  �㷨ģ��
%                3 --> DE/best/1 with jitter: ��ȺС ά�ȵ�    ��������   ����  ��׼���� ѡ���ŵĸ���
%                4 --> DE/rand/1 with per-vector-dither:
%                5 --> DE/rand/1 with per-generation-dither:
%                6 --> DE/rand/1 either-or-algorithm:          
		I_strategy = 3
%% ������Ϣ        
      I_refresh =  1; %�ӵڼ�����ʼ���  �м����
      I_plotting = 1; %�Ƿ���Ҫ��ͼ
      
%-----Problem dependent constant values for plotting----------------

% if (I_plotting == 1)
% 
% end

S_struct.I_NP         = I_NP;
S_struct.F_weight     = F_weight;
S_struct.F_CR         = F_CR;
S_struct.I_D          = I_D;
S_struct.FVr_minbound = FVr_minbound;
S_struct.FVr_maxbound = FVr_maxbound;
S_struct.I_bnd_constr = I_bnd_constr;
S_struct.I_itermax    = I_itermax;
S_struct.F_VTR        = F_VTR;
S_struct.I_strategy   = I_strategy;
S_struct.I_refresh    = I_refresh;
S_struct.I_plotting   = I_plotting;

%********************************************************************
% Start of optimization
%********************************************************************

%[FVr_x,S_y,I_nf] = deopt('objfun_constr',S_struct)
[FVr_x,S_y,I_nf] = deopt('objfun',S_struct)
