%Question 1 

m = 173; %large prime integer 
a = 7; %multiplicative constant

%First, let us check whether m is prime 
if isprime(m) == 1
    disp('m is prime')
end

%Next, let us generate full sequence {R_0, R_1, ... , R_(m-1)}
R = length((m)); %array of random numbers to generate from MCG

for j = 1:m
    R(j+1) = mod(R(j)*a, m); 
end

%Indexing the array appropriately such that the sequence is {R_1, ... , R_(m-1)}
R = R(2:m);  

%Finally, let us find N_k for each k = (1, 2, ..., m-1)
N_k = [];

for k = 1:(m-1)
    count = 0;
    for i = 1:length(R) %we start from second element as R_1 = 7 = R(2) 
        if R(i) == k
            count = count + 1;
        end 
    end 
    N_k = [N_k, count];
end

%-----------------------------------------------------------------------%
%Question 2

%Random number generator methods 

%Method from Question 1 
n = 10000;
U_A = length(n);
U_A(1) = 1;
L = 0:172;
N = 0:9999; 

for j = 1:172
    U_A(j+1) = mod(U_A(j)*a, m); 
end

method1 = RandStream("mcg16807");
method2 = RandStream("swb2712");
method3 = RandStream("mt19937ar");

%Four different PRNGs
U_A = U_A/m; 
U_B = rand(method1, 1, 10000);
U_C = rand(method2, 1, 10000); 
U_D = rand(method3, 1, 10000);

%Generating sequences to plot 
U1_A = cumsum(U_A)./L; 
U1_B = cumsum(U_B)./N;
U1_C = cumsum(U_C)./N;
U1_D = cumsum(U_D)./N;

U5_A = cumsum(U_A.^5)./L;
U5_B = cumsum(U_B.^5)./N;
U5_C = cumsum(U_C.^5)./N;
U5_D = cumsum(U_D.^5)./N;

%PRNG A
subplot(4, 2, 1); 
plot(L, U1_A);
axis([0 m 0 1]);
title('PRNG A: From Question 1');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_A');

subplot(4, 2, 2); 
plot(U5_A); 
axis([0 m 0 1]);
title('PRNG A: From Question 1');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_A^5');

%PRNG B
subplot(4, 2, 3); 
plot(U1_B); 
axis([0 n 0 1]);
title('PRNG B: MATLAB Method 1');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_B');

subplot(4, 2, 4); 
plot(U5_B); 
axis([0 n 0 1]);
title('PRNG B: MATLAB Method 1');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_B^5');

%PRNG C
subplot(4, 2, 5); 
plot(U1_C); 
axis([0 n 0 1]);
title('PRNG C: MATLAB Method 2');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_C');

subplot(4, 2, 6); 
plot(U5_C); 
axis([0 n 0 1]);
title('PRNG C: MATLAB Method 2');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_C^5');

%PRNG D
subplot(4, 2, 7); 
plot(U1_D); 
axis([0 n 0 1]);
title('PRNG D: MATLAB Method 3');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_D');

subplot(4, 2, 8); 
plot(U5_D); 
axis([0 n 0 1]);
title('PRNG D: MATLAB Method 3');
xlabel('n'); ylabel('^{1}/_{n} \Sigma U_D^5');

%-----------------------------------------------------------------------%
%Question 3 

%Part B 

Ud_A = length(300000);

for j=1:299999
    Ud_A(1,j+1) = mod(Ud_A(1,j)*a, m); 
end

Ud_A = Ud_A ./ m;
Ud_A = reshape(Ud_A, 30, 10000);
Ud_B = reshape(rand(method1,30,10000), [30, 10000]);
Ud_C = reshape(rand(method2,30,10000), [30, 10000]);
Ud_D = reshape(rand(method3,30,10000), [30, 10000]);

countA = 0;
countB = 0;
countC = 0;
countD = 0;

for j=1:10000
    if ((Ud_A(1, j) < 1/4) && (Ud_A(16, j) < 1/2) && (Ud_A(16, j) > 1/4) && (Ud_A(28, j) > 1/2))
        countA = countA + 1;
    end
    if ((Ud_B(1, j) < 1/4) && (Ud_B(16, j) < 1/2) && (Ud_B(16, j) > 1/4) && (Ud_B(28, j) > 1/2))
        countB = countB + 1;
    end
    if ((Ud_C(1, j) < 1/4) && (Ud_C(16, j) < 1/2) && (Ud_C(16, j) > 1/4) && (Ud_C(28, j) > 1/2))
        countC = countC + 1;
    end
    if ((Ud_D(1, j) < 1/4) && (Ud_D(16, j) < 1/2) && (Ud_D(16, j) > 1/4) && (Ud_D(28, j) > 1/2))
        countD = countD + 1;
    end
end 

frac_PRNGA = countA / 10000; 
frac_PRNGB = countB / 10000; 
frac_PRNGC = countC / 10000; 
frac_PRNGD = countD / 10000; 


