%Name: Kyriakos Vamvoudakis
%company: ARRI
%date: 2008
%All rights reserved
%The air craft system 
%x_dot=Ax+Bu
%B=[0 0 1]';
%A=[-1.01887 0.90506 -0.00215; 0.82225 -1.07741 -0.17555; 0 0 -1];

function xout=dynamicsnew3(t,x)
global R;
global g;
global dphix;
global H;
global W;
% global t;
a=50; % hệ số học của critic
b=1; % hình như là của cái tốc độ cập nhật actor
R=1;
Q=[1 0 0 ; 0 1 0 ; 0 0 1];
% t=0;
% 3 phần tử đầu của x là vector trạng thái
x1=x(1);
x2=x(2);
x3=x(3);
% 6 trọng số neuron đầu tiên
W=[x(4) x(5) x(6) x(7) x(8) x(9) ]';
% 6 trọng số neuron tiếp theo
H=[x(10) x(11) x(12) x(13) x(14) x(15) ]';
% u=[x(9)];


% Phix là dùng kích hoạt (thay vì dùng các hàm sigmoid hay tanh thì ta chọn
% dùng hàm đa thức nhưng vẫn phải đảm bảo tính bị chặn cho hàm này)
% vec_diag(x^T * x) = phix
phix=[x1^2 x1*x2 x1*x3 x2^2 x2*x3 x3^2]';
% Việc lấy gradient của phix khá khó chịu và đi thi có thể gặp
% Quá trình lấy gradient của phix trên x như sau:
% Mỗi hàng của ma trận dphix/dx tương ứng đạo hàm phix cho vector x
% Ví dụ cho hàng đầu tiên của dphix tức là đạo hàm x1^2 theo lần lượt x1,
% x2 và x3 -> thu được lần lượt 2x1, 0 , 0
dphix=[2*x1 0 0; x2 x1 0; x3 0 x1; 0 2*x2 0; 0 x3 x2; 0 0 2*x3];
% f này là phương trình của đối tượng điều khiển thôi
f=[-1.01887*x1+0.90506*x2-0.00215*x3;0.82225*x1-1.07741*x2-0.17555*x3;-1*x3];
g=[0; 0;1];
u=-0.5*inv(R)*g'*dphix'*H; %PT 5.14
s=dphix*f+dphix*g*u;
Y=(-[x1 x2 x3]*Q*[x1 x2 x3]'-u*R*u');% Lý do có dấu trừ là luật cập nhật critic
e=W'*s-Y;

%     W(:,k+1)=W(:,k)-e(k)*a*(s(:,k)/(s(:,k)'*s(:,k)+1));
% W(:,k+1)=W(:,k)-a*s(:,k)*(e(k));
%


p=(-0.5*inv(R)*g'*dphix')';

e2= p'*(H -W);

     E2= H -W;
     Win=-a*(s./(s'*s+1)^2)*e'; % Là cái pt cập nhật critic trong slide số 8
%      Hin=-b*tanh(E2);
%     Hin=0.25*dphix*g*inv(R)*g'*dphix'*(W-H);
%     Hin=0.25*b*inv(R)*g'*dphix'*(W-H)*dphix*g*inv(R)';
 F=10;%Positive definite matrix  
%  D1=dphix*g*inv(R)*g'*dphix';
% Hin=0.5*b*D1*(W-H)+0.25*b*D1*H*(s'./(s'*s+1)^2)*W;
%  F1=10*ones(1,length(H));

 F1=1*eye(length(W));

 sbar=(s/(s'*s+1));
 
  
 D1=dphix*g*inv(R)*g'*dphix';
 
 F2=10*eye(length(H));
 
Hin=b*(F2*W-F2*H)+0.25*b*D1*H*(s'./(s'*s+1)^2)*W; % Là cái phương trình cập
% nhật actor trên cái slide 9/18 trỏ vào actor

% Tắt nhiễu ở đây
if t<=1000
unew=((u)+exp(-0.001*t)*37*(sin(t)^2*cos(t)+sin(2*t)^2*cos(0.1*t)+sin(-1.2*t)^2*cos(0.5*t)+sin(t)^5+sin(1.12*t)^2+cos(2.4*t)*sin(2.4*t)^3));
% Tại sao lại dùng cái unew này thay vì cái unew ở trên
% Nói lại câu chuyện về kích thích tập mẫu
% Tạo nhiễu ống (pipe noise)
% u_new dưới này nếu vẽ ra so với unew trên thì sẽ bớt nhiễu hơn và luôn nằm
% trong một vùng an toàn (chặn dưới và chặn trên hoàn toàn)
% , thay vì lớn dần theo trục âm như unew ở trên
%unew=u+2*(sin(t)^2*cos(t)+sin(2*t)^2*cos(0.1*t)+sin(-1.2*t)^2*cos(0.5*t)+sin(t)^5);
else
    unew=u;

end

     xout=[f+g*unew; Win ;Hin];