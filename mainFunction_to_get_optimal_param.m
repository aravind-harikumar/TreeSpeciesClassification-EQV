%%Sensitivity Analysis
clear all;

%% Set environment
addpath(genpath('./1.Functions'));
addpath(genpath('./2.Dataset'));
DataSetName = 'Dataset_50_trees'; % 'Dataset_50_trees', 'Dataset_20_trees', 'All'(Dataset_50_trees + Dataset_20_trees)
InputFolderLidar = [cd('.') '\2.Dataset/ManuallySegmentedDataset_new/',DataSetName,'/'];
OutputPath = './3.OutputPathSVM/'; if exist(OutputPath,'dir')==0; mkdir(OutputPath);end
species = {'ab','ar','la','pc',};  % 'be','su' are deciduous
ver=1;

%% set training and testing set
dataindice.train =[1:35]; dataindice.test = [36:50];  % we get max acc. of 86.6% for Dataset_50_trees
if(strcmp(DataSetName,'All'))
    dataindice.train =[1:50]; dataindice.test = [51:70]; % first 50 samples for training and rest of the samples for testing
end

if(true)
    %% -----------------------------------------------------------------------%
    %                           RADIAL QUANTIZATION
    %-------------------------------------------------------------------------%
    % % set range parameters
    rstep.min=2; rstep.step=1; rstep.max=2; % radial axis quantization range
    deg_step = [1]; % i.e. 1 is EQUIVALENT TO NO ANGULAR QUANTIZATION
    hstep.min=1; hstep.step=2; hstep.max=1; % height axis quantization range (N.A. now)
    parameters.isConstantRadius = false; % if adaptive or constant radial step TI = true, TD = false
    parameters.isConstantHeight = false; % if adaptive or constant height step TI = true, TD = false
    parameters.isgloblaNorm = true; % if global and height norm GNorm = true
    % run sensitivity analysis
    RSensitivityMatrix = SenstivityAnalysis(deg_step, rstep, hstep, InputFolderLidar, species, dataindice, parameters);
    save([OutputPath 'R_SensitivityMatrix' num2str(ver)], 'RSensitivityMatrix');
end

if(false)
    %% -----------------------------------------------------------------------%
    %                           ANGULAR QUANTIZATION
    %-------------------------------------------------------------------------%
    % set range parameters
    rstep.min=1; rstep.step=1; rstep.max=1; % 1 is EQUIVALENT TO NO RADIAL QUANTIZATION
    deg_step = [1 4 8 12 16 24]; %  % angualar axis quantization range.
    hstep.min=60; hstep.step=10; hstep.max=100; % height axis quantization range (N.A now)
    isConstantRadius = true; % if adaptive or constant radial step
    isConstantHeight = false; % if adaptive or constant height step
    isgloblaNorm = true; % if global and height norm
    % run sensitivity analysis
    ASensitivityMatrix = SenstivityAnalysis(deg_step, rstep, hstep, InputFolderLidar, species, dataindice, parameters);
    save([OutputPath 'A_SensitivityMatrix' num2str(ver)], 'ASensitivityMatrix');
end

if(false)
    %% -----------------------------------------------------------------------%
    %                      ANGULAR-RADIAL QUANTIZATION
    %-------------------------------------------------------------------------%
    % set range parameters
    rstep.min=1; rstep.step=1; rstep.max=10; % radial axis quantization range
    deg_step = [1 4 8 12 16 24]; % angualar axis quantization range. Divide 360° into N equal sectors [where N = {1 4 8 12 16 24}]
    hstep.min=60; hstep.step=10; hstep.max=100; % height axis quantization range (N.A Now)
    isConstantRadius = true; % if adaptive or constant radial step
    isConstantHeight = false; % if adaptive or constant height step
    isgloblaNorm = true; % if global and height norm
    % run sensitivity analysis
    ARSensitivityMatrix = SenstivityAnalysis(deg_step, rstep, hstep, InputFolderLidar, species, dataindice, parameters);
    save([OutputPath 'AR_SensitivityMatrix' num2str(ver)], 'ARSensitivityMatrix');
end


