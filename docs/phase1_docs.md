# Advertising_model
Linear Regression Model for given Advertising Data in R

##Regression Model
The linear regression model that we used is
> y ~ x1 + x3 + I(x1^2) + I(x2^2) + x1:x2 + x1:x3 + I(x1^2):I(x2^2) + I(x1^2):I(x2^2):I(x3^2))


##About The Model
* **Some Results** 
    
      ![](https://github.com/Anmol1696/Addvertising_model/blob/master/images/coeficients.png)
        
       The above is the result of for all the coefficients of the variables in the model
        
        Some other results are
    > **Residual standard error**: 0.6123 on 191 degrees of freedom*
    
    >**Multiple R-squared**:  0.9868,	
   
     >**Adjusted R-squared**:  0.9862
    
    >**F-statistic:**  1782 on 8 and 191 DF
    
    >**p-value**: < 2.2e-16

* **Steps used**

    It is important to know that the p-value has to be less than 0.05 for the variable to be significant

    For this case we used Backward selection also known as elimination method. 
    
    In this method we create a model with all possible variables and there combinations. For our case we used
    > y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2))
    
    From here we start to eliminate the one with the smallest p-value one at a time if the p-value is less than 0.05. Then we repeat the process until very coefficient has p-value more than 0.05.
    
    Now since the Adjusted R is very close close to 1 hence it is a valid model
    
* **Plots**
    
    There are plots that help visualize the model better

    ![](https://github.com/Anmol1696/Addvertising_model/blob/master/images/Residuals_Fitted.png) ![](https://github.com/Anmol1696/Addvertising_model/blob/master/images/normal_q-q.png)
    
    ![](https://github.com/Anmol1696/Addvertising_model/blob/master/images/scale-location.png) ![](https://github.com/Anmol1696/Addvertising_model/blob/master/images/residual_leverage.png) 