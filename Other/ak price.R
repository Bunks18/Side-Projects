AK<-read.csv("AK.csv")
names(AK)

#mutate
mutate(AK,categoryB=)

names(AK)
summary(AK$price)
## run quartiles
quantile(AK$price, probs=c(0,.1,.25,.5,.75,1))

#group by

bins <- function(col, probabilities = c(0,.1,.25,.5,.75,1))
{
  return(quantile(col, probs = probabilities))
}

AddQuantizationBucket <- function(low, high, label, buckets = NULL)
{
  if (!is.null(buckets) &&
        ((class(buckets) != "data.frame") ||
           (ncol(buckets) != 3) ||
           (!is.na(low) && !is.na(high) && low > high) ||
           (mode(label) != mode(buckets$label))))
  {
    stop("incorrect parameters passed to AddQuantBucket");
  }
  return(rbind(buckets, data.frame(low, high, label, stringsAsFactors = FALSE)));
}

CheckRules <- function(value, buckets)
{
  # if (class(value) != class(buckets$low))
  #             stop("Bad value/bucket bound type match");
  
  for(i in 1:length(buckets$low))
  {
    l <- buckets$low[i];
    h <- buckets$high[i];
    if (is.na(l) && is.na(h))
      next;
    if ((is.na(l) && value < h) ||
          (is.na(h) && value >= l) ||
          (value >= l && value < h))
      return(buckets$label[i]);
  }
  condition <- buckets$low == buckets$high;
  equal <- buckets$low[!is.na(condition)];
  eqlab <- buckets$label[!is.na(condition)];
  for (i in 1:length(equal))
  {
    if (value == equal[i])
      return(eqlab[i]);
  }
  return(buckets$label[is.na(buckets$low) & is.na(buckets$high)]);
}

ApplyQuantizeRule <- function(data, buckets)
{
  if (class(buckets) != "data.frame")
  {
    stop("buckets and data must be data.frame")
  }
  
  transformed <- vector(mode = mode(buckets$label), length = length(data))
  for (i in 1:length(data))
  {
    transformed[i] = CheckRules(data[i], buckets);
  }
  return(transformed);
}

TestQuantization <- function()
{
  print("Month Difference Rule Engine");
  b <- AddQuantizationBucket(NA, 1, 5);
  b <- AddQuantizationBucket(1, 1, 4, b);
  b <- AddQuantizationBucket(NA, NA, 0, b);
  testdata <- c(-2, -1, 0, 1, 2, 3);
  out <- ApplyQuantizeRule(testdata, b);
  str(out);
  
  print("Frequency of Purchase Rule Engine");
  b <- NULL;
  b <- AddQuantizationBucket(6, NA, 5, b);
  b <- AddQuantizationBucket(5, 6, 4.5, b);
  b <- AddQuantizationBucket(4, 5, 4, b);
  b <- AddQuantizationBucket(3, 4, 3.5, b);
  b <- AddQuantizationBucket(2, 3, 3, b);
  b <- AddQuantizationBucket(1, 2, 2, b);
  b <- AddQuantizationBucket(NA, NA, 0, b);
  testdata <- c(0, .5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5);
  out <- ApplyQuantizeRule(testdata, b);
  str(out);
}
