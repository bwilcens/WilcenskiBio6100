# Bryan Wilcenski
# Machine Learning



# For reproducible results
set.seed(1)

# Packages used today
library(ggplot2)
library(psych)        # Bartlett's test
library(randomForest) # Random forest

# Data
data(iris)


iris_num <- iris[, 1:4]
iris_species <- iris$Species

round(cor(iris_num), 2)

bart <- cortest.bartlett(cor(iris_num), n = nrow(iris_num))
bart

# Fit PCA
pca <- prcomp(iris_num, center = TRUE, scale. = TRUE)
summary(pca) # gives proportion of variance ethat is prescribed by each PC

# calc eigenvalues

eig <- pca$sdev^2
pve <- eig / sum(eig)

pca_var_table <- data.frame(
  PC = paste0("PC", 1:length(eig)),
  Eigenvalue = round(eig, 3),
  PVE = round(pve, 3),
  CumPVE = round(cumsum(pve), 3)
)

pca_var_table

# Scree plot 

plot(eig, type = "b", pch = 19,
     xlab = "Principal component",
     ylab = "Eigenvalue",
     main = "Scree plot (iris PCA)")


# test to determine which PCs should be taken
# broken stick test

broken_stick <- function(p) sapply(1:p, function(k) sum(1/(k:p)) / p)
bs <- broken_stick(ncol(iris_num))

retain <- data.frame(
  PC = paste0("PC", 1:length(pve)),
  ObservedPVE = round(pve, 3),
  BrokenStick = round(bs, 3),
  Keep = pve > bs
)
retain # recommends that we keep PC1 but that's it

head(pca$x)
pca$rotation

# make plot 
scores <- as.data.frame(pca$x)
scores$Species <- iris_species

plt <- ggplot(scores, aes(PC1, PC2, color = Species)) +
  geom_point(size = 2.6, alpha = 0.85) +
  theme_minimal() +
  labs(title = "PCA on iris", subtitle = "PCA is unsupervised; species used only for coloring")

plt + stat_ellipse() # 95% CI


man <- manova(cbind(PC1, PC2) ~ Species, data = scores)
summary(man, test = "Pillai")

# to determine which vars are important (high loadings) we need to pull out the PCs and analyze them 

######################## RANDOM FOREST ###########################

set.seed(42)

id_train <- sample(seq_len(nrow(iris)), size = 0.7 * nrow(iris))
train <- iris[id_train, ]
test  <- iris[-id_train, ]
nrow(test)
nrow(train)


#random forest func
set.seed(123)
rf <- randomForest(
  Species ~ ., data = train,
  ntree = 500,
  mtry = 2,
  importance = TRUE
)
rf
# OOB error 
#confusion matrix (whether the algorithm got group classification correct)

#evaluate test data
pred <- predict(rf, newdata = test)
conf <- table(Observed = test$Species, Predicted = pred)
conf

# percent accuracy based on the test data

acc <- mean(pred == test$Species)
acc

# oob plot
plot(rf, main = "Random forest OOB error vs number of trees")
# black line is the most important

# predictor importance
importance(rf) # another table that helps 
#mean decreas accuracy : how well each var contributed to prediction power 
# gini : how much it ccontributed to the separation of each class 
  # bigger number is better for both

varImpPlot(rf) # further to the right is most important 

