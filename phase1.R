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

main <- function(){
  add <- read.csv("/home/anmol1696/Documents/Documents/Languages/R/Addvertising_model/Advertising.csv", header = T, sep = ",")
  x1 = add[2][[1]]
  x2 = add[3][[1]]
  x3 = add[4][[1]]
  y = add[5][[1]]
  
  lm.all <- lm(y ~ (x1 + x2 + x3)^2 + (I(x1^2) + I(x2^2) + I(x3^2))^2 + x1:x2:x3 + I(x1^2):I(x2^2):I(x3^2))
  
  while (minpvalue(lm.all) != 0){
    names.lm <- attr(lm.all$terms, 'term.labels')[minpvalue(lm.all)]
    f <- paste('. ~ . -', names.lm, sep = "")
    lm.all = update(lm.all, as.formula(f))
    #summary(lm.all)
  }
  return(lm.all)
}

summary(main())