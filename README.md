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

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Scatterplot.png)

Box and whisker plots were useful for variables such as Overall Quality, Neighborhood, Month Sold, Year Sold, Sale Condition, Sale Type and Building Type to see the dispersion of the dataset. I noted for houses with a higher rating, the sales price tends to be greater and there are a few outliers. Additionally, the Northridge, Northridge Heights and Stone Bridge neighborhoods have the highest sales prices and also a few outliers as well. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Box1.PNG)

In the Months Sold visual, we can see that houses sold in the summer months (6,7 8) have a higher sales price which is consistent with the seasonality trend discussed earlier in the report.  In addition, I was interested in plotting Year Sold to see if the Great Recession impacted house prices. Based on the visualization of Sale prices vs. Year Sold, this does not appear to be the case as the spread of data 
did not change significantly over the years apart from a few outliers. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Box2.PNG)

Based on the Sale Type visual, New houses have a higher sale price. In the Sale Condition chart, Normal and Partial correspond to a higher sale price. Additionally, the BldgType visual shows that the type of dwelling which corresponds to a higher sales price is single-family detached (1Fam). 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Box3.PNG)

For the discrete variables such as Garage Cars, Full Bath and TotRmsAbvGrd, it is useful to see these relationships with Sales Price as well. As shown below, the houses with the highest prices have a 3-car garage, 3 full bathrooms and 10 total rooms above ground. 

![](https://github.com/joanneevangelista/housing_prices_regression/blob/main/Images/Sales_Price_Scatterplot2.PNG)

To understand the shape of Sale prices’ distribution, I created a histogram in R. The visualization provided below indicates that Sale Prices do not follow a normal distribution and are positively skewed. We will have to address this through a transformation using the log function. When we do this, we can see that that the distribution becomes more normal. 

![](
