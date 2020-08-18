function [var_opt, CurveLength, Error_mse] = script_elbow_DDRTree(Feature_Table, params)
%% ========================================================================
% Embedded structure learning
%
%--------------------------------------------------------------------------
% Input
%   Feature_Table : table of the selected OTUs
%       -- tax
%            taxonomy of the selected OTUs
%       -- logRel
%            relative abundance of the selected OTUs after 10-base log
%            transformation
%       -- weight
%            feature weight of the selected OTUs learned from LOGO
%
%   params       : parameters
%       -- sigma
%            bandwidth parameter
%       -- lambda
%            regularization parameter for inverse graph embedding
%       -- f_sig
%            optimize the bandwidth (0: optimize lambda; 1: optimize sigma)
%       -- var_ls
%            range of the variable to be tuned
%--------------------------------------------------------------------------
% Output
%   var_opt     : optimal vale of the tuned variable
%   CurveLength : total length of the principal tree
%   Error_mse   : mean squared error
%--------------------------------------------------------------------------
% Author: Lu Li
% update history: 08/10/2020
%% ========================================================================

%% Initializations
para4ddr = params;
para4ddr.maxIter = 100; % maximum iterations
para4ddr.eps = 1e-9;    % relative objective difference
para4ddr.dim = 3;       % reduced dimension
para4ddr.gamma = 2;     % regularization parameter for k-means
f_sig = params.f_sig;

if ~isfield(params, 'var_ls')
    if f_sig==1
        params.var_ls = [0.0001 0.001 0.005 0.01 0.05 0.1 0.15 0.5 1.5 2.5 4 5 10 15 20];
    else
        params.var_ls = [2 3 5 7 10 20 50 150 500 1000 2000 3000 5000  7000 10000];
    end
end
var_ls = params.var_ls;
var_ls = sort(var_ls);
n = length(var_ls);
CurveLength = zeros(1, n);
Error_mse = zeros(1, n);

for i=1:length(var_ls)
    if f_sig==1
        para4ddr.sigma = var_ls(i);
    else
        para4ddr.lambda = var_ls(i);
    end
    [~, ~,~, ~, history] = DDRTree(Feature_Table.logRel, para4ddr);
    
    Error_mse(i)= history.mse(end);
    CurveLength(i) = history.length(end);
end
var_opt = ElbowPosition(Error_mse, CurveLength, var_ls, 1, f_sig, 10);
end