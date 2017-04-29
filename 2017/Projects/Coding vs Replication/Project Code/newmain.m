 clc;
 clear;
 
 %Defining n,k and arrial rate paramenters
 
global n; 
global k;
global lambda;

% n_set = [2;4;6;8;10];
% k_set = [1;2;3;4;5];

%set = [2 1;4 2;6 3;8 4;10 5];

set = [6 3];
lamda_set = [0.1;0.2;0.3;0.4;0.5];

%lamda_set = [0.1;0.2;0.3;0.4;0.5;0.6;0.7;0.8;0.9;1];

for l = 1:size(set,1)
        for z = 1:size(lamda_set,1)

nk = set(l,:);
            
n = nk(1);
k = nk(2);
lambda = lamda_set(z);

%k = 2;
avg_delay = 0;

for iter = 1:10000
delay = 0;

for j = 1:n        
    queues(j) = queueDist();  % Obtaining Queuelength according to steady state distributions
end

sortqueues = sort(queues);     % Selecting 'k' queueues with minimum lengths.
kqueues = sortqueues(1:k);


% Calculating Delays.

for i = 1:k
queuelen = kqueues(i);

first = round(queuelen/2);

temp = first*exprnd(1.5/k) + (queuelen - first)*exprnd(0.5/k);

if temp > delay

    delay = temp;
    
end
end

avg_delay = avg_delay + delay;
end

avg_delay = avg_delay/iter;

fprintf('\n %d %d %f %f\n',n,k,lambda,avg_delay);

resultset(n,k,z) = avg_delay;

        end
end

