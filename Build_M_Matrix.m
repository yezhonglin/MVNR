function [graph] = Build_M_Matrix(graph,numOfNode)
%% Build matrix M=(A+A*A)/2 
display ('Computing matrix M...');
graph(:,1) = graph(:,1) + ones(size(graph(:,1)));
graph(:,2) = graph(:,2) + ones(size(graph(:,2)));

graph = [graph;graph(:,2) graph(:,1)];

graph = sparse(graph(:,1),graph(:,2),ones(size(graph(:,1))),numOfNode,numOfNode);


for i=1:size(graph,1)
  if (norm(graph(i,:))>0)
      graph(i,:) = graph(i,:)/nnz(graph(i,:)) ;
  end
end


g2 = graph * graph;

graph = graph + g2;
graph = graph ./ 2;
end