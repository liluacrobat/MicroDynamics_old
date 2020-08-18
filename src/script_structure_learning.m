function PrincipalTree = script_structure_learning(Feature_Table, Table_clinic, params)
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
%   Table_clinic : meta table of clinic information
% 
%   params       : parameters
%       -- sigma
%            bandwidth parameter
%       -- lambda
%            regularization parameter for inverse graph embedding
%       -- col_label
%            The Column of the clinical information used for feature
%            selection
%--------------------------------------------------------------------------
% Output
%   PrincipalTree : principal tree learned from data
%       -- W
%            projection matrix
%       -- projection 
%            projection of data points in the sapce of reduced dimension
%       -- edges
%            edges of the principal tree
%       -- edges_post
%            edges of the principal tree after post processing
%       -- PTree
%            data points of the principal tree
%       -- PTree_post
%            data points of the principal tree after post processing
%       -- ProgPath
%            extracted progression path including the ordered index of samples
%       -- ProgPath_tree
%            extracted progression path including the ordered index of tree
%            points
%       -- ProgDis
%            progression distance of samples along the extracted path
%       -- DataProjection
%            projection of data on the principalk tree
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

%% Learn the principal tree
[W, projection, edges, PTree, ~] = DDRTree(Feature_Table.logRel, para4ddr);

PrincipalTree.W = W;
PrincipalTree.projection  = projection;
PrincipalTree.edges  = edges;
PrincipalTree.PTree  = PTree;

subtype = table2cell(Table_clinic(:,params.col_label));
[extracted_path, extracted_pathDist, PTree_etd, extracted_curve,...
    edges_post, DataProjection] = StruPostProcess(PTree, projection, subtype);

PrincipalTree.PTree_post = PTree_etd;
PrincipalTree.ProgPath = extracted_path;
PrincipalTree.ProgPath_tree = extracted_curve;
PrincipalTree.ProgDis = extracted_pathDist;
PrincipalTree.edges_post = edges_post;
PrincipalTree.DataProjection = DataProjection;
end