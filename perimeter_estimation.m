% ------------------------------------------------------------
% Perimeter Estimation - DSS length estimator
% ------------------------------------------------------------
% A greedy decomposition of the input digital contour into Digital Straight
% Segment (DSS). It starts from a point, then find the longest DSS starting
% from this point. The end point of this DSS defines a new starting point.
% The process is repeated till the whole contour has been visited. The DSS
% end points form a polygonal line. The length of contour is defined as
% Euclidean distance of this polygonal line.

ctr = 1;
dx = Lx/n_grid_x;
cell_diag = dx*sqrt(2);
while(true)
    % stop when starting point is revisited
    if (ctr == numel(PATH_INDICES))
        break;
    end
    P_start = [X_GRID(PATH_INDICES(ctr)) Y_GRID(PATH_INDICES(ctr))];
    ctr2 = ctr + 1;
    while(true)
        P_end = [X_GRID(PATH_INDICES(ctr2)) Y_GRID(PATH_INDICES(ctr2))];
        dP = P_end - P_start;
        terminate_flag = false;
        for i = ctr+1:ctr2-1
            P = [X_GRID(PATH_INDICES(i)) Y_GRID(PATH_INDICES(i))];
            d = norm((P-P_start)-dot(dP,P-P_start)*dP/norm(dP));
            if (d<cell_diag)
                terminate_flag = true;
                break;
            end
        end
        if(terminate_flag) 
            ctr2 = ctr2 - 1;
            P_end = [X_GRID(PATH_INDICES(ctr2)) Y_GRID(PATH_INDICES(ctr2))];
            perimeter_length = perimeter_length + norm(P_start - P_end);
            ctr = ctr2;
            break;
        else
            ctr2 = ctr2 + 1;
            % terminated if no next point
            if (ctr2 > numel(PATH_INDICES))
                ctr2 = ctr2 - 1;
                P_end = [X_GRID(PATH_INDICES(ctr2)) Y_GRID(PATH_INDICES(ctr2))];
                perimeter_length = perimeter_length + norm(P_start - P_end);
                ctr = ctr2;
                break;
            end
        end
    end
end