%Question 2

%Part a
%Exit point is at 10th row  
b = zeros(20, 1); 
b(10) = 1; 

%Defining symmetric random walk via probabilities on A 
p_i = 1/4; 
A = eye(20); 
A(4, [1, 3, 5, 8]) = [-p_i, -p_i, -p_i, -p_i];
A(5, [2, 4, 6, 9]) = [-p_i, -p_i, -p_i, -p_i];
A(8, [4, 7, 9, 11]) = [-p_i, -p_i, -p_i, -p_i];
A(9, [5, 8, 10, 12]) = [-p_i, -p_i, -p_i, -p_i];
A(12, [9, 11, 13, 15]) = [-p_i, -p_i, -p_i, -p_i];
A(15, [12, 14, 16, 18]) = [-p_i, -p_i, -p_i, -p_i];
A(18, [15, 17, 19, 20]) = [-p_i, -p_i, -p_i, -p_i];

%Solving for exit probability vector X
X = A\b;

%--------------------------------------------------------------------------

%Part b 
n = 10^5;
R = zeros(1, n); 

for i=1:n
    %Initialise (x,y) = (0,0) 
    x = 0; 
    y = 0; 
    %Define boundary for while-loop excluding exit point (1,0) 
    while ~((x == -2 && y == 0) || (x == -2 && y == 1) || (x == -1 && y == 2) || (x == 0 && y == 2) || (x == 1 && y == 1) || (x == 1 && y == 0) || (x == 1 && y == -1) || (x == 1 && y == -2) || (x == 1 && y == -3) || (x == 0 && y == -4) || (x == -1 && y == -3) || (x == -1 && y == -2) || (x == -1 && y == -1))
        p = rand(); %Generating symmetric probabilities for random walk 
        if (p <= 1/4)
            x = x-1;
        end 
        if (p > 1/4) && (p <= 1/2)
            x = x+1; 
        end 
        if (p > 1/2) && (p <= 3/4)
            y = y-1;
        end 
        if (p > 3/4)
            y = y+1; 
        end
    end
    %If the random walk ends up at (1,0), we indicate via our vector N
    if (x == 1 && y == 0) 
        R(i) = 1; 
    end  
end 

%Fraction of time that the walk exits at (1,0) is the mean of R 
mean = sum(R, 2)/n; 

%Standard deviation 
stan_dev = std(R);

%95% Confidence Interval
CI =  mean + 2*stan_dev/sqrt(n)*[-1, 1];
