function length = queueDist()
%global s;

global n;
global k;
global lambda;


%lambda = 0.1;
initial = 1;
% n = 6;
% k = 3;

s(1) = 1;

for i = 1:50
   
    s(i+1) = lambda*distafun(initial)/k;
    initial = s(i+1);
    
end

for i = 1:50

    p(i) = s(i) - s(i+1);
end



mat2 = cumsum(p) ;
x = rand();
length = find(mat2 > x , 1);
end
