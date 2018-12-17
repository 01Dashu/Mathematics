%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function:         PlotIt(FVr_temp,iter,S_struct)
% Author:           Rainer Storn
% Description:      PlotIt can be used for special purpose plots
%                   used in deopt.m.
% Parameters:       FVr_temp     (I)    ��������
%                   iter         (I)    ������������
%                   S_Struct     (I)    Լ��
% Return value:     -
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function PlotIt(FVr_temp,iter,S_struct)
global rin yout timef  %���룬�������ɢʱ��
%----First of four subplots.---------------------------------------
 % subplot(1,2,1)
 figure(1)
  hold on;
  S_MSE = objfun(S_struct.FVr_bestmem,S_struct);
  plot(iter,S_MSE.FVr_oa(1),'ro');                  % ÿһ���� ��Ӧ�Ⱥ���
  xlabel('����');ylabel('��Ӧ�Ⱥ���ֵ');
  title(sprintf('��õĵ÷�: %f',S_MSE.FVr_oa(1)));
  hold off;
 
 %subplot(1,2,2)  
 figure(2)
 %hold on;
 plot(timef,rin,'r',timef,yout,'b');% ϵͳ�������
 xlabel('ʱ��');ylabel('rin,yout');
% hold on;

  drawnow;
  pause(1); %wait for one second to allow convenient viewing
  return
