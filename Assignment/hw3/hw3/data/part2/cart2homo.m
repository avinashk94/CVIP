function homoCoord = cart2homo(cCoord)

    [numCoordinates, dimension] = size(cCoord);
    homoCoord = ones(numCoordinates, dimension+1);
    homoCoord(:,1 : dimension) = cCoord(:,1:dimension);
end