% Extrack the end points
P1=[X_CAD(i) Y_CAD(i) ];
P2=[X_CAD(i+1) Y_CAD(i+1)];

%Calculate nornal vector (with right-hand-rule  convention)
N=cross([P2-P1 0],[0 0 -1]); N=N(1:2); N=N/norm(N);

%Calculate chord length (P1 to P2)
chord = norm(P1-P2);

%Check 
