% the following function is used inorder to solve the thin plate spline
% equation
%% input is the source points and the target value in resulting frame and the outputs 
%the constant values in equation a1,ax,ay,w

function [a1,ax,ay,w]=est_tps(pts,target_value)

%selecting a constant value of lamda
    lamda=1e-2;
    n=size(pts,1);
    
    tlX=repmat(pts(:,1),1,n);
    tlY=repmat(pts(:,2),1,n);
    
    diff_X=tlX-transpose(tlX);
    diff_Y=tlY-transpose(tlY);
    
    %calculating the euclediuan distance
    k=(diff_X.*diff_X)+(diff_Y.*diff_Y);
    
    a%avoiding zero points so that NAN is avoided
    t=(k~=0);
    k=-1*k.*log(k);
    k(t==0)=0;
    
    %solving the tps equation
    P=[ones(n,1) pts];
    A=[[k P];[transpose(P) zeros(3,3)]];
    A=A+(lamda*eye(n+3));
    param=(A^-1)*[target_value(:,1);zeros(3,1)];
    
    %obtaining the output parameters
    w=param(1:n);
    a1=param(n+1);
    ax=param(n+2);
    ay=param(n+3);
end
