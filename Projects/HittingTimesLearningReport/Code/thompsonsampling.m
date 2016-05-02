function[H_time]=thompsonsampling(Z,m,P_11,P_01)
    flag=0;
    H_time=0;
    
    global A0 B0 A1 B1
    
%     persistent A0 B0 A1 B1
%     
%     
%     if isempty(A0)
%       A0=ones(m,1);
%     end
%     
%     if isempty(B0)
%       B0=ones(m,1);
%     end
%     
%     if isempty(A1)
%       A1=ones(m,1);
%     end
%     
%     if isempty(B1)
%       B1=ones(m,1);
%     end
%     
%     A0=ones(m,1);
%     B0=ones(m,1);
    
    %B0=10*ones(m,1);
    %A0(1,1)=10;A0(2,1)=10;
    %B0(1,1)=1;B0(2,1)=10;
    
%     A1=ones(m,1);
%     B1=ones(m,1);
    
    %B1=10*ones(m,1);
    %A1(1,1)=10;A1(2,1)=10;
    %B1(1,1)=1;B1(2,1)=10;
    
    P_hat_01=zeros(m,1);
    P_hat_11=zeros(m,1);
    
    t=1;
    %past=zeros(m,1);
    past=Z;
    while(flag~=1)
        I0=find(Z==0);
        for i=I0
            p=P_01(i);
            Z(i)=binornd(1,p);
        end
        P_hat_01(I0)=betarnd(A0(I0),B0(I0));
        [m0,i0]=max(P_hat_01(I0));
        I1=find(Z==1);
        for i=I1
            p=P_11(i);
            Z(i)=binornd(1,p);
        end
        P_hat_11(I1)=betarnd(A1(I1),B1(I1));
        [m1,i1]=max(P_hat_11(I1));
        if(m0>=m1)
            i_t=i0;
        else
            i_t=i1;
        end
        
        if(Z(i_t)==1)
            flag=1;
            H_time=t;
            break;
        end
        for i=1:m          
            current=Z(i);
            if(current==1)
                if(past(i)==0)
                    A0(i)=A0(i)+1;
                else
                    A1(i)=A1(i)+1;
                end             
            else
                if(past(i)==0)
                    B0(i)=B0(i)+1;
                else
                    B1(i)=B1(i)+1;
                end               
            end
            past(i)=current;
        end
        t=t+1;
    end 
end
