% This program solves a convection-diffusion problem 
% in a square domain [0,1]x[0,1] using bilinear elements.

clear, close all, home

global diffusion  h 

diffusion=load('prop.dat');

typelement = input('Type of element (1:Linear Triangle, 2:Quadratic Triangle, 3:Linear Quadrilateral, 4:Quadratic Quadrilateral) : ');
ncoord = input('2:2D, 3:3D : ');

tic

if ncoord == 2
    if typelement == 1
        nnodes=3;
        X1=load('nodes_2D_tri_linear');
        X=X1(:,2:3);
        T1=load('elem_2D_tri_linear');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [1; 14; 75; 76; 77; 78; 79; 80];
        nodesDir0 = [4; 5; 6; 7; 8; 9; 10; 11; 12];
        
    elseif typelement == 2
        nnodes=6;
        X1=load('nodes_2D_tri_quad');
        X=X1(:,2:3);
        T1=load('elem_2D_tri_quad');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [1,  14,  75,  76,  77,  78,  79,  80, 453, 462, 696, 698, 701, 705, 843]';
        nodesDir0 = [4,   5,   6,   7,   8,   9,  10,  11,  12, 263, 465, 466, 468, 470, 474, 478, 711]';
    elseif typelement == 3
        nnodes=4;
        X1=load('nodes_2D_quad_linear');
        X=X1(:,2:3);
        T1=load('elm_2D_quad_linear');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [1, 14, 75, 76, 77, 78, 79, 80]';
        nodesDir0 = [4, 5, 6, 7, 8, 9, 10, 11, 12]';
    elseif typelement == 4
        nnodes=8;
        X1=load('nodes_2D_quad_quad');
        X=X1(:,2:3);
        T1=load('elm_2D_quad_quad');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [1,  14,  75,  76,  77,  78,  79,  80, 480, 501, 505, 607, 641, 647, 714]';
        nodesDir0 = [4,   5,   6,   7,   8,   9,  10,  11,  12, 283, 291, 487, 488, 489, 496, 728, 731]';
    end
elseif ncoord==3
    if typelement == 1
        nnodes=4;
        X1=load('nodes_3D_tri_lin.txt');
        X=X1(:,2:4);
        T1=load('elem_3D_tri_lin.txt');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [5,   6,  11,  12,  54,  98,  99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 207, 208, 209, 210, 211, 212]';
        nodesDir0 = [7,   8,   9,  10,  64,  65,  66,  67,  68,  69,  70,  71,  72,  73,  74,  75, 76,  77,  78,  79, 191, 192, 193, 194, 195, 196, 197]';
        
    elseif typelement == 2
        nnodes=10;
        X1=load('nodes_3D_tri_quad.txt');
        X=X1(:,2:4);
        T1=load('elem_3D_tri_quad.inp');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [5,    6,   11,   12,   54,   98,   99,  100,  101,  102,  103,  104,  105,  106,  107,  108, 109,  110,  207,  208,  209,  210,  211,  212, 1007, 1012, 1017, 1088, 1102, 1103, 1113, 1204, 1205, 1316, 1318, 1319, 1352, 1720, 1724, 1725, 1813, 1815, 1817, 1852, 1854, 1978, 2094, 2095, 2133, 2259, 2260, 2269, 2271, 2273, 2385, 2431, 2515, 2516, 2833, 2835, 2975, 3039, 3190, 3462, 3463, 3511, 3512, 3683, 3691, 3877, 4097, 4414, 4428, 4429, 4521]';
        nodesDir0 = [7,    8,    9,   10,   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,   75, 76,   77,   78,   79,  191,  192,  193,  194,  195,  196,  197, 1033, 1133, 1136, 1141, 1168, 1174, 1239, 1241, 1243, 1248, 1311, 1315, 1486, 1497, 1506, 1668, 1669, 1761, 1763, 2810, 2857, 2859, 2860, 3468, 3469, 3697, 3936, 3946, 3948, 4114, 4116, 4117, 4194, 4196, 4228, 4229, 4249, 4452, 4455, 4456, 4461, 4463, 4464, 4465, 4466, 4467, 4470, 4471, 4472, 4474, 4475, 4477, 4484, 4485, 4486, 4489, 4490, 4507]';
        
    elseif typelement == 3
        nnodes=8;
        X1=load('nodes_3D_quad_lin.txt');
        X=X1(:,2:4);
        T1=load('elem_3D_quad_lin.txt');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [1,   3,  24,  25,  26,  27,  28,  29, 260, 262, 283, 284, 285, 286, 287, 288, 519, 521, 542, 543, 544, 545, 546, 547]';
        nodesDir0 = [5,   6,   7,   8,   9,  10,  11,  12,  13, 264, 265, 266, 267, 268, 269, 270, 271, 272, 523, 524, 525, 526, 527, 528, 529, 530, 531]';
        
    elseif typelement == 4
        nnodes=20;
        X1=load('nodes_3D_quad_quad.txt');
        X=X1(:,2:4);
        T1=load('elem_3D_quad_quad.txt');
        T=T1(:,2:nnodes+1);
        nodesDir1 = [ 1,    3,   24,   25,   26,   27,   28,   29,  260,  262,  283,  284,  285,  286,  287,  288, 519,  521,  542,  543,  544,  545,  546,  547,  903,  906,  909,  911,  975,  982,  984,  986, 992,  997,  998,  999, 1000, 1001, 1449, 1456, 1457, 1459, 1464, 1466, 1772, 1773, 2070, 2073, 2075, 2119, 2121, 2123, 2129, 2130, 2131, 2132, 2414, 2418, 2422, 2424, 2606]';
        nodesDir0 = [ 7,    8,    9,   10,   11,   12,   13,  264,  265,  266,  267,  268,  269,  270, 271,  272,  523,  524,  525,  526,  527,  528,  529,  530,  531,  839,  844,  848,  849,  852, 855,  858,  860,  862,  865, 1413, 1420, 1422, 1423, 1424, 1431, 1432, 1434, 1974, 1977, 1978, 1979, 1982, 1983, 1984, 2031, 2035, 2036, 2038, 2041, 2043, 2046, 2395, 2397, 2398, 2402, 2403, 2405, 2717, 2718, 2720, 2721]';
    end
end
  
% NUMERICAL INTEGRATION
% Gauss Integration points and weights
[n,xi,wi]= Gaussintegration(ncoord,nnodes);
% Shape Functions and its derivatives
[N,dNdxi]=Shapefunction(ncoord,nnodes,xi,n);



% SYSTEM RESULTING OF DISCRETIZING THE WEAK FORM
[K,f] = CreateMatrix(X,T,xi',wi',N',dNdxi',n,ncoord);

% BOUNDARY CONDITIONS 
C = [nodesDir1, ones(length(nodesDir1),1); %inlet
     nodesDir0, zeros(length(nodesDir0),1)]; %outlet

ndir = size(C,1);
neq  = size(f,1);
A = zeros(ndir,neq);
A(:,C(:,1)) = eye(ndir);
b = C(:,2);


% SOLUTION OF THE LINEAR SYSTEM
% Entire matrix
Ktot = [K A';A zeros(ndir,ndir)];
ftot = [f;b];

sol = Ktot\ftot;
Temp = sol(1:neq);
multip = sol(neq+1:end);

toc

