%%{ 
    function [Solu] = one_init(Flight_table, Gate_table)
        %% խ��� N 
        FS = size(Flight_table);
        GS = size(Gate_table);
        Flight_nums = FS(1); %��������
        Gate_nums = GS(2);   %�ǻ�������
        
        Solu = zeros(Flight_nums, Gate_nums+1); % ��ʼ����
        
        Gate_time_net = zeros( Flight_nums*2 ,Gate_nums); % ���Ż� �м����
        
        Gate_time = zeros(1, Gate_nums);% ��������ʱ��
        p=0;
        
        temp_flag = 0;
        
        for i = 1:Flight_nums % ����ÿ������
            
           %i
           index = ceil(rand()*Gate_nums);%ѡ��һ�� �ǻ���
           
           f1 = ((Flight_table(i,3)==0)&&((Gate_table(1,index)==1)));
           f2 = ((Flight_table(i,3)==1)&&((Gate_table(1,index)==0)));
           f3 = ((Flight_table(i,4)==0)&&((Gate_table(2,index)==1)));
           f4 = ((Flight_table(i,4)==1)&&((Gate_table(2,index)==0)));

           f5 = ( Flight_table(i, 1) < Gate_time(index));

           while( f1 || f2 || f3 || f4 || f5 )
                index = ceil(rand()*Gate_nums);
                p=p+1;
                %p
                % i

               f1 = ((Flight_table(i,3)==0)&&((Gate_table(1,index)==1)));
               f2 = ((Flight_table(i,3)==1)&&((Gate_table(1,index)==0)));
               f3 = ((Flight_table(i,4)==0)&&((Gate_table(2,index)==1)));
               f4 = ((Flight_table(i,4)==1)&&((Gate_table(2,index)==0)));

               f5 = ( Flight_table(i, 1) <= Gate_time(index)); % �ǲ������ ������

               in_time = Flight_table(i, 1);       %�ú��ൽʱ��
               out_time = Flight_table(i, 2) + 45; %�ú����뿪ʱ�� + 45 


               if(p >100)
                   
                   Solu(i, Gate_nums+1) = 1;
                   p = 0;
                   temp_flag = 1; % ������ʱͣ����                
                   break;
               end 
               %f1 
               %f2 
               %f3 
               %f4 
               %f5
           end
           
           if(temp_flag)
               temp_flag = 0;
               continue
           end
           
           Solu(i,index) = 1;
           Gate_time(index) = Flight_table(i, 2) + 45;   
           
        end
    end
%%}
      