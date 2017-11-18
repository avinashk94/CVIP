function [composite] = stitchImages(im1, im2, H)

    [h1, w1, numChannels1] = size(im1);
    [h2, w2, ~] = size(im2);
    
    corners = [ 1 1 1;
                w1 1 1;
                w1 h1 1;
                1 h1 1];
    
    warpCorners = homo_2_cart( corners * H );

    minX = min( min(warpCorners(:,1)), 1);
    maxX = max( max(warpCorners(:,1)), w2);
    minY = min( min(warpCorners(:,2)), 1);
    maxY = max( max(warpCorners(:,2)), h2);

    xRange = minX : maxX;
    yRange = minY : maxY;

    [x,y] = meshgrid(xRange,yRange) ;
    Hinv = inv(H);

    warpedHomoScaleFactor = Hinv(1,3) * x + Hinv(2,3) * y + Hinv(3,3);
    warpX = (Hinv(1,1) * x + Hinv(2,1) * y + Hinv(3,1)) ./ warpedHomoScaleFactor ;
    warpY = (Hinv(1,2) * x + Hinv(2,2) * y + Hinv(3,2)) ./ warpedHomoScaleFactor ;


    if numChannels1 == 1
        blendedLeftHalf = interp2( im2double(im1), warpX, warpY, 'cubic') ;
        blendedRightHalf = interp2( im2double(im2), x, y, 'cubic') ;
    else
        blendedLeftHalf = zeros(length(yRange), length(xRange), 3);
        blendedRightHalf = zeros(length(yRange), length(xRange), 3);
        for i = 1:3
            blendedLeftHalf(:,:,i) = interp2( im2double( im1(:,:,i)), warpX, warpY, 'cubic');
            blendedRightHalf(:,:,i) = interp2( im2double( im2(:,:,i)), x, y, 'cubic');
        end
    end
    
    blendWeight = ~isnan(blendedLeftHalf) + ~isnan(blendedRightHalf) ;
    
    blendedLeftHalf(isnan(blendedLeftHalf)) = 0 ;
    blendedRightHalf(isnan(blendedRightHalf)) = 0 ;
    
    composite = (blendedLeftHalf + blendedRightHalf) ./ blendWeight ;
end