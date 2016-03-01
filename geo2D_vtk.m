%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Getting geometry from abaqus to export it to ensight
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% LOADING FILES OF NODES AND ELEM %%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%% WRITING HEADING FOR VTK FILE
if ncoord == 2
    if typelement == 1
        nnodes=3;
        X1=load('nodes_2D_tri_linear');
        X=X1(:,2:3);
        T1=load('elem_2D_tri_linear');
        T=T1(:,2:nnodes+1);
    elseif typelement == 2
        nnodes=6;
        X1=load('nodes_2D_tri_quad');
        X=X1(:,2:3);
        T1=load('elem_2D_tri_quad');
        T=T1(:,2:nnodes+1);
    elseif typelement == 3
        nnodes=4;
        X1=load('nodes_2D_quad_linear');
        X=X1(:,2:3);
        T1=load('elm_2D_quad_linear');
        T=T1(:,2:nnodes+1);
    elseif typelement == 4
        nnodes=8;
        X1=load('nodes_2D_quad_quad');
        X=X1(:,2:3);
        T1=load('elm_2D_quad_quad');
        T=T1(:,2:nnodes+1);
    end
elseif ncoord==3
    if typelement == 1
        nnodes=4;
        X1=load('nodes_3D_tri_lin.inp');
        X=X1(:,2:4);
        T1=load('elem_3D_tri_lin.txt');
        T=T1(:,2:nnodes+1);
    elseif typelement == 2
        nnodes=10;
        X1=load('nodes_3D_tri_quad.txt');
        X=X1(:,2:4);
        T1=load('elem_3D_tri_quad.inp');
        T=T1(:,2:nnodes+1);
    elseif typelement == 3
        nnodes=8;
        X1=load('nodes_3D_quad_lin.txt');
        X=X1(:,2:4);
        T1=load('elem_3D_quad_lin.txt');
        T=T1(:,2:nnodes+1);
    elseif typelement == 4
        nnodes=20;
        X1=load('nodes_3D_quad_quad.txt');
        X=X1(:,2:4);
        T1=load('elem_3D_quad_quad.txt');
        T=T1(:,2:nnodes+1);
    end
end

nnode=length(X);

if ncoord == 2  
    for i=1:1:nnode
        X(i,3)=0;
    end
end

	% printing heading to file
f=fopen('MyParaviewFile.vtk','w');
fprintf(f,'# vtk DataFile Version 1.0\n');
fprintf(f,'ECM-CELL DIFFUSION-MECHANICS\n');
fprintf(f,'ASCII\n');
fprintf(f,'\n');
fprintf(f,'DATASET UNSTRUCTURED_GRID\n');
fprintf(f,'%s %8i %s\n','POINTS', nnode ,'float');

%%%%%%%%%%%%%%%%%%%%%% WRITING COORDINATES OF NODES %%%%%%%%%%%%%%%%%%%%%%%%%

	% printing coordinates
for i1=1:nnode
           fprintf(f,'%14.8E %14.8E %14.8E\n',X(i1,1:3));
end
fprintf(f,'\n');

%%%%%%%%%%%%%%%%%%%%%% WRITING CONNECTIVITY OF NODES %%%%%%%%%%%%%%%%%%%%%%%%%
nelem=length(T);
%fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*5);
if ncoord == 2
    if typelement == 1
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*4);
    elseif typelement == 2
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*7);
    elseif typelement == 3
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*5);
    elseif typelement == 4
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*9);
    end
elseif ncoord==3
    if typelement == 1
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*5);
    elseif typelement == 2
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*11);
    elseif typelement == 3
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*9);
    elseif typelement == 4
        fprintf(f,'%s %8i %8i\n','CELLS', nelem , nelem*21);
    end
end
for i1=1:nelem
if ncoord == 2
    if typelement == 1
        fprintf(f,'%4i  %10i  %10i %10i\n',3,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1);
    elseif typelement == 2
        fprintf(f,'%4i  %10i  %10i %10i %10i %10i %10i\n',6,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1,T(i1,4)-1,T(i1,5)-1,T(i1,6)-1);
    elseif typelement == 3
        fprintf(f,'%4i  %10i  %10i %10i %10i\n',4,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1,T(i1,4)-1);
    elseif typelement == 4
        fprintf(f,'%4i  %10i  %10i %10i %10i %10i %10i %10i %10i\n',8,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1,T(i1,4)-1,T(i1,5)-1,T(i1,6)-1,T(i1,7)-1,T(i1,8)-1);
    end
elseif ncoord==3
    if typelement == 1
        fprintf(f,'%4i  %10i  %10i %10i %10i\n',4,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1,T(i1,4)-1);
    elseif typelement == 2
        fprintf(f,'%4i  %10i  %10i %10i %10i %10i %10i %10i %10i %10i %10i\n',10,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1,T(i1,4)-1,T(i1,5)-1,T(i1,6)-1,T(i1,7)-1,T(i1,8)-1,T(i1,9)-1,T(i1,10)-1);
    elseif typelement == 3
        fprintf(f,'%4i  %10i  %10i %10i %10i %10i %10i %10i %10i\n',8,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1,T(i1,4)-1,T(i1,5)-1,T(i1,6)-1,T(i1,7)-1,T(i1,8)-1);
    elseif typelement == 4
        fprintf(f,'%4i  %10i  %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i %10i\n',20,T(i1,1)-1,T(i1,2)-1,T(i1,3)-1,T(i1,4)-1,T(i1,5)-1,T(i1,6)-1,T(i1,7)-1,T(i1,8)-1,T(i1,9)-1,T(i1,10)-1,T(i1,11)-1,T(i1,12)-1,T(i1,13)-1,T(i1,14)-1,T(i1,15)-1,T(i1,16)-1,T(i1,17)-1,T(i1,18)-1,T(i1,19)-1,T(i1,20)-1);
    end
end
                 
end

fprintf(f,'\n');
fprintf(f,'%s %8i\n','CELL_TYPES', nelem);
for i1=1:nelem
    if ncoord == 2
    if typelement == 1
        fprintf(f,' %4i ', 5);
    elseif typelement == 2
        fprintf(f,' %4i ', 22);
    elseif typelement == 3
        fprintf(f,' %4i ', 9);
    elseif typelement == 4
        fprintf(f,' %4i ', 23);
    end
elseif ncoord==3
    if typelement == 1
        fprintf(f,' %4i ', 10);
    elseif typelement == 2
        fprintf(f,' %4i ', 24);
    elseif typelement == 3
        fprintf(f,' %4i ', 12);
    elseif typelement == 4
        fprintf(f,' %4i ', 25);
    end
end
end
fprintf(f,'\n');          

%%%%%%%%%%%%%%%%%%%%%% WRITING VARIABLES %%%%%%%%%%%%%%%%%%%%%%%%%
fprintf(f,'%s %8i\n','POINT_DATA', nnode);
fprintf(f,'SCALARS Ux float\n');
fprintf(f,'LOOKUP_TABLE default\n');
for i1=1:nnode
           fprintf(f,'%14.8E\n', Temp(i1));
end
