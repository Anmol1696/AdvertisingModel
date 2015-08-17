testset <- function(add){
  t1 <- sort(sample(1:200, 50))
  t2 <- setdiff(1:200, t1)
  model_data <- add[-c(t1), ]
  test_data <- add[-c(t2), ]
  return (list(model_data, test_data))
}

minpvalue <- function(lm.all){
  pvalue = c()
  
  for (x in 1:dim(summary(lm.all)$coefficients)[1]){
    pvalue <- c(pvalue, summary(lm.all)$coefficients[x, 4])
  }
  if (max(pvalue) > 0.05){
    return(which(pvalue %in% max(pvalue)) - 1)
  }
  else{
    return(0)
  }
}

main <- function(test, glm.all){

  #glm.all <- glm(y ~ (x1 + x2 + x3)^2 + x1:x2:x3, family = 'gaussian')
  while (minpvalue(glm.all) != 0){
    names.glm <- attr(glm.all$terms, 'term.labels')[minpvalue(glm.all)]
    f <- paste('. ~ . -', names.glm, sep = "")
    glm.all = update(glm.all, as.formula(f))
    #summary(lm.all)
  }
  #print(test[4])
  return(list(glm.all, mean((predict(glm.all, test) - test[4])^2)))
}

add <- read.csv("/home/anmol1696/Documents/Documents/Languages/R/Addvertising_model/Advertising.csv", header = T, sep = ",")
qal <- 1:8
for (num in 1:100){
    data <- testset(add)
    x1 = data[[1]][2][[1]]
    x2 = data[[1]][3][[1]]
    x3 = data[[1]][4][[1]]
    y = data[[1]][5][[1]]
    
    glm.list <- list(glm(y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2), family = 'gaussian'), 
                     glm(y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2), family = 'poisson'),
                     glm(y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2) + (I(x1^3) + I(x2^3) + I(x3^3))^2 + I(x1^3):I(x2^3):I(x3^3), family = 'gaussian'),
                     glm(y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2) + (I(x1^3) + I(x2^3) + I(x3^3))^2 + I(x1^3):I(x2^3):I(x3^3), family = 'poisson'),
                     glm(y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2) + (I(x1^3) + I(x2^3) + I(x3^3))^2 + I(x1^3):I(x2^3):I(x3^3) + (I(x1^4) + I(x2^4) + I(x3^4))^2 + I(x1^4):I(x2^4):I(x3^4), family = 'poisson'),
                     glm(y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2) + (I(x1^3) + I(x2^3) + I(x3^3))^2 + I(x1^3):I(x2^3):I(x3^3) + (I(x1^4) + I(x2^4) + I(x3^4))^2 + I(x1^4):I(x2^4):I(x3^4), family = 'gaussian'),
                     glm(y ~ (x1 + x2 + x3)^2, family = 'gaussian'),
                     glm(y ~ (x1 + x2 + x3)^2, family = 'poisson')
    )
    for (glm.x in 1:8){
      glm.all <- glm.list[[glm.x]]
      result <- main(data[[2]], glm.all)
      model <- result[[1]]$call
      qal[glm.x] <- mean(c(qal[glm.x], result[[2]]))
    }
    #print(model)
    #print(mean(qal))
}