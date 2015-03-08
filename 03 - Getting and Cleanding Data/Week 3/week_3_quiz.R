library(dplyr)

q1 <- function() {
  q1_local <- "q1.csv"
  #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", q1_local, "curl")
  df <- read.csv(q1_local)
  # ACR == 3 (3 .House on ten or more acres)
  # AGS == 6 (> 10000 USD)
  agricultureLogical <- df$ACR == 3 & df$AGS == 6
  print(which(agricultureLogical))
  
}

q2 <- function() {
  q2_local <- "q2_img.jpg"
  #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", q2_local, "curl", mode="wb")
  
  library(jpeg)
  img <- jpeg::readJPEG(q2_local, native=TRUE)
  print(quantile(img, probs=c(1:100)/100))
}

q3 <- function() {
  q3a_local <- "q3a.csv"
  #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", q3a_local, "curl")
  dq3.a <- read.csv(q3a_local, skip=4, stringsAsFactors=FALSE, nrows=190)  
  dq3.a$X.4 <- as.numeric(gsub(",", "", dq3.a$X.4), na.rm=TRUE)
  
  #print(dq3.a) # column "X"

  q3b_local <- "q3b.csv"
  #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", q3b_local, "curl") 
  dq3.b <- read.csv(q3b_local, header = TRUE, stringsAsFactors=FALSE)
  #print(str(dq3.b)) # column "CountryCode"
  commonCountries <- intersect(dq3.a$X, dq3.b$CountryCode)
  print(length(commonCountries))
  
  #print(head(arrange(dq3.a, X.4),15))
  
  # q4

  print(names(dq3.b),15)
  
  h_oecd <- filter(dq3.b, Income.Group=="High income: OECD") %>% select(CountryCode)
  h_non_oecd <- filter(dq3.b, Income.Group=="High income: nonOECD") %>% select(CountryCode)
  
  #print(h_non_oecd)
  #print(names(h_oecd))
  h_oecd <- as.vector(h_oecd$CountryCode)
  h_non_oecd <- as.vector(h_non_oecd$CountryCode)
  
  x1 <- match(dq3.a$X, h_oecd)
  #print(class(dq3.a$X))
  #print(class(h_oecd))
  
  countries_oecd <- which(x1 > 0)
  print(mean(countries_oecd)) # average ranking was requested

  x2 <- match(dq3.a$X, h_non_oecd)
  
  countries_non_oecd <- which(x2 > 0)
  print(mean(countries_non_oecd)) # average ranking was requested
  
  # q5
  
  d5 <- merge(dq3.a, dq3.b, by.x="X", by.y="CountryCode")
  #print(names(d5))
  library(Hmisc)
  q5_quant <- cut2(d5$X.4, g=5)
  print(summary(q5_quant))
  d5$quant <- q5_quant
  print(table(d5$X.4, d5$Income.Group))
}

#q1()
q2()
#q3()