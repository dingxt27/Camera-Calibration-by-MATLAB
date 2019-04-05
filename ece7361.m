filename = 'Features2D.txt';
delimiterIn = ' ';
Points2D = importdata(filename,delimiterIn);

filename = 'Features3D.txt';
delimiterIn = ' ';
Points3D = importdata(filename,delimiterIn);

P_true = camcalib(Points2D,Points3D) % compute the P matrix with 2 input data sets, 3D & 2D

%svd get P_true
% [U,S,V] = svd(B);
% P = V(:,12);
% A1 = transpose (P(1:4,:));
% A2 = transpose (P(5:8,:));
% A3 = transpose (P(9:12,:));
% 
% P_true = [A1;A2;A3]

H = P_true (:,1:3); %K*R
h = P_true (:,4); %-K*R*C
%camera center
Cam_C = -inv(H)*h

[Q,R] = qr(flipud(H)');
R = flipud(R');
R = fliplr(R); %K before normalization
K = R(:,:)/R(3,3) %normalize k, to better observe intrinsic parameter

Q = Q';
Q = flipud(Q);
R = Q

t = -R*Cam_C
% check the correctness of P_true
x = CameraProject(Points3D,P_true);

%transform (0,0,0) (1,1,1) (5,5,5) (2,2,2) (3,3,3) (4,4,4)
x0 = CameraProject([0,0,0,1],P_true)
x1 = CameraProject([1,1,1,1],P_true)
x2 = CameraProject([5,5,5,1],P_true)
x3 = CameraProject([2,1,0.5,1],P_true)
x4 = CameraProject([1,3,3,1],P_true)
x5 = CameraProject([100,100,100,1],P_true)

error_in_x = mean(abs(x(:,1)-Points2D(:,1)))
error_in_y = mean(abs(x(:,2)-Points2D(:,2)))

% error_in_x = abs(mean(sum(x(:,1))) - mean(sum(Points2D(:,1))))
% %correctness1 = 1-(error_in_x/mean(Points2D(:,1)))
% error_in_y = abs(mean(sum(x(:,2))) - mean(sum(Points2D(:,2))))
% %correctness2 = 1-(error_in_y/mean(Points2D(:,2)))
