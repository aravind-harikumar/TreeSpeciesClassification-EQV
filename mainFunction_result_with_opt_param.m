%%Sensitivity Analysis
clear all;

%% Set environment
addpath(genpath('./1.Functions'));
addpath(genpath('./2.Dataset'));
InputFolderLidar = [cd('.') '/2.Dataset/ManuallySegmentedDataset_new/Dataset_50_trees/']; % Dataset_50_trees + Dataset_20_trees
OutputPath = './3.OutputPathSVM/'; if exist(OutputPath,'dir')==0; mkdir(OutputPath);end
species = {'ar','la','pc','ab'};  % 'be','su' are deciduous
ver=1;

isConstantRadiusArr = [true];
isConstantHeightArr = [true];
isGlobalNormArr = [false];

%% set training and testing set division for each class
%dataindice.train =[1:35]; dataindice.test = [36:50];  % for Dataset_50_trees
outmatrix = [];
outmatrixAcc =[];
for i =1:1:20
    
    % rand permulation (run 20 times)
    idx = randperm(50);
    dataindice.train = idx(1:35);
    dataindice.test = idx(36:50);
    
    % %% -----------------------------------------------------------------------%
    % %                      ANGULAR-RADIAL QUANTIZATION
    % %-------------------------------------------------------------------------%
    % ARSensitivityMatrixFinal =[];
    % for aa = 1:1:length(isGlobalNormArr)
    %     NormStrategy = isGlobalNormArr(aa);
    %     for bb = 1:1:length(isConstantRadiusArr)
    %         radStr = isConstantRadiusArr(bb);
    %         for cc=1:1:length(isConstantHeightArr)
    %             htStr = isConstantHeightArr(cc);
    %             % % set range parameters
    %             % set range parameters
    %             rstep.min=8; rstep.step=1; rstep.max=8; % radial axis quantization range
    %             deg_step = [4]; % angualar axis quantization range. Divide 360° into N equal sectors [where N = {1 4 8 12 16 24}]
    %             hstep.min=60; hstep.step=10; hstep.max=60; % height axis quantization range
    %             parameters.isConstantRadius = radStr; % if adaptive or constant radial step
    %             parameters.isConstantHeight = htStr; % if adaptive or constant height step
    %             parameters.isgloblaNorm = NormStrategy; % if global and height norm
    %             % run sensitivity analysis
    %             [ARSensitivityMatrix,classification_stats] = SenstivityAnalysis(deg_step, rstep, hstep, InputFolderLidar, species, dataindice, parameters);
    %             ARSensitivityMatrixFinal = [ARSensitivityMatrixFinal; NormStrategy  radStr  htStr  ARSensitivityMatrix];
    %         end
    %     end
    % end
    % save([OutputPath 'AR_SensitivityMatrixFinal' num2str(ver)], 'ARSensitivityMatrixFinal');
    
    %% -----------------------------------------------------------------------%
    %                           RADIAL QUANTIZATION
    %-------------------------------------------------------------------------%
    
    RSensitivityMatrixFinal =[];
    for aa = 1:1:length(isGlobalNormArr)
        NormStrategy = isGlobalNormArr(aa);
        for bb = 1:1:length(isConstantRadiusArr)
            radStr = isConstantRadiusArr(bb);
            for cc=1:1:length(isConstantHeightArr)
                htStr = isConstantHeightArr(cc);
                % % set range parameters
                rstep.min=8; rstep.step=1; rstep.max=8; % radial axis quantization range
                deg_step = [1]; % i.e. 1 is EQUIVALENT TO NO ANGULAR QUANTIZATION
                hstep.min=60; hstep.step=10; hstep.max=60; % height axis quantization range
                parameters.isConstantRadius = radStr; % if adaptive or constant radial step
                parameters.isConstantHeight = htStr; % if adaptive or constant height step
                parameters.isgloblaNorm = NormStrategy; % if global and height norm
                % run sensitivity analysis
                [RSensitivityMatrix,classification_stats] = SenstivityAnalysis(deg_step, rstep, hstep, InputFolderLidar, species, dataindice, parameters);
                RSensitivityMatrixFinal = [RSensitivityMatrixFinal; NormStrategy  radStr  htStr  RSensitivityMatrix];
                
            end
        end
    end
    save([OutputPath 'R_SensitivityMatrixFinal' num2str(ver)], 'RSensitivityMatrixFinal');
    
    outmatrix{i} = classification_stats;
    outmatrixAcc(i) = mean(classification_stats.accuracy);
    % %-----------------------------------------------------------------------%
    % %                         ANGULAR QUANTIZATION
    % %-------------------------------------------------------------------------%
    % ASensitivityMatrixFinal =[];
    % for aa = 1:1:length(isGlobalNormArr)
    %     NormStrategy = isGlobalNormArr(aa);
    %     for bb = 1:1:length(isConstantRadiusArr)
    %         radStr = isConstantRadiusArr(bb);
    %         for cc=1:1:length(isConstantHeightArr)
    %             htStr = isConstantHeightArr(cc);
    %             % set range parameters
    %             rstep.min=1; rstep.step=1; rstep.max=1; % 1 is EQUIVALENT TO NO RADIAL QUANTIZATION
    %             deg_step = [4]; %  % angualar axis quantization range. 1 4 8 12 16 24
    %             hstep.min=70; hstep.step=10; hstep.max=70; % height axis quantization range
    %             parameters.isConstantRadius = radStr; % if adaptive or constant radial step
    %             parameters.isConstantHeight = htStr; % if adaptive or constant height step (N.A)
    %             parameters.isgloblaNorm = NormStrategy; % if global and height norm
    %             % run sensitivity analysis
    %             [ASensitivityMatrix,classification_stats] = SenstivityAnalysis(deg_step, rstep, hstep, InputFolderLidar, species, dataindice, parameters);
    %             ASensitivityMatrixFinal = [ASensitivityMatrixFinal; NormStrategy  radStr  htStr  ASensitivityMatrix];
    %         end
    %     end
    % end
    % save([OutputPath 'A_SensitivityMatrixFinal' num2str(ver)], 'ASensitivityMatrixFinal');
    
end
