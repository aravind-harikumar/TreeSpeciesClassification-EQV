function getAccuraciesTable()

load('AR_SensitivityMatrix1.mat');
outRow7 = getMaxAccuracyRow(SensitivityMatrix,4);
AR_SensitivityMatrix1 = [{'AR_SensitivityMatrix1'} outRow7(1) outRow7(2) outRow7(3) outRow7(4)];


% combination of angular and radial
% outRow7 = getMaxAccuracyRow(angular_radial_delta_global_norm,4);
% angular_radial_delta_global_norm_row = [{'angular_radial_delta_global_norm'} outRow7(1) outRow7(2) outRow7(3) outRow7(4)];
% outRow8 = getMaxAccuracyRow(angular_radial_delta_height_norm,4);
% angular_radial_delta_height_norm_row = [{'angular_radial_delta_height_norm'} outRow8(1) outRow8(2) outRow8(3) outRow8(4)];
% outRow9 = getMaxAccuracyRow(angular_radial_k_global_norm,4);
% angular_radial_k_global_norm_row = [{'angular_radial_k_global_norm'} outRow9(1) outRow9(2) outRow9(3) outRow9(4)];
% outRow10 = getMaxAccuracyRow(angular_radial_k_height_norm,4);
% angular_radial_k_height_norm_row = [{'angular_radial_k_height_norm'} outRow10(1) outRow10(2) outRow10(3) outRow10(4)];

% OutArr = [TI_0_angular_global_norm_row; TI_0_angular_height_norm_row;...
%          TI_00_radial_delta_global_norm_row; TI_00_radial_delta_height_norm_row; TI_01_radial_delta_global_norm_row; TI_01_radial_delta_height_norm_row; ...
%          TI_10_radial_delta_global_norm_row; TI_10_radial_delta_height_norm_row;TI_11_radial_delta_global_norm_row;TI_11_radial_delta_height_norm_row]
%

%delete('csvlistout.csv');
%csvwrite('csvlistout.csv', OutArr,0);

end