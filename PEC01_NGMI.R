library(SummarizedExperiment)

human_cachexia <- read.csv("human_cachexia.csv", row.names = 1)
str(human_cachexia)
human_cachexia$Muscle.loss <- as.factor(human_cachexia$Muscle.loss)


counts <- as.matrix(human_cachexia[, -1])
counts <- t(counts)
colData <- DataFrame(Muscle.loss = human_cachexia$Muscle.loss)

metadata <- list(
  general_information = "Successfully passed sanity check!",
  samples = "Samples are not paired.",
  groups = "2 groups were detected in samples.",
  data_values = "All data values are numeric.",
  missing_values = "A total of 0 (0%) missing values were detected."
)

se <- SummarizedExperiment(assays=list(counts=counts), colData=colData,
                           metadata = metadata)
se

assay(se)

se[, se$Muscle.loss == "control"]
se[, se$Muscle.loss == "cachexic"]

dimnames(se)
colData(se)
assay(se)

pca <- prcomp(human_cachexia[, -1])
sum_pca <- summary(pca)
sum_pca
plot(pca)

install.packages("ggplot2")
install.packages("factoextra")

library(ggplot2)
library(factoextra)
fviz_eig(pca)


plot(pca$x[,2:3], col=ifelse(human_cachexia$Muscle.loss == "control", "lightblue3", "coral2"),
     pch =16,
     xlab="PC1", ylab="PC2")
legend("bottomleft", pch=16, col=c("lightblue3", "coral2"),
       cex=0.8, legend = c("control", "cachexin"))
title(main="PCA", line=1)

fviz_contrib(pca, choice = "var")

fviz_pca_var(pca,
             col.var = "contrib",
             gradient.cols=c("#00AFBB", "#E7B800", "#FC4E07"),
             repel =TRUE)
