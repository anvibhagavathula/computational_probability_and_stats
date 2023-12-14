%Question 2 

%Part (a) 
rng(1690);
n = 1000;
sweeps = [250 500 750 1000];
T = [0.1 1 2 3 10];
M = 50;
X = 2*(rand(M,M) < 0.5)-1;
img_posn = 1;

%Generating supblots for necessary temperatures at sweeps
for s = 1:4
    nstep = sweeps(s); 
    for t = 1:5
        temp = T(t); 
        for k = nstep:nstep:n
            X_ising = ising(X,temp,nstep);
            subplot(4,5,img_posn)
            imagesc(X_ising,[-1 1]), colormap(gray), title(num2str([nstep n])), drawnow, figure(gcf)
            pause(0.01)
        end
        img_posn = img_posn + 1;
    end 
end


function [X] = ising(X, T, nstep)
for m = 1:nstep 
    for i = 1:50
        for j = 1:50 
            %Take into account all of the edge cases on the matrix 
            
            %Four corners 
            if (i == 1 && j == 1)  
                sum = X(i, j+1) + X(i+1, j);
            elseif (i == 1 && j == 50)
                sum = X(i, j-1) + X(i+1, j);
            elseif (i == 50 && j == 1)
                sum = X(i-1, j) + X(i, j+1);  
            elseif (i == 50 && j == 50)
                sum = X(i-1, j) + X(i, j-1); 
            %Top row 
            elseif (i == 1 && j ~= 1) || (i == 1 && j ~= 50) 
                sum = X(i, j-1) + X(i, j+1) + X(i+1, j); 
            %Bottom Row
            elseif (i == 50 && j ~= 1) || (i == 50 && j ~= 50) 
                sum = X(i, j-1) + X(i, j+1) + X(i-1, j); 
            %First Column 
            elseif (j == 1 && i ~= 1) || (j == 1 && i ~= 50) 
                sum = X(i-1, j) + X(i+1, j) + X(i, j+1); 
            %Last Column 
            elseif (j == 50 && i ~= 1) || (j == 50 && i ~= 50) 
                sum = X(i-1, j) + X(i+1, j) + X(i, j-1); 
            %All other cases 
            else 
                sum = X(i-1, j) + X(i+1, j) + X(i, j-1) + X(i, j+1); 
            end
            
            p_1 = probability(sum, T); %Conditional probability 
            
            U = rand(); 
            if U <= p_1
               X(i, j) = 1;
            else 
                X(i, j) = -1;
            end
        end 
    end   
end
end

function p_1 = probability(sum, T) %Conditional probability 
p_1 = exp((2/T)*sum)/(exp((2/T)*sum) + 1); 
end 

