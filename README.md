# Advertising_model Phase2
Linear Regression Model for given Advertising Data in R

##Regression Model
The linear regression model that we used is
> y ~ x1 + x3 + I(x1^2) + I(x2^2) + x1:x2 + x1:x3 + I(x1^2):I(x2^2) + I(x1^2):I(x2^2):I(x3^2))

The Model is still same for now
##About The Model
* **Some Results** 
    
      ![](https://github.com/Anmol1696/AdvertisingModel/blob/master/images/coeficients.png)
        
       The above is the result of for all the coefficients of the variables in the model
        
        Some other results are
    > **Residual standard error**: 0.6123 on 191 degrees of freedom*
    
    >**Multiple R-squared**:  0.9868,	
   
     >**Adjusted R-squared**:  0.9862
    
    >**F-statistic:**  1782 on 8 and 191 DF
    
    >**p-value**: < 2.2e-16

* **Steps used**

    * **Phase 1**

        It is important to know that the p-value has to be less than 0.05 for the variable to be significant
            
        For this case we used Backward selection also known as elimination method. 
                
        In this method we create a model with all possible variables and there combinations. For our case we used
                
        > y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2))
                
        From here we start to eliminate the one with the smallest p-value one at a time if the p-value is less than 0.05. Then we repeat the process until very coefficient has p-value more than 0.05.
                
        Now since the Adjusted R is very close close to 1 hence it is a valid model

    * **Phase 2**
    
        In this version we do all the steps of phase one to find a best suited model from the selection on the basis of p-values    
        Also in this version we will be using *glm* instead of *lm* to incorporate Poisson distributions as well
                
        Before that we segregate the data into two halves, one of 25% and 75% data (random selection).
                From one set we find out the linear regression model and from the other we find the *Mean Squared Error*
               
        Just to be certain we make find the MES from 200 different(random) sets of the same data and we take the mean out of that.
        This step is required because the given data set is small.
                
        The model with the lowest MSE mean is chosen.
        Although this answer is different for every time you run the program but if two models differ very much than we can choose one over the other.
                
        For example:
                
        > model1 => glm(formula = y ~ x1 + x3 + I(x1^2) + I(x2^2) + x1:x2 + x1:x3 + I(x1^2):I(x2^2) + I(x1^2):I(x2^2):I(x3^2), family = "gaussian")
                
        > model2 => glm(formula = y ~ x1 + x2 + I(x1^2) + x1:x2, family = "poisson")
                
        Now both models were a result of the Phase 1. The MSE mean for model1 is 606.9 and that of model2 is 1007.8.
       
        Clearly model1 would be chosen over model2.
        Had it been something like 746 than we would not be able to predict on this basis.   
                
    
    
* **Plots**
    
    There are plots that help visualize the model better

    ![](https://github.com/Anmol1696/AdvertisingModel/blob/master/images/Residuals_Fitted.png) ![](https://github.com/Anmol1696/AdvertisingModel/blob/master/images/normal_q-q.png)
    
    ![](https://github.com/Anmol1696/AdvertisingModel/blob/master/images/scale-location.png) ![](https://github.com/Anmol1696/AdvertisingModel/blob/master/images/residual_leverage.png) 
