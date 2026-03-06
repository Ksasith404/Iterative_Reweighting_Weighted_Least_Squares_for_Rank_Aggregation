function svmrank = svm_rank_aggregate(PHat, W)

n = size(PHat,1);

X = [];   % feature differences
Y = [];   % outcomes

for i = 1:n
    for j = 1:n
        if i ~= j && W(i,j) > 0
            xij = zeros(1,n);
            xij(i) = 1;
            xij(j) = -1;
            X = [X; xij];
            if PHat(i,j) > 0.5
                Y = [Y; 1];
            else
                Y = [Y; -1];
            end
        end
    end
end

model = fitcsvm(X,Y,'KernelFunction','linear','BoxConstraint',1);

scores = model.Beta;
scores = scores - mean(scores);

[~, order] = sort(scores,'descend');
svmrank = zeros(1,n);
svmrank(order) = 1:n;

end