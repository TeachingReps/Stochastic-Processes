
function length = sample()

lamda = 0.99;
n=2;
s(1) = 1;

for i =2:50

    s(i) = lamda^((n^(i-1) - 1)/(n-1));
    

end


for i = 1:49

    p(i) = s(i) - s(i+1);
end

mat2 = cumsum(p) ;
x = rand();
length = find(mat2 > x , 1);
end
