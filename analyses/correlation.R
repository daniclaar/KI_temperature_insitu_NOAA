load("data")


corr <- ccf(sst_region$sst_BOW,sst_region$sst_vaskess)

#https://anomaly.io/detect-correlation-time-series/
correlationTable = function(graphs) {
  cross = matrix(nrow = length(graphs), ncol = length(graphs))
  for(graph1Id in 1:length(graphs)){
    graph1 = graphs[[graph1Id]]
    print(graph1Id)
    for(graph2Id in 1:length(graphs)) {
      graph2 = graphs[[graph2Id]]
      if(graph1Id == graph2Id){
        break;
      } else {
        correlation = ccf(graph1, graph2, lag.max = 0)
        cross[graph1Id, graph2Id] = correlation$acf[1]
      }
    }
  }
  cross
}

graphs <- sst_region[,c(2:6)]
corr = correlationTable(graphs)

corr[2,1]
corr
