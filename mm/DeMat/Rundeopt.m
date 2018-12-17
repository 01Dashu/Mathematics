%********************************************************************
% ��������㷨
%********************************************************************
%% �Ż�ֹͣ ����
		F_VTR = 0;  % Ŀ�꺯������ֵ ����
% Ŀ�꺯���Ĳ������� 
		I_D = 3; 


% ���� �ķ�Χ
      FVr_minbound = -6*ones(1,I_D); 
      FVr_maxbound = +6*ones(1,I_D); 
      I_bnd_constr = 0;  % �Ƿ�ʹ�� ��Χ����  1 ʹ��  0  ��ʹ��     
            
%% ��Ⱥ��������  Ϊ���� ��5~20��  5~10��
		I_NP = 40; 
        
%% ����������
		I_itermax = 50; 
       
%% ���� ���� DE-stepsize F_weight ex [0, 2]
		F_weight = 0.3; 

%% �������  crossover probabililty constant ex [0, 1]
		F_CR = 0.5; 
        
%% �㷨ѡ��
% I_strategy     1 --> DE/rand/1:          ����� DE������������㷨ģ��   ����  ��׼���� ����ѡȡ
%                2 --> DE/local-to-best/1: ³���Ժ� ����������  �㷨ģ��
%                3 --> DE/best/1 with jitter: ��ȺС ά�ȵ�    ��������   ����  ��׼���� ѡ���ŵĸ���
%                4 --> DE/rand/1 with per-vector-dither:
%                5 --> DE/rand/1 with per-generation-dither:
%                6 --> DE/rand/1 either-or-algorithm:         

		I_strategy = 5

%% ������Ϣ����        
      I_refresh = 10; %�ӵڼ�����ʼ���  �м����
      I_plotting = 0; %�Ƿ���Ҫ��ͼ

% %% ----��ͼ�Ĳ���------------------------------------- 2ά
if (I_plotting == 1)      
   FVc_xx = [-6:0.2:6]';
   FVc_yy = [-6:0.2:6]';

   [FVr_x,FM_y]=meshgrid(FVc_xx',FVc_yy') ;
   FM_meshd = 20+((FVr_x).^2-10*cos(2*pi*FVr_x)) +...
        ((FM_y).^2-10*cos(2*pi*FM_y));
      
   S_struct.FVc_xx       = FVc_xx;
   S_struct.FVc_yy       = FVc_yy;
   S_struct.FM_meshd     = FM_meshd;
end

S_struct.I_NP         = I_NP;    %��Ⱥ��С
S_struct.F_weight     = F_weight;%�������
S_struct.F_CR         = F_CR;    %���������
S_struct.I_D          = I_D;     % ��������
S_struct.FVr_minbound = FVr_minbound;%����
S_struct.FVr_maxbound = FVr_maxbound;%����
S_struct.I_bnd_constr = I_bnd_constr;%�Ƿ�ʹ�ý�������
S_struct.I_itermax    = I_itermax;   %����������
S_struct.F_VTR        = F_VTR;       %���ź����Ż�����
S_struct.I_strategy   = I_strategy;  %����ģ��ѡ��
S_struct.I_refresh    = I_refresh;   %�������ѡ��
S_struct.I_plotting   = I_plotting;  %��ͼѡ��


%********************************************************************
% Start of optimization
%********************************************************************

[FVr_x,S_y,I_nf] = deopt('objfun',S_struct)

