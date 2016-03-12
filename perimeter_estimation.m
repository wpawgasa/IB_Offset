% ------------------------------------------------------------
% Perimeter Estimation - DSS length estimator
% ------------------------------------------------------------
% A greedy decomposition of the input digital contour into Digital Straight
% Segment (DSS). It starts from a point, then find the longest DSS starting
% from this point. The end point of this DSS defines a new starting point.
% The process is repeated till the whole contour has been visited. The DSS
% end points form a polygonal line. The length