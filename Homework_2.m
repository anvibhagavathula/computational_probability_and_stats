%Question 1 

%Part (a)
%the sum of the values of any pmf function must sum to one 
x = 1:50; 
pmf_x = sqrt(x); 
pmf_sum = 0; 

%cumulative sum of pmf 
for i = 1:50
    pmf_sum = pmf_sum + pmf_x(i); 
end 

c = 1 / pmf_sum; 

%Part (b) 
m = 50; %p_hat vector dimension
n = 10^6; %we can modify this variable to generate a different sample size 
p = c*sqrt(x); 
CDF = cumsum(p); %calculating the CDF of p from previous part
phat = zeros(1, 50); 
X = zeros(1, n); 
 
for i = 1:n
    U = rand(); %generating an iid random variable for n samples
    for j = 1:m 
        if U <= CDF(j)
            X(j) = i; 
            phat(j) = phat(j) + 1; 
            break 
        end 
    end 
end
 
phat = phat/n;
plot(1:50, p, "*", 1:50, phat, "o") %plotting p_hat against p

%--------------------------------------------------------------------------

%Question 2

%Part b
n = 10^6; %sample size can be modified as needed (e.g. 10^6) 
U = rand(1, n); 
X = U.^2; %inverse CDF method 
h = histogram(X, "Normalization", "probability");
hold on
fplot(@(x) 1/(2*sqrt(x))*h.BinWidth, [0, max(X)])

%--------------------------------------------------------------------------

%Question 3 

%Part a 
A = 0; %accepted samples 
total = 0; %total number of iterations
sample = zeros(1, 10^6); 

while A < 10^6
    X = unifrnd(-1, 1); %generating samples of X
    Y = unifrnd(0, 6); %generating samples of Y 
    total = total + 1;  
    if ((sin(10*X))^2*abs(X^3 + 2*X - 3)*((X<0)+(X>0.5)) >= Y)  
        A = A+1;
        sample(A) = X; 
    end 
end 

acceptance_ratio = A / total; %calculating acceptance ratio
M = 6 * 2; %area under the chosen rectangle is equal to 12 
C = M * acceptance_ratio; 

%Part b
h1 = histogram(sample, "Normalization", "probability");
hold on
fplot(@(x) (1/C)*(sin(10*x))^2*abs(x^3 + 2*x - 3)*((x<0)+(x>0.5))*h1.BinWidth, [-1, 1])

%--------------------------------------------------------------------------

%Question 4

%Part a 
A = 0; %accepted samples 
total = 0; %total number of iterations
sample = zeros(1, 10^6); 

while A < 10^6
    U = rand();
    X = U^2; %generating samples of X  
    Y = unifrnd(0, 1/(2*sqrt(X))); %generating samples of Y 
    total = total + 1;  
    if ((1/(2*sqrt(X)))*sqrt(abs(sin(10/(1+abs(log(X)))))) >= Y)
        A = A+1;
        sample(A) = X; 
    end 
end 

acceptance_ratio = A / total; %calculating acceptance ratio
M = 1; %area under the pmf is equal to 1  
C = M * acceptance_ratio; 

%Part b
h1 = histogram(sample, "Normalization", "probability");
hold on
fplot(@(x) (1/C)*(1/(2*sqrt(x)))*sqrt(abs(sin(10/(1+abs(log(x))))))*h1.BinWidth, [0, 1])

