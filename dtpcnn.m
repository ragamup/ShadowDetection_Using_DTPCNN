function Y=dtpcnn(I)
    [r, w] = size(I);
    %Initializing parameters
    L = zeros(size(I));
    U = zeros(size(I)); Y = U; 
    theta_L = ones(size(I)); theta_H= ones(size(I)); %G_H = theta_H; G_L = theta_L;
    Y_L = U; Y_H= U;  Q_H = U; Q_L = U;
    N = 100; beta =1.95;
    F = I;
    for n = 1:N 
        %3 * 3 kernel as mentioned in the paper
        K = [1 1 1; 1 0 1; 1 1 1];
        %Linking input
        L = convn(Y, K, 'same');
        for i= 1:r
            for j=1:w
                 %Feeding input
                F(i,j) = L(i,j) + I(i,j);
                %Internal activity
                U(i, j) = F(i, j)*(1 + beta*L(i, j));
                %Algorithm implemetation of the paper
                if(U(i,j) > theta_H(i,j))
                    Y_H(i, j) = 1;
                    G_H(i, j) = theta_H(i, j);
                    Q_H(i,j) = F(i,j)/G_H(i,j);
                    theta_H(i,j) = 100;
                else
                    Y_H(i, j) = 0;
                    %temp_theta = exp(-0.2) * theta_H(i, j) + 6* Y_H(i, j);
                    theta_H(i, j) = theta_H(i, j) -0.0038;
                end

                if(U(i,j) < theta_L(i,j))
                    Y_L(i, j) = 1;
                    G_L(i, j) = theta_L(i, j);
                    Q_L(i,j) = F(i,j)/G_L(i,j);
                    theta_L(i,j) = 0;
                else
                    Y_L(i, j) = 0;
                   % temp_theta = exp(-0.2) * theta_L(i, j) + 6* Y_L(i, j);
                    theta_L(i, j) = theta_L(i, j) +0.0038 ;

                end

                 a = Q_H(i,j) + Q_L(i,j);
                 Y(i,j) = a;            
            end
        end
    end
end

