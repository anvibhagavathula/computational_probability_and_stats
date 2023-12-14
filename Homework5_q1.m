%Question 1 

%Gambler's Ruin for probability of reaching $25 while starting at $20
p = 17/36;
q = 19/36;

b = zeros(26, 1); 
b(26) = 1; 

%Defining the probability matrix 
A = eye(26); 
for i=2:25 
    A(i,i-1) = -q;
    A(i,i+1) = -p;
end 

%Solving for probability vector 
P = A\b;
%Probability of reaching $25 when starting at $20 is given by
P(21); 



    
