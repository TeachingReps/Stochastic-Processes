clc;
close all;clear all;

%%
N=1000;
n_arrivals = 20000;
num_trials = 1;
it = cell(1,num_trials);
for trial = 1:num_trials
    disp(trial)
    lambda = 2500;
    mu = 5;
    Q = zeros(1,N);
    work_time = zeros(1,N);
    a = zeros(1,n_arrivals);
    s = zeros(1,n_arrivals);
    s_t{N} = [];
    server_id = zeros(1,n_arrivals);
    idle_time=0;
    for i=1:n_arrivals
        
        disp(i)
        server_id(i) = randi(N); % changed from randi(N) to 1.
        a(i) =  exprnd(1/lambda,1);
        
        %%
%         if(work_time(server_id(i))~=0 && min(work_time)==0)
%             idle_time = idle_time + min(a(i),work_time(server_id(i)));
%             %         idle_time = idle_time + a(i);
%             it(i)=min(a(i),work_time(server_id(i)));
%         end
        
        %%
        f = setdiff(work_time,work_time(server_id(i)));
        minf = min(f);
        g = work_time(server_id(i))-minf;
        gmax = max(0, g);
        idle_time = [idle_time gmax];
        
        %%
        s(i) = exprnd(1/mu,1);
        
        work_time(server_id(i))=work_time(server_id(i))+s(i);
        s_t{server_id(i)} = [s_t{server_id(i)} work_time(server_id(i))];
        
        
        
        Q(server_id(i)) =  Q(server_id(i)) +1;
        
        
        %     if (work_time(server_id(i)) == 0)
        %         disp('reached 1')
        %         Q(server_id(i)) =  Q(server_id(i)) +1;
        %     else
        %         disp('reached 2')
        %         work_time(server_id(i)) =  work_time(server_id(i)) + s(i);
        %         Q(server_id(i)) =  Q(server_id(i)) +1;
        %     end
        %     disp(work_time(server_id(i)))
        
        for k = 1:N
            work_time(k) =  max(work_time(k) - a(i),0);
            %         if (work_time(k) == 0)
            %             Q(k) = 0;
            %         end
            
            s_t{k}=max((s_t{k} - a(i)),0);
            Q(k) = length(find(s_t{k}));
            
        end
    end
    it{trial} = cumsum(idle_time);
end

%%
m = size(it{1},2);
for j=1:num_trials-1
    m = min(m,(size(it{j+1},2)));
end
for j=1:num_trials
    it1(j,:) = it{j}(1:m(1));
end

m1 = mean(it1);
std1 = std(it1);
errorbar(1:m,m1,std1)