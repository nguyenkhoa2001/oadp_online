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
a=50;
b=1;
R=1;
Q=[1 0 ; 0 1];
% t=0;
x1=x(1);
x2=x(2);
W=[x(3) x(4) x(5)]';
H=[x(6) x(7) x(8)]';
% u=[x(9)];


phix=[x1^2 x1*x2 x2^2]';
    dphix=[2*x1 0; x2 x1; 0 2*x2];
    f=[-x1+x2;-0.5*x1-0.5*x2*(1-(cos(2*x1)+2)^2)];
    g=[0; cos(2*x1+2)];
     u=-0.5*inv(R)*g'*dphix'*H;
    s=dphix*f+dphix*g*u;
    Y=(-[x1 x2]*Q*[x1 x2]'-u*R*u');
    e=W'*s-Y;

%     W(:,k+1)=W(:,k)-e(k)*a*(s(:,k)/(s(:,k)'*s(:,k)+1));
% W(:,k+1)=W(:,k)-a*s(:,k)*(e(k));
%


p=(-0.5*inv(R)*g'*dphix')';

e2= p'*(H -W);

     E2= H -W;
     Win=-a*(s./(s'*s+1)^2)*e';
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
 
Hin=b*(F2*W-F2*H)+0.25*b*D1*H*(s'./(s'*s+1)^2)*W;

if t<=1000
unew=((u)+exp(-0.001*t)*37*(sin(t)^2*cos(t)+sin(2*t)^2*cos(0.1*t)+sin(-1.2*t)^2*cos(0.5*t)+sin(t)^5+sin(1.12*t)^2+cos(2.4*t)*sin(2.4*t)^3));
% unew=((u)+2*(sin(t)^2*cos(t)+sin(2*t)^2*cos(0.1*t)+sin(-1.2*t)^2*cos(0.5*
% t)+sin(t)^5));
else
    unew=u;

end

     xout=[f+g*unew; Win ;Hin];