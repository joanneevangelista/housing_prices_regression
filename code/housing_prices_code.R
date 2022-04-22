#load the data into the housing.data dataframe which is our train dataset and housing.data.prediction dataframe which is our test dataset
housing.data <- read.csv(file.choose(), header = TRUE, sep = ",", stringsAsFactors = TRUE)
housing.data.prediction <-read.csv(file.choose(), header = TRUE, sep = ",", stringsAsFactors = TRUE)

#Inspect the structure of data types in each dataframe
str(housing.data)
str(housing.data.prediction)

#Inspect the summary statistics in each dataframe
summary(housing.data)
summary(housing.data.prediction)

#Check for duplicates 
nrow(housing.data) - nrow(unique(housing.data))

#Inspect correlation. Can only do this for integer variables
library(dplyr)
correlations <- cor(housing.data[,c(2,4:5,18:21,35,37:39,44:53,55,57,60,62:63,67:72,76:78,81)], use = "pairwise")
correlations.updated <- apply(correlations,1,function(x) sum(x > 0.2 | x < -0.5) > 1)
correlations.plot <- correlations[correlations.updated, correlations.updated]

install.packages("corrplot")
library(corrplot)
corrplot(correlations.plot, method = "square")
cor(housing.data$YrSold, housing.data$SalePrice, method = "pearson", use = "complete.obs")
cor(housing.data$EnclosedPorch, housing.data$SalePrice, method = "pearson", use = "complete.obs")

#Inspect the distribution of SalesPrices. Based on the histogram, we can see that sales prices do not follow a normal distribution
#and are positively skewed. We will have to address this through a transformation. 
hist(housing.data$SalePrice, main = "Histogram for Sale Price", xlab = "Sale Price")

#Show distribution when we take the log of Sales Price
hist(log(housing.data$SalePrice), main = "Histogram for log Sale Price", xlab = "log Sale Price")

#Repeat transformation for other variables 
hist(housing.data.combined$LotArea, main = "Histogram for Lot Area", xlab = "Lot Area")
hist(log(housing.data.combined$LotArea), main = "Histogram for log Lot Area" , xlab = "log Lot Area")

hist(housing.data.combined$GrLivArea, main = "Histogram for GrLivArea", xlab = "GrLivArea")
hist(log(housing.data.combined$GrLivArea), main = "Histogram for log GrLivArea", xlab = "log GrLivArea")

hist(housing.data.combined$TotalBsmtSF, main = "Histogram for TotalBsmtSF", xlab = "TotalBsmtSF")
hist(log(housing.data.combined$TotalBsmtSF), main = "Histogram for log TotalBsmtSF", xlab = "log TotalBsmtSF")


#Check for outliers and remove them. 4 outliers in GrLivArea were removed 
hist(housing.data$GrLivArea, main = "Histogram for GrLivArea", xlab = "Above ground living area in sq.ft. (GrLivArea)")
summary(housing.data$GrLivArea)

housing.data <- housing.data[housing.data$GrLivArea <= 4000,]

#Combine the train and test datasets 
library(tidyverse)
housing.data.prediction$SalePrice <- rep(NA,1459)
housing.data.combined <- bind_rows(housing.data,housing.data.prediction)
summary(housing.data.combined)

#Identify if there are any missing values for housing.data.combined dataframe
sapply(housing.data.combined[,1:80], function(x) sum(is.na(x)))


#Based on the results we can see that we will need to replace the missing data
#MSZoning - categorical variable, we can replace with none
housing.data.combined$MSZoning <- as.character(housing.data.combined$MSZoning)
housing.data.combined$MSZoning[which(is.na(housing.data.combined$MSZoning))] <- "None"
housing.data.combined$MSZoning <- as.factor(housing.data.combined$MSZoning)
MSZoning.subset <- subset(housing.data.combined, select = -MSZoning)
table(housing.data.combined$MSZoning)

#LotFrontage - continuous variable
housing.data.combined$LotFrontage[which(is.na(housing.data.combined$LotFrontage))] <- median(housing.data.combined$LotFrontage, na.rm = T)
table(housing.data.combined$LotFrontage)

#Alley - change to none
housing.data.combined$Alley <- as.character(housing.data.combined$Alley)
housing.data.combined$Alley[which(is.na(housing.data.combined$Alley))] <- "None"
housing.data.combined$Alley <- as.factor(housing.data.combined$Alley)
Alley.subset <- subset(housing.data.combined, select = -Alley)
table(housing.data.combined$Alley)

#Exterior1st - change to none
housing.data.combined$Exterior1st <- as.character(housing.data.combined$Exterior1st)
housing.data.combined$Exterior1st[which(is.na(housing.data.combined$Exterior1st))] <- "None"
housing.data.combined$Exterior1st <- as.factor(housing.data.combined$Exterior1st)
Exterior1st.subset <- subset(housing.data.combined, select = -Exterior1st)
table(housing.data.combined$Exterior1st)

#Exterior2nd - change to none
housing.data.combined$Exterior2nd <- as.character(housing.data.combined$Exterior2nd)
housing.data.combined$Exterior2nd[which(is.na(housing.data.combined$Exterior2nd))] <- "None"
housing.data.combined$Exterior2nd <- as.factor(housing.data.combined$Exterior2nd)
Exterior2nd.subset <- subset(housing.data.combined, select = -Exterior2nd)
table(housing.data.combined$Exterior2nd)

#MasVnrType - change to none
housing.data.combined$MasVnrType <- as.character(housing.data.combined$MasVnrType)
housing.data.combined$MasVnrType[which(is.na(housing.data.combined$MasVnrType))] <- "None"
housing.data.combined$MasVnrType <- as.factor(housing.data.combined$MasVnrType)
MasVnrType.subset <- subset(housing.data.combined, select = -MasVnrType)
table(housing.data.combined$MasVnrType)

#MasVnrArea - integer variable so we should use mean
housing.data.combined$MasVnrArea[which(is.na(housing.data.combined$MasVnrArea))] <- mean(housing.data.combined$MasVnrArea, na.rm = T)

#BsmtQual - categorical varaiable, change to none
housing.data.combined$BsmtQual <- as.character(housing.data.combined$BsmtQual)
housing.data.combined$BsmtQual[which(is.na(housing.data.combined$BsmtQual))] <- "None"
housing.data.combined$BsmtQual <- as.factor(housing.data.combined$BsmtQual)
BsmtQual.subset <- subset(housing.data.combined, select = -BsmtQual)
table(housing.data.combined$BsmtQual)

#BsmtCond - categorical varaiable, change to none
housing.data.combined$BsmtCond <- as.character(housing.data.combined$BsmtCond)
housing.data.combined$BsmtCond[which(is.na(housing.data.combined$BsmtCond))] <- "None"
housing.data.combined$BsmtCond <- as.factor(housing.data.combined$BsmtCond)
BsmtCond.subset <- subset(housing.data.combined, select = -BsmtCond)
table(housing.data.combined$BsmtCond)

#BsmtExposure - categorical varaiable, change to none
housing.data.combined$BsmtExposure <- as.character(housing.data.combined$BsmtExposure)
housing.data.combined$BsmtExposure[which(is.na(housing.data.combined$BsmtExposure))] <- "None"
housing.data.combined$BsmtExposure <- as.factor(housing.data.combined$BsmtExposure)
BsmtExposure.subset <- subset(housing.data.combined, select = -BsmtExposure)
table(housing.data.combined$BsmtExposure)

#BsmtFinType1 - categorical varaiable, change to none
housing.data.combined$BsmtFinType1 <- as.character(housing.data.combined$BsmtFinType1)
housing.data.combined$BsmtFinType1[which(is.na(housing.data.combined$BsmtFinType1))] <- "None"
housing.data.combined$BsmtFinType1 <- as.factor(housing.data.combined$BsmtFinType1)
FinType1.subset <- subset(housing.data.combined, select = -BsmtFinType1)
table(housing.data.combined$BsmtFinType1)

#BsmtFinType2 - categorical varaiable, change to none
housing.data.combined$BsmtFinType2 <- as.character(housing.data.combined$BsmtFinType2)
housing.data.combined$BsmtFinType2[which(is.na(housing.data.combined$BsmtFinType2))] <- "None"
housing.data.combined$BsmtFinType2 <- as.factor(housing.data.combined$BsmtFinType2)
FinType2.subset <- subset(housing.data.combined, select = -BsmtFinType2)
table(housing.data.combined$BsmtFinType2)

#FireplaceQu - categorical varaiable, change to none
housing.data.combined$FireplaceQu <- as.character(housing.data.combined$FireplaceQu)
housing.data.combined$FireplaceQu[which(is.na(housing.data.combined$FireplaceQu))] <- "None"
housing.data.combined$FireplaceQu <- as.factor(housing.data.combined$FireplaceQu)
FireplaceQu.subset <- subset(housing.data.combined, select = -FireplaceQu)
table(housing.data.combined$FireplaceQu)

#GarageType - categorical varaiable, change to none
housing.data.combined$GarageType <- as.character(housing.data.combined$GarageType)
housing.data.combined$GarageType[which(is.na(housing.data.combined$GarageType))] <- "None"
housing.data.combined$GarageType <- as.factor(housing.data.combined$GarageType)
GarageType.subset <- subset(housing.data.combined, select = -GarageType)
table(housing.data.combined$GarageType)

#GarageYrBlt - this NAs are because there is no garage, can use o
housing.data.combined$GarageYrBlt[which(is.na(housing.data.combined$GarageYrBlt))] <- 0

#GarageAea - this NAs are because there is no garage, can use o
housing.data.combined$GarageArea[which(is.na(housing.data.combined$GarageArea))] <- 0

#GarageFinish - categorical varaiable, change to none
housing.data.combined$GarageFinish <- as.character(housing.data.combined$GarageFinish)
housing.data.combined$GarageFinish[which(is.na(housing.data.combined$GarageFinish))] <- "None"
housing.data.combined$GarageFinish <- as.factor(housing.data.combined$GarageFinish)
GarageFinish.subset <- subset(housing.data.combined, select = -GarageFinish)
table(housing.data.combined$GarageFinish)

#GarageQual - categorical varaiable, change to none
housing.data.combined$GarageQual <- as.character(housing.data.combined$GarageQual)
housing.data.combined$GarageQual[which(is.na(housing.data.combined$GarageQual))] <- "None"
housing.data.combined$GarageQual <- as.factor(housing.data.combined$GarageQual)
GarageQual.subset <- subset(housing.data.combined, select = -GarageQual)
table(housing.data.combined$GarageQual)

#GarageCond - categorical varaiable, change to none
housing.data.combined$GarageCond <- as.character(housing.data.combined$GarageCond)
housing.data.combined$GarageCond[which(is.na(housing.data.combined$GarageCond))] <- "None"
housing.data.combined$GarageCond <- as.factor(housing.data.combined$GarageCond)
GarageCond.subset <- subset(housing.data.combined, select = -GarageCond)
table(housing.data.combined$GarageCond)

#PoolQC - categorical varaiable, change to none
housing.data.combined$PoolQC <- as.character(housing.data.combined$PoolQC)
housing.data.combined$PoolQC[which(is.na(housing.data.combined$PoolQC))] <- "None"
housing.data.combined$PoolQC <- as.factor(housing.data.combined$PoolQC)
PoolQC.subset <- subset(housing.data.combined, select = -PoolQC)
table(housing.data.combined$PoolQC)

#Fence - categorical varaiable, change to none
housing.data.combined$Fence <- as.character(housing.data.combined$Fence)
housing.data.combined$Fence[which(is.na(housing.data.combined$Fence))] <- "None"
housing.data.combined$Fence <- as.factor(housing.data.combined$Fence)
Fence.subset <- subset(housing.data.combined, select = -Fence)
table(housing.data.combined$Fence)

#MiscFeature - categorical varaiable, change to none
housing.data.combined$MiscFeature <- as.character(housing.data.combined$MiscFeature)
housing.data.combined$MiscFeature[which(is.na(housing.data.combined$MiscFeature))] <- "None"
housing.data.combined$MiscFeature <- as.factor(housing.data.combined$MiscFeature)
MiscFeature.subset <- subset(housing.data.combined, select = -MiscFeature)
table(housing.data.combined$MiscFeature)

#KitchenQual - categorical varaiable, change to none
housing.data.combined$KitchenQual <- as.character(housing.data.combined$KitchenQual)
housing.data.combined$KitchenQual[which(is.na(housing.data.combined$KitchenQual))] <- "None"
housing.data.combined$KitchenQual <- as.factor(housing.data.combined$KitchenQual)
KitchenQual.subset <- subset(housing.data.combined, select = -KitchenQual)
table(housing.data.combined$KitchenQual)

#SalesType - categorical varaiable, change to none
housing.data.combined$SaleType <- as.character(housing.data.combined$SaleType)
housing.data.combined$SaleType[which(is.na(housing.data.combined$SaleType))] <- "None"
housing.data.combined$SaleType <- as.factor(housing.data.combined$SaleType)
SaleType.subset <- subset(housing.data.combined, select = -SaleType)
table(housing.data.combined$SaleType)

#Electrical - categorical varaiable, change to none
housing.data.combined$Electrical <- as.character(housing.data.combined$Electrical)
housing.data.combined$Electrical[which(is.na(housing.data.combined$Electrical))] <- "None"
housing.data.combined$Electrical <- as.factor(housing.data.combined$Electrical)
Electrical.subset <- subset(housing.data.combined, select = -Electrical)
table(housing.data.combined$Electrical)

#Utilities - categorical varaiable, change to none
housing.data.combined$Utilities <- as.character(housing.data.combined$Utilities)
housing.data.combined$Utilities[which(is.na(housing.data.combined$Utilities))] <- "None"
housing.data.combined$Utilities <- as.factor(housing.data.combined$Utilities)
Utilities.subset <- subset(housing.data.combined, select = -Utilities)
table(housing.data.combined$Utilities)

#BsmtFullBath - this NAs are because there is no full bath, can use o
housing.data.combined$BsmtFullBath[which(is.na(housing.data.combined$BsmtFullBath))] <- 0
table(housing.data.combined$BsmtFullBath)

#BsmtHalfBath - this NAs are because there is no half bath, can use o
housing.data.combined$BsmtHalfBath[which(is.na(housing.data.combined$BsmtHalfBath))] <- 0
table(housing.data.combined$BsmtHalfBath)

#BsmtFinSF1 - change NA to 0
housing.data.combined$BsmtFinSF1[which(is.na(housing.data.combined$BsmtFinSF1))] <- 0

#BsmtFinSF2 - change NA to 0
housing.data.combined$BsmtFinSF2[which(is.na(housing.data.combined$BsmtFinSF2))] <- 0

#TotalBsmtSF - change NA to 0
housing.data.combined$TotalBsmtSF[which(is.na(housing.data.combined$TotalBsmtSF))] <- 0

#GarageCars - change NA to 0
housing.data.combined$GarageCars[which(is.na(housing.data.combined$GarageCars))] <- 0

#BsmtUnfSF - change NA to 0
housing.data.combined$BsmtUnfSF[which(is.na(housing.data.combined$BsmtUnfSF))] <- 0

#Feature Engineering - we can create additional variables from our original variables
housing.data.combined$TotalSF <- housing.data.combined$TotalBsmtSF + housing.data.combined$X1stFlrSF + housing.data.combined$X2ndFlrSF
housing.data.combined$TotalPorchSF <- housing.data.combined$WoodDeckSF + housing.data.combined$OpenPorchSF + housing.data.combined$EnclosedPorch + housing.data.combined$X3SsnPorch + housing.data.combined$ScreenPorch
housing.data.combined$TotalBathroom <- housing.data.combined$BsmtFullBath + housing.data.combined$BsmtHalfBath + housing.data.combined$FullBath + housing.data.combined$HalfBath

#Feature Engineering - Summer months
housing.data.combined$MoSold_June <- ifelse(housing.data.combined$MoSold == 6, 1, 0)
housing.data.combined$MoSold_July <- ifelse(housing.data.combined$MoSold == 7, 1, 0)
housing.data.combined$MoSold_August <- ifelse(housing.data.combined$MoSold == 8, 1,0)
housing.data.combined$MoSold_Summer <- housing.data.combined$MoSold_June + housing.data.combined$MoSold_July + housing.data.combined$MoSold_August


#Feature Engineering - Neighborhood
housing.data.combined$Neighborhood_NRidge <- ifelse(housing.data.combined$Neighborhood == "NoRdige", 1, 0)
housing.data.combined$Neighborhood_NHeight <- ifelse(housing.data.combined$Neighborhood == "NridgHt", 1, 0)
housing.data.combined$Neighborhood_StoneBr <- ifelse(housing.data.combined$Neighborhood == "StoneBr", 1, 0)
housing.data.combined$Neighborhood_Expensive <- housing.data.combined$Neighborhood_NRidge + housing.data.combined$Neighborhood_NHeight + housing.data.combined$Neighborhood_StoneBr

#Feature Engineering - Sale Condition
housing.data.combined$SaleCondition_Normal <- ifelse(housing.data.combined$SaleCondition == "Normal", 1, 0)
housing.data.combined$SaleCondition_Partial <- ifelse(housing.data.combined$SaleCondition == "Partial", 1, 0)


#Feature Engineering - Sale Type
housing.data.combined$SaleType_New <- ifelse(housing.data.combined$SaleType == "New", 1, 0)

write.csv(housing.data.combined, "C:\\Users\\JO1\\OneDrive - Queen's University\\Desktop\\housingpricecombined3.csv")

#Feature Engineering - BldgType
housing.data.combined$BldgType_1Fam <- ifelse(housing.data.combined$BldgType == "1Fam", 1, 0)
housing.data.combined$BldgType_TwnhsE <- ifelse(housing.data.combined$BldgType == "TwnhsE", 1, 0)
housing.data.combined$BldgType_best <- housing.data.combined$BldgType_1Fam + housing.data.combined$BldgType_TwnhsE

#Convert numerical variables that should be categorical
str(housing.data.combined)

#MSSubClass is the building class - convert to categorical
housing.data.combined$MSSubClass <- as.factor(housing.data.combined$MSSubClass)
str(housing.data.combined$MSSubClass)

#OverallCond - convert into categorical
housing.data.combined$OverallCond <- as.factor(housing.data.combined$OverallCond)

#YrSold - convert into categorical
housing.data.combined$YrSold <- as.factor(housing.data.combined$YrSold)

#MoSold - convert into categorical
housing.data.combined$MoSold <- as.factor(housing.data.combined$MoSold)

#KitchenAbvGr - convert into categorical
housing.data.combined$KitchenAbvGr <- as.factor(housing.data.combined$KitchenAbvGr)

#MoSold_Summer - convert into factor
housing.data.combined$MoSold_Summer <- as.factor(housing.data.combined$MoSold_Summer)

#Neighborhood_Expensive - convert into factor
housing.data.combined$Neighborhood_Expensive <- as.factor(housing.data.combined$Neighborhood_Expensive)

#Sale_Condition_Normal - convert into factor
housing.data.combined$SaleCondition_Normal <- as.factor(housing.data.combined$SaleCondition_Normal)
housing.data.combined$SaleCondition_Partial <- as.factor(housing.data.combined$SaleCondition_Partial)

#Sale_Type_New - convert into factor
housing.data.combined$SaleType_New <- as.factor(housing.data.combined$SaleType_New)

#Bldg_Type_1Fam - convert into factor 
housing.data.combined$BldgType_1Fam <- as.factor(housing.data.combined$BldgType_1Fam)
housing.data.combined$BldgType_best <- as.factor(housing.data.combined$BldgType_best)

str(housing.data.combined)
summary(housing.data.combined)

#Fix error in Year Remodeled 
housing.data.combined$YearBuilt <- ifelse(housing.data.combined$YearBuilt > housing.data.combined$YearRemodAdd, housing.data.combined$YearRemodAdd, housing.data.combined$YearBuilt)

write.csv(housing.data.combined, "C:\\Users\\JO1\\OneDrive - Queen's University\\Desktop\\housingpricecombined4.csv")


#Create training, testing and predicting dataset
housing.data.training <- subset(housing.data.combined, (Id<=1000))
housing.data.testing <- subset(housing.data.combined, (Id>=1001 & Id<=1460))
housing.data.predicting <- subset(housing.data.combined, (Id>=1461))

#Set the seed so results reproduceable 
set.seed(205)

#Stepwise regression
fit.log.step <- step(lm(log(SalePrice) ~ log(LotArea) * Neighborhood +YrSold + log(GrLivArea) +
                          TotalBathroom + BedroomAbvGr + HouseStyle + OverallQual + OverallCond + YearBuilt +
                          YearRemodAdd + BsmtFinSF1 + BsmtFinSF2 + GarageCars + KitchenQual + Fireplaces + LotConfig + Utilities + ExterQual + 
                          ExterCond + TotalPorchSF + MoSold_Summer + SaleCondition_Normal + SaleType_New + BsmtQual + BsmtFinType1 + BsmtFinType2 + 
                          HeatingQC, housing.data.training), direction = "both")

plot(fit.log.step)

#Predict the Sales Price of the 508 houses left for testing the model
predicted.prices.fit.log.step <-exp(predict(fit.log.step, housing.data.testing))
percent.errors.log.step <- abs((housing.data.testing$SalePrice - predicted.prices.fit.log.step)/housing.data.testing$SalePrice) * 100
mean(percent.errors.log.step)

#Submission
prediction <- exp(predict(fit.log.step,housing.data.predicting))

#For final prices with NA, use mean
prediction[which(is.na(prediction))] <- median(prediction, na.rm = T)               
housing.data.predicting$SalePrice <- prediction
               
write.csv(housing.data.predicting, "C:\\Users\\JO1\\OneDrive - Queen's University\\Desktop\\housingprice39.csv")

#Regularizations
install.packages("glmnet")               
library(glmnet)
library(dplyr)

#create the y variable and matrix
set.seed(200)
y <- log(housing.data.training$SalePrice)
X <- model.matrix(Id~log(LotArea) * Neighborhood +YrSold + log(GrLivArea) +
                    TotalBathroom + BedroomAbvGr + HouseStyle + OverallQual + OverallCond + YearBuilt +
                    YearRemodAdd + BsmtFinSF1 + BsmtFinSF2 + GarageCars + KitchenQual + Fireplaces + LotConfig + Utilities + ExterQual + 
                    ExterCond + TotalPorchSF + MoSold_Summer + SaleCondition_Normal + SaleType_New + BsmtQual + BsmtFinType1 + BsmtFinType2 + 
                    HeatingQC, housing.data.combined)[,-1]
X <- cbind(housing.data.combined$Id,X)
write.csv(housing.data.combined, "C:\\Users\\JO1\\OneDrive - Queen's University\\Desktop\\housingpricecombined.csv")

#Split X into testing, training and prediction
X.training <- subset(X,X[,1]<=1000)
X.testing <- subset(X,(X[,1]>=1001 & X[,1]<=1460))
X.predicting <-subset(X,X[,1]>=1461)
dim(X.testing)

#LASSO
lasso.fit <- glmnet(x=X.training, y=y, alpha = 1)
plot(lasso.fit)

crossval <- cv.glmnet(x=X.training, y=y, alpha = 1)
plot(crossval)
penalty.lasso <- crossval$lambda.min
log(penalty.lasso)

plot(crossval, xlim=c(-7,-4), ylim=c(0.00, 0.05))
lasso.opt.fit <- glmnet(x=X.training, y=y, alpha = 1, lambda = penalty.lasso)
coef(lasso.opt.fit)

lasso.testing <- exp(predict(lasso.opt.fit, s = penalty.lasso, newx = X.testing))
mean(abs(lasso.testing - housing.data.testing$SalePrice)/housing.data.testing$SalePrice * 100)

#ForSubmission
lasso.predicting <- exp(predict(lasso.opt.fit, s = penalty.lasso, newx = X.predicting))

lasso.predicting[which(is.na(lasso.predicting))] <- mean(lasso.predicting, na.rm = T)
housing.data.predicting$SalePrice <- lasso.predicting
write.csv(housing.data.predicting, "C:\\Users\\JO1\\OneDrive - Queen's University\\Desktop\\housingprice47.csv")

str(housing.data.combined)

#Ridge
ridge.fit <- glmnet(x = X.training, y = y, alpha = 0)
plot(ridge.fit, xvar = "lambda")

#Selecting the best penalty lambda
crossval.ridge <- cv.glmnet(x = X.training, y = y, alpha = 0)
plot(crossval.ridge)
penalty.ridge <- crossval.ridge$lambda.min
log(penalty.ridge)
ridge.opt.fit <- glmnet(x=X.training, y = y, alpha = 0, lambda = penalty.ridge)
coef(ridge.opt.fit)

ridge.testing <- exp(predict(ridge.opt.fit, s = penalty.ridge, newx = X.testing))
mean(abs(ridge.testing - housing.data.testing$SalePrice)/housing.data.testing$SalePrice*100)

#ForSubmission
ridge.predicting <- exp(predict(ridge.opt.fit, s = penalty.ridge, newx = X.predicting))

ridge.predicting[which(is.na(ridge.predicting))] <- mean(ridge.predicting, na.rm = T)
housing.data.predicting$SalePrice <- ridge.predicting
write.csv(housing.data.predicting, "C:\\Users\\JO1\\OneDrive - Queen's University\\Desktop\\housingprice40.csv")
