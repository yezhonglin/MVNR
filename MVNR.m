clear all

data = 'citeseer';  % 'dblp' or 'citeseer' or 'wiki'
%% Parameters
embed_len=100;  % dimensions of matrix W and H
lambda = 0.1;   % regularization parameter
loss = 10;


 
load([data,'/graph.txt']);
edgelist = graph;
%% adjacency matrix
Adj = full(FormNet(graph));

%% load the MFI matrix

left_features = load([data,'/MFI_', data ,'.txt']);


numOfNode = size(left_features,1);
E = speye(numOfNode);

    
    %% the network representation learning of the 1-step network
    A = triu(Adj); 
    
    [rowA, colA] = find( A ~= 0 );
     % get the column and row values for adjacency matrix
    edgelist_A = [rowA-1 colA-1];
    [MA] = Build_M_Matrix(edgelist_A,numOfNode);   
   
     % weight matirix to AAAA
    right_A = Adj.*left_features;
   
     % Joint learning
    display('learning A...');
    [WA,HA,time] = train_mf(sparse(MA), sparse(E), sparse(right_A), [' -l ' num2str(lambda) ' -k ' num2str(embed_len) ' -t 10' ' -s ' num2str(loss)]); 
    rep_A = [WA'];
     
    %rep_A = rep_A./ ( repmat( sqrt(sum(rep_A.^(2), 2)), 1, embed_len)) ;
    embedding1 = [rep_A];
    

  
     %% the network representation learning of the 2-step network
     AA = Adj * Adj;
     
     % the elements of diagonal line set to 0
     AA = AA-diag(diag(AA));
     % adjacency matrix to AA
     Adj_AA = AA;
     Adj_AA(Adj_AA > 0) = 1;
     % convert to upper triangular matrixtext_feature
     AA = triu(AA);
     [rowAA, colAA] = find( AA ~= 0 );
     % get the column and row values for adjacency matrix
     edgelist_AA = [rowAA-1 colAA-1];
     [MAA] = Build_M_Matrix(edgelist_AA,numOfNode);
     
     right_AA = Adj_AA.*left_features;
  
     % Joint learning
     display('learning AA...');
     [WAA,HAA,time] = train_mf(sparse(MAA), sparse(E), sparse(right_AA), [' -l ' num2str(lambda) ' -k ' num2str(embed_len) ' -t 10' ' -s ' num2str(loss)]); 
     rep_AA = [WAA'];
  
     %rep_AA = rep_AA./ ( repmat( sqrt(sum(rep_AA.^(2), 2)), 1, embed_len)) ;
     embedding2 = [rep_A rep_AA];
    
     
     

 
     %% the network representation learning of the 3-step network
     AAA = Adj * Adj * Adj;
     
      % the elements of diagonal line set to 0
     AAA = AAA-diag(diag(AAA));
     % adjacency matrix to AAA
     Adj_AAA = AAA;
     Adj_AAA(Adj_AAA > 0) = 1;
     % convert to upper triangular matrix
     AAA = triu(AAA);
     [rowAAA, colAAA] = find( AAA ~= 0 );
      % get the column and row values for adjacency matrix
     edgelist_AAA = [rowAAA-1 colAAA-1];
     [MAAA] = Build_M_Matrix(edgelist_AAA,numOfNode);
       % weight matirix to AAA
     right_AAA = Adj_AAA.*left_features;
    
     % Joint learning
     display('learning AAA...');
     [WAAA,HAAA,time] = train_mf(sparse(MAAA), sparse(E), sparse(right_AAA), [' -l ' num2str(lambda) ' -k ' num2str(embed_len) ' -t 10' ' -s ' num2str(loss)]); 
     rep_AAA = [WAAA'];
    
     %rep_AAA = rep_AAA./ ( repmat( sqrt(sum(rep_AAA.^(2), 2)), 1, embed_len));
     embedding3 = [rep_A rep_AA rep_AAA];
    
  

     %% the network representation learning of the 4-step network
     AAAA = Adj * Adj * Adj * Adj;
   
      % the elements of diagonal line set to 0
     AAAA = AAAA-diag(diag(AAAA));
     % adjacency matrix to AA
     Adj_AAAA = AAAA;
     Adj_AAAA(Adj_AAAA > 0) = 1;
     % convert to upper triangular matrix
     AAAA = triu(AAAA);
     [rowAAAA, colAAAA] = find( AAAA ~= 0 );
      % get the column and row values for adjacency matrix
     edgelist_AAAA = [rowAAAA-1 colAAAA-1];
     [MAAAA] = Build_M_Matrix(edgelist_AAAA,numOfNode);
       % weight matirix to AAAA
     right_AAAA = Adj_AAAA.*left_features;
   
     % Joint learning
     display('learning AAAA...');
     [WAAAA,HAAAA,time] = train_mf(sparse(MAAAA), sparse(E), sparse(right_AAAA), [' -l ' num2str(lambda) ' -k ' num2str(embed_len) ' -t 10' ' -s ' num2str(loss)]); 
     rep_AAAA = [WAAAA'];
    
     %rep_AAAA = rep_AAAA./ ( repmat( sqrt(sum(rep_AAAA.^(2), 2)), 1, embed_len)) ;
     embedding4 = [rep_A rep_AA rep_AAA rep_AAAA];
     
     
     
     %% the network representation learning of the 5-step network
     AAAAA = Adj * Adj * Adj * Adj * Adj;
    
      % the elements of diagonal line set to 0
     AAAAA = AAAAA-diag(diag(AAAAA));
     % adjacency matrix to AA
     Adj_AAAAA = AAAAA;
     Adj_AAAAA(Adj_AAAAA > 0) = 1;
     % convert to upper triangular matrix
     AAAAA = triu(AAAAA);
     [rowAAAAA, colAAAAA] = find( AAAAA ~= 0 );
      % get the column and row values for adjacency matrix
     edgelist_AAAAA = [rowAAAAA-1 colAAAAA-1];
     [MAAAAA] = Build_M_Matrix(edgelist_AAAAA,numOfNode);
       % weight matirix to AAAAA
     right_AAAAA = Adj_AAAAA.*left_features;
   
     % Joint learning
     display('learning AAAAA...');
     [WAAAAA,HAAAAA,time] = train_mf(sparse(MAAAAA), sparse(E), sparse(right_AAAAA), [' -l ' num2str(lambda) ' -k ' num2str(embed_len) ' -t 10' ' -s ' num2str(loss)]); 
     rep_AAAAA = [WAAAAA'];
    
     %rep_AAAAA = rep_AAAAA./ ( repmat( sqrt(sum(rep_AAAAA.^(2), 2)), 1, embed_len)) ;
     embedding5 = [rep_A rep_AA rep_AAA rep_AAAA rep_AAAAA];
     
    
     
  
     %% the network representation learning of the 6-step network
     AAAAAA = Adj * Adj * Adj * Adj * Adj * Adj;
    
      % the elements of diagonal line set to 0
     AAAAAA = AAAAAA-diag(diag(AAAAAA));
     % adjacency matrix to AA
     Adj_AAAAAA = AAAAAA;
     Adj_AAAAAA(Adj_AAAAAA > 0) = 1;
     % convert to upper triangular matrix
     AAAAAA = triu(AAAAAA);
     [rowAAAAAA, colAAAAAA] = find( AAAAAA ~= 0 );
      % get the column and row values for adjacency matrix
     edgelist_AAAAAA = [rowAAAAAA-1 colAAAAAA-1];
     [MAAAAAA] = Build_M_Matrix(edgelist_AAAAAA,numOfNode);
       % weight matirix to AAAAAA
     right_AAAAAA = Adj_AAAAAA.*left_features;
   
     % Joint learning
     display('learning AAAAAA...');
     [WAAAAAA,HAAAAAA,time] = train_mf(sparse(MAAAAAA), sparse(E), sparse(right_AAAAAA), [' -l ' num2str(lambda) ' -k ' num2str(embed_len) ' -t 10' ' -s ' num2str(loss)]); 
     rep_AAAAAA = [WAAAAAA'];
    
     %rep_AAAAAA = rep_AAAAAA./ ( repmat( sqrt(sum(rep_AAAAAA.^(2), 2)), 1, embed_len)) ;
     embedding6 = [rep_A rep_AA rep_AAA rep_AAAA rep_AAAAA rep_AAAAAA]; 

