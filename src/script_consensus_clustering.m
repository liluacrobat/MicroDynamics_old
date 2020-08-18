function cidx = script_consensus_clustering(Feature_Table, params)
%% ========================================================================
% Feature selection within LOGO framework
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
%   params        : parameters
%       -- cluster_num  : number of clusters
%       -- iters        : number of iterations
%--------------------------------------------------------------------------
% Output
%   cidx : cluster labels
%--------------------------------------------------------------------------
% Author: Lu Li
% update history: 08/10/2020
%% ========================================================================

cluster_num = params.cluster_num;
X = Feature_Table.logRel;
consensus_mtx = ConsensusClustering(X, cluster_num, params.iters);

% perform hierarchical clustering on the consensus matrix
Y = pdist(1-consensus_mtx);
Z = linkage(Y,'complete');
cidx = cluster(Z,'maxclust', cluster_num);
end

function consensus = ConsensusClustering(X,K,iter)
X=X';
rng(11,'twister');
[m,~] = size(X);
ms = round(m*0.8);
CMmat = zeros(m);
CMCmat = zeros(m);

for i=1:iter
    idx = randperm(m,ms);
    Xi = X(idx,:);
    CMmat(idx,idx) = CMmat(idx,idx)+1;
    [cidxi, ~] = kmeans(Xi, K, 'Replicates',20,'OnlinePhase','off');
    temp = zeros(ms);
    for j=1:ms
        sel = cidxi==cidxi(j);
        temp(j,sel) = temp(j,sel)+1;
    end
    CMCmat(idx,idx) = CMCmat(idx,idx)+temp;
end
consensus = CMCmat./CMmat;
end




