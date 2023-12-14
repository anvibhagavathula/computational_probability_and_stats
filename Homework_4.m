%Question 1

%Part (a) 
%calculating CI for h(x) 
n = 10^5; 
X_a = rand(n, 100); 
h_a = zeros(1, n);
x_sum_a = sum(X_a, 2);
x_squared_sum_a = sum(X_a.^2, 2);


for i = 1:n
    h_a(i) = abs(sin(2*pi*X_a(i,1)*x_sum_a(i))) * cos(2*pi*X_a(i,2)*x_squared_sum_a(i))^2;  
end

v_a = mean(h_a);
s_a = sqrt(mean((h_a-v_a).^2));
CI_a = v_a + 2*s_a/sqrt(n)*[-1,1];

%Part (b) 
%calculating CI for h(x) with different bounds samples of uniform dist 
n = 10^5; 
X_b = (1.05).*rand(n, 100); 
h_b = zeros(1, n);
x_sum_b = sum(X_b, 2);
x_squared_sum_b = sum(X_b.^2, 2);


for i = 1:n
    h_b(i) = (abs(sin(2*pi*X_b(i,1)*x_sum_b(i))) * cos(2*pi*X_b(i,2)*x_squared_sum_b(i))^2)*1.05^100;  
end

v_b = mean(h_b);
s_b = sqrt(mean((h_b-v_b).^2));
CI_b = v_b + 2*s_b/sqrt(n)*[-1,1];

%Part (c)
%calculating CI while incorporating ball with R=6 
n = 10^5; 
X_c = rand(n, 100); 
h_c = zeros(1, n);
x_sum_c = sum(X_c, 2);
x_squared_sum_c = sum(X_c.^2, 2);


for i = 1:n
    if sqrt(x_squared_sum_c(i)) <= 6
        h_c(i) = (abs(sin(2*pi*X_c(i,1)*x_sum_c(i))) * cos(2*pi*X_c(i,2)*x_squared_sum_c(i))^2);
    end
end

v_c = mean(h_c);
s_c = sqrt(mean((h_c-v_c).^2));
CI_c = v_c + 2*s_c/sqrt(n)*[-1,1];

%--------------------------------------------------------------------------

%Question 2

%Part (b) 
%for r = 6
phi_6 = normcdf((36-100/3)/(10*sqrt(4/45)));

%for r = 4
phi_4 = normcdf((16-100/3)/(10*sqrt(4/45)));

%Part (c)
m = 10^6;
X = rand(m, 100);
v = sum(sum(X.^2,2)<=36)/10^6;
s = 100*(4/45);
CI = v + 2*s/sqrt(10^6)*[-1, 1];





