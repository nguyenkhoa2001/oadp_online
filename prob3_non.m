%Name: Kyriakos Vamvoudakis
%company: ARRI
%date: 2008
%All rights reserved
%The air craft system 
%x_dot=Ax+Bu
%B=[0 0 1]';
%A=[-1.01887 0.90506 -0.00215; 0.82225 -1.07741 -0.17555; 0 0 -1];


clear all
close all
clc

% global t;

R=1;
Q=eye(2);
% g=[1; 3.5;0 ];
% 
x0=[1 -1 ones(1,3) rand(1,3)];
% z(1,:)=x0;
% f=[-0.376*x0(1)+x0(2) ;-1.8115*x0(1)+2*x0(3);0.725*x0(1)]; 
% phixx=[x0(1)^2 x0(1)*x0(2) x0(1)*x0(3)   x0(2)^2 x0(2)*x0(3) x0(3)^2];
% dphixx=[2*x0(1) 0 0 ; x0(2) x0(1) 0 ; x0(3) 0  x0(1); 0 2*x0(2) 0;0 x0(3) x0(2); 0 0 2*x0(3) ];
% uo(1)=-0.5*inv(R)*g'*dphixx'*[x0(10) x0(11) x0(12) x0(13) x0(14) x0(15) ]';
% V(1)=[x0(4) x0(5) x0(6) x0(7) x0(8) x0(9) ]*phixx';
% Y(1)=[x0(4) x0(5) x0(6) x0(7) x0(8) x0(9) ]*dphixx*(f+g*uo(1))+([x0(1) x0(2) x0(3) ]*Q*[x0(1) x0(2) x0(3) ]'+uo(1)*R*uo(1)')  ;

% e2(1)= p'*([x0(6) x0(7) x0(8)] -[x0(3) x0(4) x0(5)])';   
% for policy=2:10
% policy
 
%  
%  options = odeset('InitialStep',1,...
%                'MaxStep',500,'RelTol',1e-5,'AbsTol',1e-4,'OutputFcn',@odeplot);
   options = odeset('OutputFcn',@odeplot);
%  [t,x]=ode23(@sys,[tstart tfinal],x0,options);
   [t,x]= ode23('dynamicsnew3_non',[0 1000],x0,options);
%    x01=[1 1 -2 x(length(x),1:12)];
%    [t,x]= ode23('dynamicsnew3',[0 500],x01,options);
%     
%    H=[x(length(t),6) x(length(t),7) x(length(t),8)]';
% x0=[x(length(t),1) x(length(t),2) x(length(t),3)  x(length(t),4) x(length(t),5) x(length(t),6) x(length(t),7)  x(length(t),8) x(length(t),9) x(length(t),10) x(length(t),11) x(length(t),12) x(length(t),13) x(length(t),14) x(length(t),15) ]; %reset and initializing of the weights
% dphixo=[2*x(length(t),1) 0 0; x(length(t),2) x(length(t),1)  0; x(length(t),3) 0  x(length(t),1);0 2*x(length(t),2) 0;0 x(length(t),3) x(length(t),2) ;0 0 2*x(length(t),3) ];
% 
%  uo(policy)=-0.5*inv(R)*g'*dphixo'*[x(length(t),10) x(length(t),11) x(length(t),12) x(length(t),13) x(length(t),14) x(length(t),15)  ]';
%  f=[-0.376*x(length(t),1)+x(length(t),2) ;-1.8115*x(length(t),1)+2*x(length(t),3);0.725*x(length(t),1)]; 
% %  V(policy)=[x(length(t),3) x(length(t),4) x(length(t),5)]*dphixo*(f+g*uo(policy));
% phixo=[x(length(t),1)^2 x(length(t),1)*x(length(t),2) x(length(t),1)*x(length(t),3)  x(length(t),2)^2 x(length(t),2)*x(length(t),3) x(length(t),3)^2 ]';     
% V(policy)=[x(length(t),4) x(length(t),5) x(length(t),6) x(length(t),7) x(length(t),8) x(length(t),9)  ]*phixo;
% 
% z(policy,:)=x(length(t),:);
% Y(policy)=[x(length(t),4) x(length(t),5) x(length(t),6) x(length(t),7) x(length(t),8) x(length(t),9)]*dphixo*(f+g*uo(policy))+([x(length(t),1) x(length(t),2) x(length(t),3) ]*Q*[x(length(t),1) x(length(t),2) x(length(t),3) ]'+uo(policy)*R*uo(policy)')  ;
% 
% 
% 
% p=(-0.5*inv(R)*g'*dphixo')';
% 
% e2(policy)= p'*([x(length(t),10) x(length(t),11) x(length(t),12) x(length(t),13) x(length(t),14) x(length(t),15) ] -[x(length(t),4) x(length(t),5) x(length(t),6) x(length(t),7) x(length(t),8) x(length(t),9) ])';
% 
% end
% 

% figure (1);
% plot(t,x(:,1:3));
% figure (2);
% plot(t,x(:,4:9));
%%%%%%%%%%%%%%%%%5
figure (1);
plot(t,x(:,1:2));
title ('System States');
xlabel ('Time (s)');
figure (2);
plot(t,x(:,3:5));
title ('Parameters of the critic NN');
xlabel ('Time (s)');
legend ('W_{c1}','W_{c2}', 'W_{c3}','W_{c4}','W_{c5}', 'W_{c6}');
 figure (3);
plot(t,x(:,6:8)); 
title ('Parameters of the actor NN');
xlabel ('Time (s)');
legend ('W_{a1}','W_{a2}', 'W_{a3}','W_{a4}','W_{a5}', 'W_{a6}');
%%%%%%%%%%%%%%%%%%



% B=[0 0 1]';
% A=[-1.01887 0.90506 -0.00215; 0.82225 -1.07741 -0.17555; 0 0 -1]
% 
% % 
% % A=[-0.376 1 0;-1.8115 0 2;0.725 0 0];
% % B=[1;3.5;0];
% Q=eye(3);
% R=1;
% 
% PTheor=care(A,B,Q,R);
% 
% 
% Papprox=[x(length(x),4)    x(length(x),5)/2  x(length(x),6)/2
%      x(length(x),5)/2  x(length(x),7) x(length(x),8)/2  
%      x(length(x),6)/2 x(length(x),8)/2 x(length(x),9) 
%      ]
% hold on;
% plot(t,PTheor(1,1),'*');
% hold on
% plot(t,PTheor(1,2),'*');
% hold on
% plot(t,PTheor(1,3),'*');
% hold on
% plot(t,PTheor(2,2),'*');
% hold on
% plot(t,PTheor(2,3),'*');
% hold on
% plot(t,PTheor(3,3),'*');

%  
%  figure (3);
% plot((z(:,4)-z(:,10)),'g');
% hold on;
% plot((z(:,5)-z(:,11)),'r');
% hold on;
% plot((z(:,6)-z(:,12)),'b');
% hold on;
% plot((z(:,7)-z(:,13)),'g-*');
% hold on;
% plot((z(:,8)-z(:,14)),'r-*');
% hold on;
% plot((z(:,9)-z(:,15)),'b-*');
% 
% title ('W-H')
% 
% figure(4);
% plot(uo);
% title ('Control Input')
% 
% 
% figure(5);
% plot(V);
% title ('Cost')
% 
% 
% figure(6);
% plot(Y-V);
% title ('Error1')
% 
% figure(7);
% plot(e2);
% title ('Error2')
% 
