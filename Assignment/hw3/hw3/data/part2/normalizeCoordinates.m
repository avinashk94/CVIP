function [ transform, normCoord ] = normalizeCoordinates( hCoord)

    center = mean(hCoord(:,1:2)); 
    
    offset = eye(3);
    offset(1,3) = -center(1);
    offset(2,3) = -center(2);

    sX= max(abs(hCoord(:,1)));
    sY= max(abs(hCoord(:,2)));
    
    scale = eye(3);
    scale(1,1)=1/sX;
    scale(2,2)=1/sY;          
                
    transform = scale * offset;
    normCoord = (transform * hCoord')';
end