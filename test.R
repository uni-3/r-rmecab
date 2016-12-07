library(RMeCab)
library(tidyr)
library(dplyr)
library(igraph)

rm(list=ls())
# dataframe...
text <- read.csv("data/20160331.csv"
                , row.names=NULL
                , header=T, stringsAsFactors=F
                , na.strings=c("NULL"), encoding="UTF-8-BOM")

#names(text) <- c()
sapply(text, class)

#RMeCabに渡せる文字列にする
text$title[text$title == ""] <- " "
text$title[210:218]

#" "は削除する
text <- subset(text, title != " ")


text_10 <- text[1:10, ]

df <- data.frame()
for (f in seq(text_10)) {
  tc <- unlist(RMeCabC(text_10[f, ]$title))
  for (i in 1:length(tc)) {
    names <- names(tc)
    df_bind <- cbind(text_10[f, ], pos=tc[i], value=names[i])
    df <- rbind(df, df_bind)
  }
}

result1 <- docDF(text_10, "title", type=1)

#tf idf norm
ddf <- docDF(text_10, "title"
             , weight = "tf*idf*norm", type=1)

#ngram
ngram2 <- docDF(text_10, "title"
                , N=2, type=1, nDF=TRUE)
#出現頻度
ngram2$freq <- apply(ngram2[,5:length(ngram2)], 1, sum)
