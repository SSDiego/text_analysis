library(readxl)
library(stringdist)
library(dplyr)


# conjunto 1
meu_data <- as.data.frame(trigrams_united[1:30,])
colnames(meu_data)[1] <- "Keyword_x"


# 2 Cluster

meu_data <- trigrams_united
colnames(meu_data)[1] <- "Keyword_x"

# conjunto 2

meu_data <- as.data.frame(nt_words[80:100, ])
colnames(meu_data)[1] <- "Keyword_x"

#1
kclusters1 = round(0.050 * length(unique(meu_data$Keyword_x)))
uniqueThema <- unique(as.character(meu_data$Keyword_x))
distancemodels <- stringdistmatrix(uniqueThema,uniqueThema,method = "jw")

# Cluster
kclusters1 = round(0.008 * length(unique(meu_data$Keyword_x)))
uniqueThema <- unique(as.character(meu_data$Keyword_x))
distancemodels <- stringdistmatrix(uniqueThema,uniqueThema,method = "jw")


#2
rownames(distancemodels) <- uniqueThema
hc <- hclust(as.dist(distancemodels))
par(mar = rep(2, 4)) 
plot(hc)


#3
dfClust1 <- data.frame(uniqueThema, cutree(hc, k=kclusters1))


names(dfClust1) <- c('Thema','cluster')
plot(table(dfClust1$cluster))

View(dfClust1)

dg <- dfClust1 |> group_by(cluster)

group_split(dg)






