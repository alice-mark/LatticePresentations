F<T1, R, I > := FreeGroup(3);

Id := F!1;

R1 := R^2 = F!1;
R2 := I^2 = F!1;
R3 := (R*I)^2 = F!1 ;
R4 := R*T1^-1*R*T1*R*T1*R*T1^-1 = F!1;
R5 := (T1*I*T1^-1*R)^4 = F!1;
R6 := (T1^-1*I*T1*R)^4 = F!1;
R7 := T1^-1*I*T1^-1*I*T1*I*T1*I*T1^-3*I*T1*I*T1*I*T1^-1*I*T1^-1 = F!1;
R8 := (T1^-1*I*T1*I*T1*I*T1^-1*I*T1^-1*I)^2 = F!1;
R9 := T1^-1*I*R*T1^-1*I*R*T1^-1*R*I*T1^-1*I*R*T1^-1*I*R*T1^-1*I*R*T1^-1*I*R = F!1;
R10 := (I*T1^-1*R)^7 = F!1;
R11 := T1^-1*I*T1*I*T1*I*T1^-2*I*T1^-1*I*T1*I*T1^2*I*T1^-1*I*T1^-1*I*T1*I = F!1;
R12 := T1^-1*I*T1*I*T1*I*R*T1*I*R*T1*I*T1*I*T1^-1*I*T1^-1*I*T1*R*T1^-1*I*R*T1^-1*I = F!1;
R13 := R*T1*I*R*T1*I*T1*I*T1^-1*I*T1^-1*I*R*T1^-1*I*R*T1^-1*I*T1^-1*I*T1*I*T1*I*T1^-1 = F!1;
R14 := R*T1*I*R*T1*R*T1^-1*I*T1*I*T1*I*R*T1*I*T1*I*T1^-1*R*T1*R*I*T1*R*T1^-1*I*T1*I*T1*I*T1*I*T1^-1 = F!1;

rels := { R1 , R2 , R3 , R4 , R5 , R6 , R7 , R8 , R9 , R10 , R11 , R12 , R13 , R14 };

G := quo<F|rels>;

