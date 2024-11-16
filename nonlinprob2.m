%x_dot=f+gu
%Kyriakos Vamvoudakis
%ARRI

clear
close all
clc



R=1;
Q=[1 0 ; 0 1];

% Giá trị khởi tạo 
% 2 giá trị đầu là state
% 3 giá trị sau là critic (3 số do gồm x1^2 , x1x2, x2^2)
% 3 giá trị sau cùng là actor
x0=[1 -1   rand(1,3) zeros(1,3)];
   
   options = odeset('OutputFcn',@odeplot);
   [t,x]= ode23('nonlindynamicsnew2',[0 100],x0,options);
 
figure (1);
plot(t,x(:,1:2));
title ('System States');
xlabel ('Time (s)');
figure (2);
plot(t,x(:,3:5));
title ('Parameters of the critic NN');
xlabel ('Time (s)');
legend ('W_{c1}','W_{c2}', 'W_{c3}');
 figure (3);
plot(t,x(:,6:8)); 
title ('Parameters of the actor NN');
xlabel ('Time (s)');
legend ('W_{a1}','W_{a2}', 'W_{a3}');


W=x(length(x),3:5);
H=x(length(x),6:8);

V=zeros(41,41);
Vtest=zeros(41,41);
for i=-2:0.1:2,
%     i
    for j=-2:0.1:2,
%         
phix=[i^2 i*j   j^2 ]';
dphix=[2*i 0; j i; 0 2*j];
              V(round(i*10+21),round(j*10+21))=W*phix;
  u(round(i*10+21),round(j*10+21))=-0.5*inv(R)*[0; (cos(2*i)+2)]'*dphix'*H';
utest(round(i*10+21),round(j*10+21))=-(cos(2*i)+2)*j;
              Vtest(round(i*10+21),round(j*10+21))=0.5*i^2+j^2;
 
    end
end
figure (4)
        mesh(-2:0.1:2,-2:0.1:2,V-Vtest);
% view([60,50,30]);
title('Approximation Error of the Value function');
xlabel('x1');
ylabel('x2');
zlabel('V-V*');

figure (6)

mesh(-2:0.1:2,-2:0.1:2,Vtest);
% view([60,50,30]);
title('Optimal Value function');
xlabel('x1');
ylabel('x2');
zlabel('V');
% utest(i*10+21)=-3.*j;

figure (7)

mesh(-2:0.1:2,-2:0.1:2,V);
% view([60,50,30]);
title('V approximated by online tuning');
xlabel('x1');
ylabel('x2');
zlabel('V');

figure (8)

mesh(-2:0.1:2,-2:0.1:2,u-utest);
% view([60,50,30]);
title('Error between the approximated control and the optimal one');
xlabel('x1');
ylabel('x2');
zlabel('u-u*');