F<T1, R, I > := FreeGroup(3);

Id := F!1;

R1 := I^2 = F!1;
R2 := A^8 = F!1;
R3 := I*A^-2*I*A^2*I*A^2*I*A^-2 = F!1
R4 := (I*A^3*I*A^-3)^3 = F!1 
R5 := (A^-1*I*A^-2*I*A^-1*I*A^3*I*A^-1*I*A^-2*I)^3 = F!1
R6 := I*A^-2*I*A*I*A^3*I*A*I*A^-2*I*A^-1*I*A*I*A^2*I*A^-1*I*A*I*A^-2*I*A^-1*I*A*I*A^-2*I*A^-1*I*A*I*A^-2*I*A^-1*I*A^3*I*A*I*A^3*I*A^3*I*A^-1*I*A^3*I*A^3*I*A = F!1 


rels := { R1 , R2 , R3 , R4 , R5 , R6 };

G := quo<F|rels>;

