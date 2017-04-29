function [G] = ginv(X)

% GINV(X). Finds a g-inverse of matrix X. Recall that the g-inverse of X
%          when X is not of full (column) rank is not unique. Thus, ginv
%          will draw a different result each time. Check that XGX = X.
%                 
%  Luis Frank, jan 2009.

[n,k] = size(X); r = rank(X);

% 1. Find any nonsingular rxr submatrix C. It is not necessary that 
%    the elements of C occupy adjacent rows and columns in A.

[x,i] = sort(rand(1,n));
[y,j] = sort(rand(1,k));

C = X(i(1:r),j(1:r));

while rank(C)<r
    [x,i] = sort(rand(1,n));
    [y,j] = sort(rand(1,k));
    C = X(i(1:r),j(1:r));
end;

% 2. Find inv(C) and [inv(C)]'

C = C\eye(r); C = C';

% 3. Replace the elements of C by the elements of [inv(C)]'
% 4. Replace all other elements in A by zeros

G = zeros(n,k);
G(i(1:r),j(1:r)) = C;

% 5. Transpose the resulting matrix

G = G';