%%{ 
% ���ر����Ľ⣬�Լ� �� ��ʱ��ʹ������ �� �̶��ۿ�������
function [Temp_gate_num, Gate_free_num] = one_score(Solu_soure)  
        SS = size(Solu_soure);
        Gate_nums = SS(2)-2;   % �ǻ�������
        Temp_gate_num = sum(Solu_soure( : , Gate_nums+1));  % ��ʱ�� ʹ������   ��
        Gate_free_num = 0;
        for j=1:Gate_nums
                if sum(Solu_soure(:,j))==0 % δռ��
                    Gate_free_num=Gate_free_num+1;% δռ������     �̶��� ��������   ��
                end
        end
             
end
%%}
      