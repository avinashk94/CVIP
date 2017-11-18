function plot_triangulation( triangPoints, camCenter1, camCenter2 )

    figure; axis equal;  hold on; 
    plot3(-triangPoints(:,1), triangPoints(:,2), triangPoints(:,3), '.r');
    plot3(-camCenter1(1), camCenter1(2), camCenter1(3),'*g');
    plot3(-camCenter2(1), camCenter2(2), camCenter2(3),'*b');
    grid on; xlabel('x'); ylabel('y'); zlabel('z'); axis equal;
    
end