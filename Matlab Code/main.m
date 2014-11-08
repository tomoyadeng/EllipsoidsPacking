% Project Ellipsoids
% Tianjin University

clear
clc
       
global ORIGINAL_EDGE_OF_TANK;
global ellipsoids_volume;
global my_count;

global fid;
fid = fopen('result.txt','w');

% compress count
my_count = 1;

% Initializing data
initial_global();

%generate ellipsoids that non-intersect
generate_separate_ellipsoids();

% Caculate the total ellipsoidal volume
ellipsoidsTotalVolume = sum(ellipsoids_volume);

%[all_ellipsoids_index, ellipsoids_number] = get_all_ellipsoids_index();

body_run(0);

% Draw the graph
plot_all(1);

%Compressed rate
compression_rate = ellipsoidsTotalVolume / ((2*ORIGINAL_EDGE_OF_TANK) ^ 3);
fprintf(fid, 'Compressed rate %d\n', compression_rate);



