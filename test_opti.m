

%%
%FINNS EJ N�GON L�SNING!!
gear_clear = .5;

f = [4; 1; 1];
A = [-1 0 -1;-1 -1 0; 1 1 0; -2 0 0];
a = [-(48-gear_clear) -(33.94-gear_clear) 33.94 -(24-gear_clear)];

B = [-2 1 0;-3 0 1; 0 0 0];
b = [0;0;0];
lb = zeros(3,1);

%[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);

[x,fval,exitflag,output,lambda] = linprog(f,A,a,B,b,[],[],lb);


x,lambda.ineqlin,lambda.lower
%%%%%%%%



%%
%testa med icke-diagonalt, men �nd� x, 2x, 3x!
gear_clear = .5;

f = [4; 1; 1];
A = [-1 0 -1;-1 -1 0; 1 1 0; 1 0 0; -2 0 0];
a = [-(48-gear_clear) -(53.6-gear_clear) 53.6 17 -(24-gear_clear)];

B = [-2 1 0;-3 0 1; 0 0 0];
b = [0;0;0];
lb = zeros(3,1);

%[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);

[x,fval,exitflag,output,lambda] = linprog(f,A,a,B,b,[],[],lb);


x,lambda.ineqlin,lambda.lower

8/(2*x(1))
%%%%%%%%


%%
%Test med dh=9, hr=6

hr=6;
dh=9;

onedist = hr*2+dh;
hypodist = sqrt(2)*onedist;
twodist = onedist*2;
threedist = onedist*3;



gear_clear = .5;

f = [4; 1; 1];
A = [%-1 0 -1; %x1 + x3 >= twodist-gear_clear
    -1 -1 0; %x1 + x2 >= hypodist-gear_clear
    -1 0 0; %x1 >= hr*2 
    1 1 0; %x1 + x2 <= hypodist
    %1 0 1 %x1 + x3 <= twodist
    ];
a = [%-(twodist-gear_clear)
    -(hypodist-gear_clear)
    -hr*2
    hypodist
    %twodist
    ];

%B = [-2 1 0;-3 0 1; 0 0 0];
B = [-2 1 0;0 0 0; 0 0 0];
%B = [0 0 0;-3 0 1; 0 0 0];
b = [0;0;0];
lb = zeros(3,1);

%[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);

[x,fval,exitflag,output,lambda] = linprog(f,A,a,B,b,[],[],lb);


x,lambda.ineqlin,lambda.lower

8/(2*x(1))

%%%%


%%
hr=6;
dh=12;

onedist = hr*2+dh;
hypodist = 2*onedist;
twodist = onedist*2;
threedist = onedist*3;



gear_clear = 1;

f = [4; 1; 1];
A = [-1 0 -1; %x1 + x3 >= threedist-gear_clear
    -1 -1 0; %x1 + x2 >= twodist-gear_clear
    -1 0 0; %x1 >= hr*2 
    1 1 0; %x1 + x2 <= hypodist
    1 0 1 %x1 + x3 <= twodist
    ];
a = [-(threedist-gear_clear)
    -(twodist-gear_clear)
    -hr*2
    twodist
    threedist
    ];

B = [-3 1 0;-5 0 1; 0 0 0];
%B = [-2 1 0;0 0 0; 0 0 0];
%B = [0 0 0;-3 0 1; 0 0 0];
b = [0;0;0];
lb = zeros(3,1);

%[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);

[x,fval,exitflag,output,lambda] = linprog(f,A,a,B,b,[],[],lb);


x,lambda.ineqlin,lambda.lower

8/(2*x(1))

%%%%




%%
hr=6;
dh=14;

onedist = hr*2+dh;
hypodist = sqrt(2)*onedist;


gear_clear = .5;

f = [-1; 1];
A = [
    -1 -1; %x1 + x2 >= hypodist-gear_clear
    -1 0; %x1 >= hr*2 
    1 1; %x1 + x2 <= hypodist
    ];
a = [
    -(hypodist-gear_clear)
    -hr*2
    hypodist
    ];

%B = [-2 1 0;-3 0 1; 0 0 0];
B = [-2 1;0 0; 0 0];
%B = [0 0 0;-3 0 1; 0 0 0];
b = [0;0;0];
lb = zeros(3,1);

%[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);

[x,fval,exitflag,output,lambda] = linprog(f,A,a,B,b,[],[],lb);


x,lambda.ineqlin,lambda.lower

8/(2*x(1))

%%%%



%%
hr=6;
dh=12;

onedist = hr*2+dh;
hypodist = sqrt(2)*onedist;
hypo2dist = sqrt(5)*onedist;
%hypo2dist

gear_clear = .5;

f = [4; 2; 1; 1];
A = [-1 0 -1 0; %x1 + x3 >= threedist-gear_clear
    -1 -1 0 0; %x1 + x2 >= twodist-gear_clear
    -1 0 0 0; %x1 >= hr*2 
    1 1 0 0; %x1 + x2 <= hypodist
    1 0 1 0; %x1 + x3 <= twodist
    0 1 0 1
    ];
a = [-(threedist-gear_clear)
    -(twodist-gear_clear)
    -hr*2*.98
    twodist
    threedist
    hypodist
    ];

B = [-3 1 0 0;-5 0 1 0; 0 1 0 -2];
%B = [-2 1 0;0 0 0; 0 0 0];
%B = [0 0 0;-3 0 1; 0 0 0];
b = [0;0;0];
lb = zeros(3,1);

%[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);

[x,fval,exitflag,output,lambda] = linprog(f,A,a,B,b,[],[],lb);


x,lambda.ineqlin,lambda.lower

8/(2*x(1))

%%%%





%%
hr=6;
dhx=12;
dhy=14.4;

onexdist = hr*2+dhx;
oneydist = hr*2+dhy
hypodist = sqrt(onexdist^2+oneydist^2);
twoxdist = onexdist*2;
twoydist = oneydist*2
%hypo2dist = sqrt(5)*onedist;
%hypo2dist

gear_clear = .95;

%x1 = 8 teeth
%x2 = 12
%x3 = 16
%x4 = 24
f = [4; 2; 1; 1];
A = [-1 0 -1 0; %x1 + x3 >= hypodist-gear_clear
    -1 0 0 -1; %x1 + x4 >= twoxdist-gear_clear
    0 -1 0 -1; %x2 + x4 >= twoydist-gear_clear
    -1 0 0 0; %x1 >= hr*2 
    1 1 0 0; %x1 + x4 <= twoxdist
    1 0 1 0; %x1 + x3 <= hypodist
    0 1 0 1; %x2 + x4 <= twoydist
    ];
a = [-(hypodist-gear_clear)
    -(twoxdist-gear_clear)
    -(twoydist-gear_clear)
    -hr*2*.98
    twoxdist
    hypodist
    twoydist-.2
    ];

B = [-2 0 1 0; %
    0 0 0 0;
    0 -2 0 1
    ];
%B = [-2 1 0;0 0 0; 0 0 0];
%B = [0 0 0;-3 0 1; 0 0 0];
b = [0;0;0];
lb = zeros(3,1);

%[x,fval,exitflag,output,lambda] = linprog(f,A,b,[],[],lb);

[x,fval,exitflag,output,lambda] = linprog(f,A,a,B,b,[],[],lb);


x,lambda.ineqlin,lambda.lower

8/(2*x(1))
12/(2*x(2))
16/(2*x(3))
24/(2*x(4))

%%%%