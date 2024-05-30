function data = cell2matr(A)

[x,classes] = size(A);

X = A{1};
Y = ones(size(A{1},1),1);

    for c=2:classes
        [num_sample,num_feature] = size(A{c});
        X = [X; A{c}];
        y = ones(num_sample,1)*c;
        Y = [Y; y];
    end

data = [X,Y];
end