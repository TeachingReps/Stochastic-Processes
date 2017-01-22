function[H_time]=sampbasalloc(Y,m,P_11,P_01)
    flag=0;
    H_time=0;
    
    global C_hat_00 C_hat_01 C_hat_10 C_hat_11 P_hat_01 P_hat_11
    
%     C_hat_00=zeros(m,1);
%     C_hat_01=zeros(m,1);
%     C_hat_10=zeros(m,1);
%     C_hat_11=zeros(m,1);

%     persistent C_hat_00 C_hat_01 C_hat_10 C_hat_11
%     
%     if isempty(C_hat_00)
%       C_hat_00=rand(m,1);
%     end
%     
%     if isempty(C_hat_01)
%       C_hat_01=rand(m,1);
%     end
%     
%     if isempty(C_hat_10)
%       C_hat_10=rand(m,1);
%     end
%     
%     if isempty(C_hat_11)
%       C_hat_11=rand(m,1);
%     end
    
%     C_hat_00=rand(m,1);
%     C_hat_01=rand(m,1);
%     C_hat_10=rand(m,1);
%     C_hat_11=rand(m,1);
    
%     P_hat_01=zeros(m,1);
%     P_hat_11=zeros(m,1);
     
%     P_hat_01=rand(m,1);
%     P_hat_11=rand(m,1);

    
%     past=zeros(m,1);
    past=Y;
    t=1;
    while(flag~=1)
        I0=find(Y==0);
        for i=I0
            p=P_01(i);
            Y(i)=binornd(1,p);
        end
        [m0,i0]=max(P_hat_01(I0));
        I1=find(Y==1);
        for i=I1
            p=P_11(i);
            Y(i)=binornd(1,p);
        end
        [m1,i1]=max(P_hat_11(I1));
        if(m0>=m1)
            i_t=i0;
        else
            i_t=i1;
        end
        if(Y(i_t)==1)
            flag=1;
            H_time=t;
            break;
        end
        for i=1:m
            current=Y(i);
            if(current==1)
                if(past(i)==0)
                    C_hat_01(i)=C_hat_01(i)+1;
                else
                    C_hat_11(i)=C_hat_11(i)+1;
                end
            else
                if(past(i)==0)
                    C_hat_00(i)=C_hat_00(i)+1;
                else
                    C_hat_10(i)=C_hat_10(i)+1;
                end
            end
            P_hat_11(i)=C_hat_11(i)/(C_hat_11(i)+C_hat_10(i));
            P_hat_01(i)=C_hat_01(i)/(C_hat_01(i)+C_hat_00(i));
            past(i)=current;
        end
        t=t+1;
    end
end
