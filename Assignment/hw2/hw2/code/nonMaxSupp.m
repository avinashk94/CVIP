function scaleSpace3D = nonMaxSupp(scaleSpace)

scaleSpace_2D = zeros(size(scaleSpace));
for i=1:size(scaleSpace,3)
    domain = ones(3,3);
    scaleSpace_2D(:,:,i) = ordfilt2(scaleSpace(:,:,i), 3*3, domain);
end

scaleSpace2D_Dupli = cat(3,scaleSpace_2D(:,:,1), scaleSpace_2D, scaleSpace_2D(:,:,end));
% disp(size(scaleSpace2D_Dupli));
scaleSpace3D = scaleSpace2D_Dupli;

for i=1:size(scaleSpace,3)
    scaleSpace3D(:,:,i+1) = max(scaleSpace3D(:,:,i:i+2),[],3);
end

scaleSpace3D = scaleSpace3D(:,:,2:end-1);
% showImages(scaleSpace3D);

onesAndZeros = scaleSpace3D == scaleSpace;
scaleSpace3D = scaleSpace3D.*onesAndZeros;
% showImages(scaleSpace3D);
end

