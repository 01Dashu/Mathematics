%********************************************************************
% ��������㷨
%********************************************************************
clear;clc;close all;
%% �Ż�ֹͣ ����
		F_VTR = 1.e-8; 
% Ŀ�꺯���Ĳ������� 
		I_D = 2; 
% ���� �ķ�Χ
      FVr_minbound = -10*ones(1,I_D); 
      FVr_maxbound = 10*ones(1,I_D); 
      I_bnd_constr = 1;  %1: use bounds as bound constraints, 0: no bound constraints      
            
%% ��Ⱥ��������  Ϊ���� ��5~10��
		I_NP = 20;  %pretty high number - needed for demo purposes only

%% ����������
		I_itermax = 3000; 
%% ���� ���� DE-stepsize F_weight ex [0, 2]
		F_weight = 0.85; 

%% �������  crossover probabililty constant ex [0, 1]
		F_CR = 0.5; 

        
%% �㷨ѡ��
% I_strategy     1 --> DE/rand/1:          ����� DE������������㷨ģ��   ����  ��׼���� ����ѡȡ
%                2 --> DE/local-to-best/1: ³���Ժ� ����������  �㷨ģ��
%                3 --> DE/best/1 with jitter: ��ȺС ά�ȵ�    ��������   ����  ��׼���� ѡ���ŵĸ���
%                4 --> DE/rand/1 with per-vector-dither:
%                5 --> DE/rand/1 with per-generation-dither:
%                6 --> DE/rand/1 either-or-algorithm:                 
		I_strategy = 1


%% ������Ϣ     
      I_refresh =  3;  %�ӵڼ�����ʼ���  �м����
      I_plotting = 1; %�Ƿ���Ҫ��ͼ
      
%-----Problem dependent constant values for plotting----------------
% if (I_plotting == 1)
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

[FVr_x,S_y,I_nf] = deopt('objfun',S_struct)

