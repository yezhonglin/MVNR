k=20;  % dimensions of matrix W and H
lambda = 0.1;   % regularization parameter
train_ratio = 0.9;  % training ratio for SVM classifier
loss =10; %square loss, don't change
textRank=20;%dimensions of text matrix

disp('start');
graph = rand(100,100)/2;% graph must be N*N Matrix. not N*M
Features=speye(100);
ColFeatures = rand(100,20);
[W,H,time] = train_mf(sparse(graph), sparse(Features), sparse(ColFeatures), [' -l ' num2str(lambda) ' -k ' num2str(k) ' -t 10' ' -s ' num2str(loss)]); 
disp('finished');

%test svds
text = rand(100,200)/2;
[U,S,V] = svds(text, 100);
text_feature = U * S;