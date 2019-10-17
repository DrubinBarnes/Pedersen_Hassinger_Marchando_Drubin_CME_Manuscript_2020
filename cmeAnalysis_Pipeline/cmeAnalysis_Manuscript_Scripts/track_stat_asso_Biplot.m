%% Biplot of Coefficients and Scores
%%
figure
%%
% Define the variable matrix and delete the rows with missing values.
x = [track_stat_asso(:,4:6) track_stat_asso(:,13:end)];
%x = x(all(~isnan(x),2),:);
%%
% Perform a principal component analysis of the data.
[coefs,score] = pca(zscore(x));
%%
% View the data and the original variables in the space of the first three
% principal components.
vbls = {'GFP-Lifetime','RFP-Lifetime','Total-Lifetime','GFP-Max-Intensity',...
    'GFP-Mean-Intensity', 'GFP-Int-Change', 'GFP-Pos-Change'...
    'RFP-Max-Intensity', 'RFP-Mean-Intensity', 'RFP-Int-Change', 'RFP-Pos-Change'...
    };
%biplot(coefs(:,1:3),'scores',score(:,1:3),'varlabels',vbls);
biplot(coefs(:,1:2),'scores',score(:,1:2),'varlabels',vbls);