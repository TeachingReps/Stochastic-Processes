function[H_time]=randalloc(X,m,P_11,P_01)
    flag=0;
    H_time=0;
    t=1;
    while (flag~=1)
        for i=1:m
            current=X(i);
            if(current==1)
                p=P_11(i);
                X(i)=binornd(1,p);
            else
                p=P_01(i);
                X(i)=binornd(1,p);
            end
        end
        i_t=randi(m);
        if(X(i_t)==1)
            flag=1;
            H_time=t;
            break;
        end
        
        t=t+1;
    end
end
