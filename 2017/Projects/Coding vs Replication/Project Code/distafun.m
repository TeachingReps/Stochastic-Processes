%n = 4; k = 2
function result = distafun(x)

global n;
global k;


% n = 6;
% k = 3;

%result = x^n;
%result = n*(x^(n-1)) - (n-2)*(x^n);

result = 0;

for i = 1:k

temp = nchoosek(n,n-k+i)*nchoosek(n-k+i-2,i-1)*((-1)^(i-1))*x^(n-k+i);

result = result + temp;
end




end