function gui_graphical_output(INPUTS,OUTPUTS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graphical Output (Plot) with GUI
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_grid_y = INPUTS.n_grid_y;\
constants;

% Parsing
X_IFS = OUTPUTS.X_IFS;
Y_IFS = OUTPUTS.Y_IFS;

X_CAS = OUTPUTS.X_CAS;
Y_CAS = OUTPUTS.Y_CAS;

X_GRID = OUTPUTS.X_GRID;
Y_GRID = OUTPUTS.Y_GRID;

FLAGS = OUTPUTS.FLAGS;
PATH_INDICES = OUTPUTS.PATH_INDICES;
OFFSETS = OUTPUTS.OFFSETS;
AREA = OUTPUTS.AREA;
PERI = OUTPUTS.PERI;

n_offset = numel(OFFSETS);

% IFS and CAS
figure; hold on;
plot(X_IFS, Y_IFS, 'r-');
plot(X_CAS, Y_CAS, 'k-');
axis equal;

% GRID and FLAGS
figure; hold on;
plot(X_IFS, Y_IFS, 'r-');
plot(X_CAS, Y_CAS, 'k-');
plot(X_GRID(FLAGS==FLAG_OUTSIDE), Y_GRID(FLAGS==FLAG_OUTSIDE), 'ko');
plot(X_GRID(FLAGS==FLAG_FUEL), Y_GRID(FLAGS==FLAG_FUEL), 'r.');
plot(X_GRID(FLAGS==FLAG_EMPTY), Y_GRID(FLAGS==FLAG_EMPTY), 'b+');
axis equal; axis off;

% Paths
figure; hold on;
plot(X_IFS, Y_IFS, 'r-');
plot(X_CAS, Y_CAS, 'k-');
for i = 1:n_offsets
    plot(X_GRID(PATH_INDICES{i}),Y_GRID(PATH_INDICES{i}),'b-');
end
axis equal;

% AREA and PERI vs OFFSETS
figure;
subplot(1,2,1); title('gas volume'); plot(OFFSETS,AREA); xlabel('offset');
ylabel('volume');
subplot(1,2,2); title('surface area (per depth)'); plot(OFFSETS,PERI); xlabel('offset');
ylabel('surface area');
