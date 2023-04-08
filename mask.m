load('E.mat')
PF= phantom(E,256);
SL_mask = zeros(256);
for i=1:256
    for j=1:256
        if PF(i,j) ~= 0
            SL_mask(i,j) = 1;
        end
    end
end
 save(['shepp_logan_mask','.npy'],'SL_mask');