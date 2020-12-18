%init_gr.m initialization of all required variables

%!!!! don't delete any variables / You can change only the required values

%% count of graph nodes (max value limited by available RAM)
grSize = 25; 

%% GR_OPTIONS - params to filter
%   'dl' - diameter must be less then setted diameter 
%   'dg' - diameter must be greater then setted diameter 
%   'de' - diameter must be equal to setted diameter
%   'pl' - max nodes power must be less then setted power 
%   'pg' - max nodes power must be greater then setted power 
%   'pe' - max nodes power must be equal to setted power 
%   'el' - max edges count must be less then setted edges count 
%   'eg' - max edges count must be greater then setted edges count 
%   'ee' - max edges count must be equal to setted edges count
%���� ���� ����������� ����������� ������ �� ���������, ������� ���� ������ 
 
GR_OPTIONS = struct( ...
    'dl', 4, ...
    'de', [], ...
    'dg', [], ...
    'pl', 4, ...
    'pe', [], ...
    'pg', [], ...
    'el', [], ...
    'ee', [], ...
    'eg', [] ...
    );

%% init cost function options struct
COST_F_OPT = struct( ...
    'power',    0.1, ...
    'diam',     0.4, ...
    'medDs',    0.3, ...
    'edgeC',    0.2 ...
    );

%% percent of start population that will be chose to next evolution
BEST_START = 10;

%% percent of generated population that will be chose to next evolution
BEST_GENERATED = 10;

%% percent of worst-generated population that will be chose to next evolution
WORST_GENERATED = 0.05; %required for finding the global minimum of cost function

%% size of start population  (count of graphs per edges)
IND_PER_EDGES = 20;

%% size of start population (recommend use value in range [10 100000] )
start_pop_c = 2000; 

%% size of generated population 
generated_pop_c = 1000; %(recommend use value in range [10 100000] )

%% some calculations
best_start_c =          20;% floor(min([start_pop_c, generated_pop_c]) * BEST_START / 100);
best_generated_c =      floor(generated_pop_c * BEST_GENERATED / 100);
worst_generated_c =     ceil(generated_pop_c * WORST_GENERATED / 100);

%% maximum epoch count
EPOCH_C = 100; 

%% Genetic alg options
CROSSOVER_GENERATE = 2; %crossover generate CROSSOVER_GENERATE new person
MUTATION_CHANCE = 50; %70 percent
INVERSION_CHANCE = 50; %15 percent
EPOCH_WITHOUT_FILTER = 20;

%% init graph struct
 s = struct( ...
    'Matrix',       [], ...
    'DG',           [], ...
    'Vector',       [], ...
    'EdgeCount',    [], ...
    'MedDist',      [], ...
    'Diameter',     [], ...
    'Power',        [], ...
    'Size',         [], ...
    'Goal',         []  ...
    );