%function of compute the P matrix with 2D and 3D data sets
function P_t = camcalib(x,X)
 s = size (x,1);
 n = 1;
 for i = 1:s
     A(n:n+1,:) = [0,0,0,0,-X(i,1),-X(i,2),-X(i,3),-X(i,4),x(i,2)*X(i,1),x(i,2)*X(i,2),x(i,2)*X(i,3),x(i,2)*X(i,4); 
         X(i,1),X(i,2),X(i,3),X(i,4),0,0,0,0,-x(i,1)*X(i,1),-x(i,1)*X(i,2),-x(i,1)*X(i,3),-x(i,1)*X(i,4)];
     n = n+2;
 end
 
 [U2,S2,V] = svd(A);
 P = V(:,12);
A1 = transpose (P(1:4,:));
A2 = transpose (P(5:8,:));
A3 = transpose (P(9:12,:));

P_t = [A1;A2;A3];

 
 return 
 