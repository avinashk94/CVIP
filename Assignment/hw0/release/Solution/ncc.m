function [score] = ncc( u, v )
 u = double(u);
 v = double(v);
 u_norm = sqrt(sum(u(:).*u(:)));
 v_norm = sqrt(sum(v(:).*v(:)));
 score = sum(u(:).*v(:))/u_norm/v_norm;
end