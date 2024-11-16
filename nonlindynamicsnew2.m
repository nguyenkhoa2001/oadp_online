function xout=nonlindynamicsnew2(t,x)
global R;
global g;
global dphix;
global H;
global W;

a=8;
b=1;
R=1;
Q=[1 0 ; 0 1];


x1=x(1);
x2=x(2);
W=[x(3) x(4) x(5)   ]';
H=[x(6) x(7) x(8)  ]';
 phix=[x1^2 x1*x2  x2^2];
  dphix=[2*x1 0; x2 x1; 0 2*x2];
    % Khi thay bằng hệ khác thì nhớ thay đổi 2 cái pt f(x) và g(x) này
    f=[-x1+(x2) ;-0.5*x1-0.5*(x2)*(1-(cos(2*x1)+2)^2)];
    g=[0; (cos(2*x1)+2)];
     u=-0.5*inv(R)*g'*dphix'*H;
    s=dphix*f+dphix*g*u;
    Y=(-[x1 (x2)]*Q*[x1 (x2)]'-u*R*u');
    e=W'*s-Y;


p=(-0.5*inv(R)*g'*dphix')';

e2= p'*(H -W);

     E2= H -W;
     Win=-a*(s./(s'*s+1)^2)*e';


 F1=1*eye(length(W));

 sbar=(s/(s'*s+1));
 
  
 D1=dphix*g*inv(R)*g'*dphix';
 
 F2=6*eye(length(H));
 
Hin=b*(F2*W-F2*H)+0.25*b*D1*H*(s'./(s'*s+1)^2)*W;

if t<=80
unew=u+(sin(t)^2*cos(t)+sin(2*t)^2*cos(0.1*t)+sin(-1.2*t)^2*cos(0.5*t)+sin(t)^5);
%unew=u+(sin(t)^2*cos(t)+sin(2*t)^2*cos(0.1*t)+sin(-1.2*t)^2*cos(0.5*t)+sin(t)^5+sin(1.12*t)^2+cos(2.4*t)*sin(2.4*t)^3);

else
    unew=u;

end

     xout=[f+g*unew; Win ;Hin];

