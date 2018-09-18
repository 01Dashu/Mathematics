function [x,f]=L01p_e(c,A,b,N)
% 枚举法求解 0-1线性规划问题
% [x,f]= L01p_e(c,A,b,N) 用枚举法求解下列
%       0-1线性规划问题
%       min f=c'*x, s.t. A*x<=b,x的分量全为整数0或1,
%  其中N表示约束条件 Ax ≤ b中的前N个是等式，N= 0时可以省略。
%  返回结果x是最优解，f是最优解处的函数值。
%  
%例 max f=3*x1 + 5*x2 + 2*x3 + 4*x4 + 2*x5 + 3*x6  函数时最小化目标
%   s.t. 8*x1 + 13*x2 + 6*x3 + 9*x4 + 5*x5 + 7*x6 <= 24, x1,…,x6均为0或1
%求解
%  c=-[3,5,2,4,2,3]; a=[8,13,6,9,5,7]; b=24;
%  x = l01p_e(c,a,b)

% By X.D. Ding， June 2000

if nargin<4,N=0;end
c=c(:);b=b(:);
[m,n]=size(A);x=[];f=abs(c')*ones(n,1);i=1;
while i<=2^n
   B=de2bi(i-1,n)';
   t=A*B-b;t11=find(t(1:N,:)~=0);
   t12=find(t(N+1:m,:)>0);t1=[t11;t12];
   if isempty(t1)
      f=min([f,c'*B]);
      if c'*B==f,x=B;end
   end
   i=i+1;
end

