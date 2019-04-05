function x = CameraProject(X,P)

s = size (X,1);

for k = 1:s
     aa = P*transpose(X(k,:));
     bb = [aa(1,1)/aa(3,1),aa(2,1)/aa(3,1)];
     x(k,:) = bb;
end
return
