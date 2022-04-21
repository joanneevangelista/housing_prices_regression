# housing_prices_regression

The data provided for the house prices competition consists of residential properties in Ames, Iowa which were sold between 2006 and 2010. The train dataset is relatively small with 1460 observations and 79 explanatory variables. The objective is to predict the final sale price of 1459 homes in the test dataset using creative feature engineering and advanced regression techniques. The dataset can be found on Kaggle using this link: https://www.kaggle.com/c/house-prices-advanced-regression-techniques

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

