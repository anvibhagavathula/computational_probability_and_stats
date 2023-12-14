%Part (c) 
%site Visitation Schedule 
 
X_i = linspace(0.01, 1, 100);

%sum out X_1 
h1 = zeros(1, 100); %h1 = h(x4) 
max_1 = zeros(1, 100); %for computing argmax
index_1 = zeros(1, 100); %for computing argmax 
for i = 1:100 
    c1 = zeros(1, 100); %vector for keeping x4 constant
    for j = 1:100
        x4 = X_i(i); 
        x1 = X_i(j);
        c1(j) =  1/(1 + abs(x1-x4));
    end
    %for calculating normalisation constant
    h1(i) = sum(c1);
    %for argmax 
    [M, I] = max(c1);
    max_1(i) = M; 
    index_1(i) = I;
end 
 
%sum out X_4 
h4 = zeros(1, 100); %h4 = h(x5) 
max_4 = zeros(1, 100); %for computing argmax
index_4 = zeros(1, 100); %for computing argmax 
for i = 1:100 
    c4 = zeros(1, 100); %vector for keeping x5 constant
    m4 = zeros(1, 100); %max vector for keeping x5 constant 
    for j = 1:100
        x5 = X_i(i); 
        x4 = X_i(j);
        c4(j) =  ((x4)^x5)*h1(j);
        m4(j) =  ((x4)^x5)*max_1(j);
    end
    %for calculating normalisation constant
    h4(i) = sum(c4);
    %for argmax 
    [M, I] = max(m4);
    max_4(i) = M; 
    index_4(i) = I;
end 
 
%sum out X_5
h5 = zeros(100, 100); %h5 = h(x6, x7) 
max_5 = zeros(100, 100); %for computing argmax
index_5 = zeros(100, 100); %for computing argmax 
for i=1:100
    for j=1:100
        c5 = zeros(1, 100); %array for keeping x6,x7 constant
        m5 = zeros(1, 100); %max array for keeping x6, x7 constant 
        for k=1:100 
            x6 = X_i(i); 
            x7 = X_i(j);
            x5 = X_i(k); 
            c5(k) =  (1/gamma(1+x5))*((x7)^x5)*exp(-(x5-x6)^2)*h4(k);
            m5(k) =  (1/gamma(1+x5))*((x7)^x5)*exp(-(x5-x6)^2)*max_4(k);
        end 
        h5(i,j) = sum(c5); 
        [M, I] = max(m5);
        max_5(i,j) = M;
        index_5(i,j) = I;
    end 
end 
 
%sum out X_7 
h7 = zeros(100, 100); %h7 = h(x6, x8) 
max_7 = zeros(100, 100); %for computing argmax
index_7 = zeros(100, 100); %for computing argmax 
for i=1:100
    for j=1:100
        c7 = zeros(1, 100); %array for keeping x6,x8 constant
        m7 = zeros(1, 100); %max array for keeping x6,x8 constant 
        for k=1:100 
            x6 = X_i(i); 
            x8 = X_i(j);
            x7 = X_i(k); 
            c7(k) =  exp(-(x7-x8)^2)*h5(i, k);
            m7(k) =  exp(-(x7-x8)^2)*max_5(i, k);
        end 
        h7(i, j) = sum(c7); 
        [M, I] = max(m7);
        max_7(i, j) = M;
        index_7(i, j) = I;
    end 
end 
 
 
%sum out X_8 
h8 = zeros(1, 100); %h8 = h(x6) 
max_8 = zeros(1, 100); %for computing argmax
index_8 = zeros(1, 100); %for computing argmax 
for i=1:100
    c8 = zeros(1, 100); %array for keeping x6 constant
    m8 = zeros(1, 100); %max array for keeping x6 constant 
    for j=1:100
        x6 = X_i(i); 
        x8 = X_i(j);
        c8(j) =  exp(-(x6-x8)^2)*h7(i, j);
        m8(j) =  exp(-(x6-x8)^2)*max_7(i, j);
    end
    h8(i) = sum(c8);
    [M, I] = max(m8);
    max_8(i) = M; 
    index_8(i) = I;
end 
 
%sum out X_6 
h6 = zeros(100, 100); %h6 = h(x2, x3) 
max_6 = zeros(100, 100); %for computing argmax
index_6 = zeros(100, 100); %for computing argmax 
for i=1:100
    for j=1:100
        c6 = zeros(1, 100); %array for keeping x2,x3 constant
        m6 = zeros(1, 100); %max array for keeping x2,x3 constant 
        for k=1:100 
            x3 = X_i(i); 
            x2 = X_i(j);
            x6 = X_i(k); 
            c6(k) =  x6 * exp(-x2*x3*x6) * h8(k);
            m6(k) =  x6 * exp(-x2*x3*x6) * max_8(k);
        end 
        h6(i, j) = sum(c6); 
        [M, I] = max(m6);
        max_6(i, j) = M;
        index_6(i, j) = I;
    end 
end 
 
 
%sum out X_2 
h2 = zeros(1, 100); %h2 = h(x3) 
max_2 = zeros(1, 100); %for computing argmax
index_2 = zeros(1, 100); %for computing argmax 
for i=1:100
    c2 = zeros(1, 100); %array for keeping x3 constant
    m2 = zeros(1, 100); %max array for keeping x3 constant 
    for j=1:100
        x3 = X_i(i); 
        x2 = X_i(j);
        c2(j) =  x2 * h6(i,j);
        m2(j) =  x2 * max_6(i,j);
    end
    h2(i) = sum(c2);
    [M, I] = max(m2);
    max_2(i) = M; 
    index_2(i) = I;
end 
 

%sum out X_3 
h3 = sum(h2);
k = 1/h3; %normalisation constant  

%argmax 
X = zeros(1, 8); 
[M, I] = max(max_2); 
max_3 = M;
index_3 = I; 

arg3 = index_3;
X(3) = arg3 / 100; 
arg2 = index_2(arg3); 
X(2) = arg2 / 100; 
arg6 = index_6(arg3, arg2); 
X(6) = arg6 / 100; 
arg8 = index_8(arg6); 
X(8) = arg8 / 100; 
arg7 = index_7(arg6, arg8); 
X(7) = arg7 / 100; 
arg5 = index_5(arg6, arg7); 
X(5) = arg5 / 100; 
arg4 = index_4(arg5); 
X(4) = arg4 / 100; 
arg1 = index_1(arg4); 
X(1) = arg1 / 100; 

