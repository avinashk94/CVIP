function residuals = calcResiduals(H, x, y)

    transformedPoints = x * H;
    
    a =  transformedPoints(:,3);
    b = y(:,3);
    cartDistX = transformedPoints(:,1) ./ a - y(:,1) ./ b;
    cartDistY = transformedPoints(:,2) ./ a - y(:,2) ./ b;
    residuals = cartDistX .* cartDistX + cartDistY .* cartDistY;
end