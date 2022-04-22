# housing_prices_regression

**Key Findings: The most important features when predicting house prices are location, home size, useable space, age, condition/quality, upgrades, updates, and seasonablity.**

**Table of Contents**

•	Business Problem

•	Data Source

•	Why this Kaggle Competition

•	Exploratory Data Analysis

•	Data Preparation

•	Model Training & Selection

•	Quality of Predictions

**Business Problem**

The data provided for the house prices competition consists of residential properties in Ames, Iowa which were sold between 2006 and 2010. The train dataset contains 1460 observations and 79 explanatory variables. The objective is to predict the final sale price of 1459 homes in the test dataset using creative feature engineering and advanced regression techniques. 

**Data Source**

The dataset can be found on Kaggle using this link: https://www.kaggle.com/c/house-prices-advanced-regression-techniques

**Why I selected this Kaggle competition?**

I was interested in this competition because I would like to invest in the real estate market. To help me during the bidding process, I wanted to develop a model which could identify the most important factors influencing a house price and determine if properties were over or under valued. With this information, I could tailor my offers accordingly. 

**Exploratory Data Analysis**

_External research_ 

I conducted external research to gain an understanding of the factors that influence the value of a home so that I would intuitively understand the variables that could eventually be included in my model. Based on this research, some of the most important factors are as follows:

1) Location: this is a crucial factor because it is one of the only characteristics of a home that cannot be changed. 

2) Home size and useable space: larger square footage tends to correspond to a higher valuation. Furthermore, livable space is the most important factor to potential buyers and in particular, bedrooms and bathrooms are the most sought-after. 

3) Age and condition: homes that are newer are typically valued higher as there would be less renovations to get the house in a move-in-ready condition. 

4) Upgrades and updates: these features of a home impact the value, especially for older homes. 

5) Seasonality: in the real estate market, there tends to be a pattern in prices such that they are above-trend in the summer while there is a decline in activity during the winter months. This is important as seasonality will impact the supply and demand of houses for sale. 

_Structure and summary statistics_

To gain an understanding of the structure of the data, I used the str function to identify which variables were coded as integers and characters to verify if it made sense with the “Data_description” file for both the train and test datasets. 

For example, Overall Condition, Year Sold and Month Sold appear as integers, however I recoded them as categorical variables so as to not confuse the model if I wanted to create interactions or additional features. 

Using the summary function, I also analyzed the summary statistics to observe the mean, median and mode for the numerical variables and count for the categorical variables. This step also served as a quick way to see if there may be any outliers in the dataset, the amount of each category type that appeared most often and the number of NAs. I also captured this information as part of my visualizations. 

Through this step, I discovered there were outliers in the GrLivArea because the mean was 1,515 square feet but the maximum is 5,642 square feet. Additionally, I noted that several variables have NAs. These observations will be addressed as part of my data preparation. 

_Correlations_ 

To identify how the numerical variables were correlated with Sale Price, I created a correlation plot pictured below.

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Correlation.png)

As show in the plot, the 5 variables most positively correlated with Sales Price include Overall Quality of 0.79098, Above grade/ground living area (GrLivArea) of 0.7862, Garage Cars of 0.640409, Garage Area of 0.623431 and Total Basement square footage (TotalBsmtSF) of 0.613581. The 5 variables most negatively correlated with Sale Price are Year Sold of -0.02892, Overall Condition of -0.077856, MSSubClass of -0.084284, Enclosed Porch of -0.128578 and KitchenAbv of -0.135907. This information helped me select which variables I wanted to include in my model. 

_Data Visualizations_

To obtain a better understanding of the relationship of Sales Price as a function of each of the numerical variables, I created visualizations within Tableau and R. As an example, refer to the graph for Above grade/ground living area (GrLivArea) vs. Sales Price. Based on this visual it is evident that there are outliers in the dataset which we will have to deal with when creating a predictive model.  Visually, the other continuous variables (TotalbsmtSF and Garage Area) looked very similar. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Scatterplot.png)

Box and whisker plots were useful for variables such as Overall Quality, Neighborhood, Month Sold, Year Sold, Sale Condition, Sale Type and Building Type to see the dispersion of the dataset. I noted for houses with a higher rating, the sales price tends to be greater and there are a few outliers. Additionally, the Northridge, Northridge Heights and Stone Bridge neighborhoods have the highest sales prices and also a few outliers as well. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Box_1.PNG)

In the Months Sold visual, we can see that houses sold in the summer months (6,7 8) have a higher sales price which is consistent with the seasonality trend discussed earlier in the report.  In addition, I was interested in plotting Year Sold to see if the Great Recession impacted house prices. Based on the visualization of Sale prices vs. Year Sold, this does not appear to be the case as the spread of data 
did not change significantly over the years apart from a few outliers. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Box_2.PNG)

Based on the Sale Type visual, New houses have a higher sale price. In the Sale Condition chart, Normal and Partial correspond to a higher sale price. Additionally, the BldgType visual shows that the type of dwelling which corresponds to a higher sales price is single-family detached (1Fam). 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Box_3.PNG)

For the discrete variables such as Garage Cars, Full Bath and TotRmsAbvGrd, it is useful to see these relationships with Sales Price as well. As shown below, the houses with the highest prices have a 3-car garage, 3 full bathrooms and 10 total rooms above ground. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Scatterplot_2.PNG)

To understand the shape of Sale prices’ distribution, I created a histogram in R. The visualization provided below indicates that Sale Prices do not follow a normal distribution and are positively skewed. We will have to address this through a transformation using the log function. When we do this, we can see that that the distribution becomes more normal. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Historgram1.PNG)

With this insight, I applied similar transformations to the Lot Area and Above Ground Living Area (GrLivArea) variables. Again, we can see that a log transformation creates a more normal distribution. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Histogram_Lot_Area.PNG)

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Histogram_GrLiv_Area.PNG)

**Data Preparation**

_Duplicates and errors_

As part of my data preparation, I checked to see if there were any duplicates in the rows and none were identified. 

In addition, I also checked to see if there were any errors in the data. For example, in one observation (Id 1877), I noted that the year remodeled (YearRemodAdd) was 2001 but the year built (YearBuilt) was 2002. Logically, this does not make sense because in order for a house to be remodeled, it would first need to be built. Thus, for all instances in which year built is greater than year remodeled, I changed the year built to be the same as the year remodeled. 

_Transformations_

As demonstrated in my visualizations, transforming the Sale Price as well as the Lot Area and GrLivArea features with the log function made the distribution become more normal and also helped improve the performance of my model. 

_Outliers_

As evidenced in the summary statistics and Sale Price vs. GrLivArea graph, there are outliers that should be eliminated so as to not distort my analysis. Thus, I removed observations with GrLivArea greater than 4000. The result was an improvement in the performance of my model. 

_Missing Values_

In order to identify the number of missing values for each of the variables, I obtained a list of the sum of NAs for each x variable. Based on these results, I replaced the missing data with “None” if it is a categorical variable and the mean or median if the missing value belongs to a numerical variable. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Missing_Values.PNG)

For example, Lot Frontage has 486 missing values across the train and the test datasets. Thus, I have replaced those missing values with the median value of the Lot Frontage in the combined dataset. I repeated this step for other numerical variables such as MasVnrArea. For the missing values in Garage Year Built (GarageYrBlt), I replaced the NAs with 0. Since these observations did not have a garage, it makes sense that they do not have a Year Built. I applied the same rationale and process for NAs in BsmtFullBath, BsmtHalfBath, BsmtFinSF1, BsmtFinSF2, TotalBsmtSF, GarageCars and BsmtUnfSF. For the categorical variables such as MSZoning, Alley, Exterior1st, Exterior2nd, MasVnrType, BsmtQual, BsmtCond, Bsmtxposure, BsmtFinType1, BsmtFinType2, FireplaceQu, GarageType, GarageFinish, GarageQual, GarageCond, PoolQc, Fence, MiscFeature, KitchenQual, SalesType, Electrical, Utilities I performed a similar step, however I first had to convert them back into a character structure to replace the NA with “None”, then I changed it back into a factor. 

_Feature Engineering_

Using information already present in the data but not yet captured by the original variables, I engineered additional features to help improve the performance of my model as follows:

•	Total square footage (TotalSF): Based on my research; I knew that home size (i.e. square footage) was an important factor in the sale price. Thus, I created a feature to capture the total square footage of a home by adding total basement, first floor and second floor square footage. 

•	Total porch square footage (TotalPorchSF): To capture outdoor living square footage, I created an another feature by adding the deck, open porch, enclosed porch, three season porch and screen porch square footage. 

•	Total Bathroom (TotalBathroom): as bathrooms were one of the most sought-after qualities, I created another feature for total bathrooms by adding basement full bathrooms, basement half bathrooms, above ground full bathrooms and above ground half bathrooms. 

•	Summer months (MoSold_Summer): To capture the feature of seasonality, I created a new variable called “MoSold_Summer” whereby any observations that were sold in June, July, August (i.e. MoSold equal to 6,7,8) were categorized as 1 otherwise 0. 

•	Houses in expensive neighborhoods (Neighborhood_Expensive): because location is an important factor, I wanted to capture neighborhoods that typically have more expensive house prices. These include Northridge, Northridge Heights and Stone Bridge. In developing my model, I created a feature (Neighborhood_Expensive) to identify houses in these three neighborhoods as 1 and all others 0. Although this feature did not end up improving the accuracy of model, I did think that it was an interesting observation. 

•	New houses (SalesType_New): consistent with my external research, that data showed that new houses correspond to higher sale prices. Thus, I created a feature to capture this observation called SaleType_New. 

•	Normal Sale Condition (SaleCondition_Normal): the condition of houses when it is being sold is also an important factor. As per the Data Description, houses categorized as “Partial” refer to homes that were not completed when last assessed and are associated with new homes. As new homes are already captured in the SalesType_New feature, I engineered a new feature called SaleCondition_Normal to only capture the houses categorized as normal.

•	Single family homes (BldgType_1Fam):  From my own house-hunting experience, single family homes are typically more expensive than townhouses so I created a feature to capture this observation. However, it did not end up improving performance so ultimately I removed it from my model. 

_Interactions_

I created an interaction feature between log Lot Area and Neighborhood to capture the simultaneous influence of two variables that is not additive. It is a bit difficult to see with all of the neighborhoods in Chart 1. However, when I filtered for the most expensive neighborhoods (Northridge, Northridge Heights and Stonebridge) in Chart 2, the relationship becomes more clear. We can see that the sales price increases faster for “more expensive” neighborhoods. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Log_Lot_Area.PNG)

**Model Training and Selection**

_Cross-fold Validation_

To assess how well my model will generalize on data it has not been exposed to before, I created two subsets from the train dataset: one for training the model and another for testing the model. By creating a model using the training subset, I was able to measure how well it predicts the sale prices in the testing subset. The purpose is to ensure my model was not overfitted. To assess the performance, I used the Mean Absolute Percentage Error (MAPE) and adjusted my model to achieve lower and lower MAPEs. 

_Variable Selection_

To determine which variables should be included in my model, I considered stepwise variable section and regularizations such as Lasso and Ridge. 
Under each method, I calculated the MAPE using my final regression model with the following results: 8.413714 with stepwise, 8.313277 with Lasso regression and 8.351858 with Ridge regression. Because the model with Lasso regression had the lowest MAPE, I used this model to predict the house prices that I submitted on Kaggle.

Based on external research, the insights from my exploratory data analysis and data preparation, I knew I wanted to include the following variables as a starting point: log(LotArea), Neighborhood, log(GrLivArea), Total Bathroom, BedroomAbvGr, OverallQual, OverallCond, YearBuilt, YearRemodAdd, BsmtFinSF1, BsmtSF2, GarageCars, KichenQual, ExterQual, ExterCond, TotalPorchSF, MoSold_Summer, Sale Condition_Normal, SaleType_new, BsmtQual, BsmtFinType1, BsmtFinType2, and HeatingQC. These features made sense to me because they captured location, home size, useable space, age, condition/quality, upgrades, updates and seasonality.

One interesting observation I noted was in regards to basement square footage. I started with just adding BsmtFinSF1 and BsmtFinSF2 into the model, but I also wanted to see if the performance would improve if I just used TotalBsmtSF. Based on the MAPEs, I discovered that it was better to keep BsmtFinSF1 and BsmtFinSF2 instead of TotalBsmtSF to capture basement square footage. A potential explanation for this observation is that TotalBsmtSF includes unfinished square feet of basement area whereas the other two features are finished square feet. This makes sense to me because based on my research, it is useable space that increases the value of the home and buyers cannot do much with unfinished area. 

Then I thought to myself, “what would I like in a home and what information can I leverage from my own house hunting journey?” So I added the following features:

•	Utilities: this would be important for me as a homebuyer because I would not want to have to install utilities such as a waterline after purchasing a house.

•	LogConfig: from prior house searching experience, I knew corner lots and cul-de-sacs typically cost more so I wanted to capture this variable. 

•	BldgType: the type of dwelling would impact the sale price as typically single-family detached homes cost the most and recently I have seen that townhomes have appreciated at a greater rate, thus I included this variable. 

•	HouseStyle: intuitively, the number of stories and whether or not the area was finished should impact the sales price. 

•	Fireplaces: since it can get quite cold in Iowa during the winter months, I included this variable in the model because this is one feature I looked for to endure the Canadian winters.  

•	YearSold: as there is seasonality in the months that a house was sold, I believed there could be ebbs and flows to the housing market over the years as well.

_Quality of Predictions_

Overall, I believe my predictions were of good quality. When developing my model, I considered variables that logically made sense to me and the inclusion of those features were supported by external research, leveraging my own house hunting experience and capturing the insights gained from exploratory data analysis. Using cross-fold validation and Lasso regression, I created a model from the train subset, ran it on the test subset and achieved a MAPE of approximately 8.31. This means that the average difference between the forecasted value and the actual value is 8.31%. While there is no threshold to determine how good of a MAPE this is, the model I created achieved a score of 0.12781 on the House Prices Kaggle competition. Although I was evaluated based on root-mean-squared-error (RMSE), I chose to use MAPE to determine prediction quality when developing my model. This is because MAPE has a more intuitive interpretation and both are acceptable metrics. 

**Resources for External Research**

Gomez, J. (2019a, March 19). 8 critical factors that influence a home’s value. Opendoor. https://www.opendoor.com/w/blog/factors-that-influence-home-value

Seasonality in the Housing Market. (2019, January 2). www.Nar.Realtor. https://www.nar.realtor/blogs/economists-outlook/seasonality-in-the-housing-market#:%7E:text=Every%20year%2C%20transactions%20and%20prices,the%20housing%20demand%20and%20supply.

