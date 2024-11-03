library(SummarizedExperiment)

human_cachexia <- read.csv("human_cachexia.csv", row.names = 1)
str(human_cachexia)
human_cachexia$Muscle.loss <- as.factor(human_cachexia$Muscle.loss)


counts <- as.matrix(human_cachexia[, -1])
counts <- t(counts)
colData <- DataFrame(Muscle.loss = human_cachexia$Muscle.loss)

se <- SummarizedExperiment(assays=list(counts=counts), colData=colData)
se

assay(se)

se[, se$Muscle.loss == "control"]
se[, se$Muscle.loss == "cachexic"]

dimnames(se)
colData(se)
assay(se)
