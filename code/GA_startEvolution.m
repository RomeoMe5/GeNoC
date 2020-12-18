%% GA_startEvolution.m - start genetic evolution
%% @todo: add options: - load start population from the file
%%
% 1. Generate data
% 2. Start evolution
% 3. Show and save the result
try close(handler); catch end;
clear all;      %clear Workspace
clc;            %clear cmd
close all;      %close all figure


%Вказуйте тільки файл, що був збережений в даній функції
%для уникнення помилок бажано вказувати файл передостанньої еволюції
LOAD_FILE = '';%'d:\!!WORK\GA_fin_new\81_22-Nov-2013  7_04 PM\100_evolution.mat';
% ящо не потрібно довчати вказуйте пусте поле
try
    load(LOAD_FILE);
    S = 'Ok';
    fprintf('%s is load successfully\n', LOAD_FILE);
catch
    S = [];
end
if isempty(S) %file not loaded
    %=========== first of all we initialize all required variables ===========%
    init_gr; %see init_gr.m and change if needed
    COST_PARAM = GA_CalcWorstParam(grSize);
    grVectS = GR_Size(grSize);
    SAVE_EVERY = 15; %save every %SAVE_EVERY% evolutions
    time = datestr(rem(now,1));
    time(time == ':') = '_';
    DIR_NAME = [num2str(grSize) '_' date ' ' time];
    
    %% ================== 1. Generate start population ===================== %%
    startPop = GA_GenerateStartPop_V2(grSize, IND_PER_EDGES,...
        COST_F_OPT, COST_PARAM, GR_OPTIONS);
    startPopTemp = startPop;
    
    SIZE_START = length(startPop);
    
    [startPop] = GR_Filter(startPop, GR_OPTIONS);
    
    if SIZE_START ~= 0 && isempty(startPop)
        fprintf('We could not generate good start population for this init_gr\n');
        fprintf('We try to make some count of GENETIC iteration without filtering\n')
        WITHOUT_FILTER = 1;
        st_Graph = startPopTemp;
    else
        fprintf('We  generate nice start population for this init_gr\n');
        st_Graph = startPop;
        WITHOUT_FILTER = 0;
    end
    
    
%% ======================= 2. Start evolution ========================== %%
    GoalFHistoryMin = 0;
    GoalFHistoryMid = 0;
    GoalFHistoryMax = 0;
    
    line1 = ('============================================================\n');
    line2 = ('------------------------------------------------------------\n');
    tStart = tic;
    fprintf(line1);
    fprintf('Start genetic algorithm\n');
    eC = 1;
end
%% Do many iterations %%
for eC = eC : EPOCH_C
    fprintf(line2);
    fprintf('%d evolution:\n', eC);
    tEvol = tic;
    
    costF = [];
    costF = [ st_Graph(:).Goal ];
    GoalFHistoryMin(eC) = min(costF);
    GoalFHistoryMid(eC) = median(costF);
    GoalFHistoryMax(eC) = max(costF);
    
    if mod(eC, SAVE_EVERY) == 0
        %then save it
        if ~exist(DIR_NAME)
            mkdir(DIR_NAME);
        end
        fileName = [DIR_NAME '\' num2str(eC) '_evolution.mat'];
        save(fileName);
    end
    
    %% ------------------------ test  derivative --------------------------- %%
    if eC > 1
        derivative(eC - 1) = GoalFHistoryMin(eC) - GoalFHistoryMin(eC - 1);
        if(eC > 30)
            if sum(sum(derivative(eC - 15 : eC - 1))) == 0
                [ans, bestIndx] = sort(costF);
                bestResult = st_Graph(bestIndx(1));
                fprintf('Stop genetic !!!\n');
                break;  %!!!!stop genetic -> exit from while loop
            end
        end
    end
    
    %% ------------------ generation  of new population -------------------- %%
    j = 1;
    generatedPop = [];
    while j <= generated_pop_c
        % 1. operator crossover
        %chose first individum that has goal function better than median
        %and second individum will be choosen randomly or olthe use best
        tmpGraph = st_Graph(costF < GoalFHistoryMid(eC));
        if isempty(tmpGraph)
            %than we near to local or global minimum
            first_ind = st_Graph( GR_rand(length(st_Graph)) );
            second_ind = st_Graph( GR_rand(length(st_Graph)) );
        else
            first_ind = tmpGraph( GR_rand(length(tmpGraph)) );
            second_ind = st_Graph( GR_rand(length(st_Graph)) );
        end
        
        if rand(1,1) > 0.5
            second_ind = st_Graph( GR_rand(length(st_Graph)) );
        end

        
        tmp_pop = GA_Crossover(first_ind.Vector, second_ind.Vector, ...
            CROSSOVER_GENERATE, 2);
        generatedPop = [generatedPop; tmp_pop];
        
        % 2. operation is mutation
        if rand(1, 1) <= MUTATION_CHANCE/100
            choosen_ind = st_Graph( GR_rand(length(st_Graph)) );
            tmp_pop = GA_Mutation(choosen_ind.Vector,  GR_rand(10));
            generatedPop = [generatedPop; tmp_pop];
        end
        
        % 3. operation is inversion
        if rand(1, 1) <= INVERSION_CHANCE/100
            choosen_ind = st_Graph( GR_rand(length(st_Graph)) );
            tmp_pop = GA_Inversion(choosen_ind.Vector);
            generatedPop = [generatedPop; tmp_pop];
        end
        j = size(generatedPop, 1);
    end
    
    %now new population is generated
    %filter it
    generatedPop = GR_FilterTwinsVec(generatedPop);
    genPopStruct = GR_CreateGraphStruct(generatedPop, @GA_CostF_MDistMDiamMEdge_, COST_F_OPT);
    
    if ~WITHOUT_FILTER
        genPopStruct = GR_Filter(genPopStruct, GR_OPTIONS);
    elseif eC > EPOCH_WITHOUT_FILTER
        genPopStruct = GR_Filter(genPopStruct, GR_OPTIONS);
        if isempty(genPopStruct)
            fprintf('Sorry but we can''t find some results for this init_gr.h');
            return;
        end
    %else do nothing
    end
 
    %selection best of person from start and generated population + some
    %worst individuals (some solt, for exclude local minimum)
    st_Graph = [...
        GA_FindBestIndivid(st_Graph, best_start_c)';...
        GA_FindBestIndivid(genPopStruct, best_generated_c)';...
        GA_FindBestIndivid(genPopStruct, worst_generated_c, 0)';...
        ]';
    
    genPopStruct = GA_FilterTwins(genPopStruct);
    
    %% next 
    fprintf('Goal function: %d\n', GoalFHistoryMin(eC));
    tElapsed = toc(tEvol);
    fprintf('Evolution time is %f seconds\n', tElapsed);
    % Plot data (when eC >= 2)
    if eC > 1
        subplot(2,1,1);
        graphHandle = plot(GoalFHistoryMin, 'g', 'LineWidth',3);
        hold all;
        plot(GoalFHistoryMid, 'b', 'LineWidth',3);
        plot(GoalFHistoryMax, 'r', 'LineWidth',3);
        legend('Minimum cost function', 'Average cost function', 'Maximum cost function');
        subplot(2,1,2);
        plot(-derivative, 'g', 'LineWidth',4);
        legend('Derivative');
        %linkdata on;
        drawnow;
    end
end
if eC == EPOCH_C
    [ans, bestIndx] = sort(costF);
    bestResult = st_Graph(bestIndx(1));
end
tElapsed = toc(tStart);

%% 3. Show and save the result
fprintf('====================================================\n');
fprintf('Genetic evolution finished\n');
fprintf('Numbers of evolutions:%d\nTime %f seconds\n', eC, tElapsed);
fprintf('Best result:\n');
fprintf('Goal function: %d\n',      GoalFHistoryMin(eC));
fprintf('Diameter: %d\n',           bestResult.Diameter);
fprintf('Edge Count: %d\n',         bestResult.EdgeCount);
fprintf('Max power: %d\n',          bestResult.Power);
fprintf('Median distance: %d\n',    bestResult.MedDist);
[handler, gr_im] = GR_View(bestResult.DG);

%% save best result
graphHandle = gcf;
set(graphHandle, 'Units','normalized', 'Position', [0 0 1 1 ] );
GA_SaveResult(DIR_NAME , bestResult, getframe(graphHandle), gr_im);