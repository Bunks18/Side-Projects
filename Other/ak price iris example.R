
rm(iris)
yy <- ApplyGroupedBins(iris,5,4)
AK<-read.csv("Ak.csv")
xx<-ApplyGroupedBins(AK,4,18)
xx
str(AK)
iris<-AK
names(AK)
plot(AK)
iris
x <- maml.mapInputPort(1)
o <- ApplyGroupedBins(x, 4, 18)
maml.mapOutputPort("o")
yy

InferBins <- function(col, probabilities = c(0,.1,.25,.5,.75,1))
{
  return(quantile(col, probs = probabilities))
}

ApplyBins <- function(col, pbounds = c(0,.1,.25,.5,.75,1), labels = c(0,1,2,3,4,5))
{
  if (length(pbounds) != length(labels))
  {
    stop("bounds and labels must have same length")
  }
  
  bins <- InferBins(col, pbounds)
  nbins <- length(bins)
  if (nbins < 2)
  {
    return(col)
  }
  
  b <- AddQuantizationBucket(NA, bins[1], labels[1])
  for (i in 2:nbins)
  {
    b <- AddQuantizationBucket(bins[i-1], bins[i], labels[i], b)
  }
  b <- AddQuantizationBucket(NA, NA, NA, b);
  
  out <- ApplyQuantizeRule(col, b)
  return(out)
}

ApplyGroupedBins <- function(data, igcol, icol, pbounds = c(0,.1,.25,.5,.75,1), labels = c(0,1,2,3,4,5))
{
  l <- levels(data[,igcol])
  nlevel <- length(l)
  
  out <- data[order(data[,igcol]),]
  binned <- NULL
  for (i in 1:nlevel)
  {
    binned <- c(binned, ApplyBins(out[out[,igcol]==l[i],icol], pbounds, labels))
  }
  return(cbind(out, binned))
}

AddQuantizationBucket <- function(low, high, label, buckets = NULL)
{
  if (!is.null(buckets) &&
        ((class(buckets) != "data.frame") ||
           (ncol(buckets) != 3) ||
           (!is.na(low) && !is.na(high) && low > high)))
  {
    stop("incorrect parameters passed to AddQuantBucket");
  }
  return(rbind(buckets, data.frame(low, high, label, stringsAsFactors = FALSE)));
}

CheckRules <- function(value, buckets)
{
  # if (class(value) != class(buckets$low))
  #           stop("Bad value/bucket bound type match");
  
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