## Download the datasets, unzip into parent directory
if (file.exists("./Coursera-SwiftKey.zip")==FALSE)
{
  #setwd(wd_path)
  download.file("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip", 
                destfile = "Coursera-SwiftKey.zip")
  unzip("Coursera-SwiftKey.zip")
}

## Function to create samples of txt files
SampleTxt <- function(srcFile, destFile, seed, totalLines, probability, readmode) {
  srcFileConn = file(srcFile, readmode)  # readmode = "r" or "rb"
  destFileConn = file(destFile,"w")
  # for each line, flip a coin to decide whether to put it in sample
  set.seed(seed)
  sample.distr = rbinom(n=totalLines, size=1, prob=probability)
  i = 0
  outLinesCnt <- 0
  for (i in 1:(totalLines+1))
  {
    currLine <- readLines(srcFileConn, n=1, encoding="UTF-8", skipNul=TRUE)
    
    if (length(currLine) == 0)
    {
      close(destFileConn)
      close(srcFileConn)
      return(outLinesCnt)
    }
    
    if (sample.distr[i] == 1)
    {
      writeLines(currLine, destFileConn)
      outLinesCnt <- outLinesCnt + 1
    }
  }
}

# setting the paths for data set text files
#setwd(wd_path)
blogs_path = "./final/en_US/en_US.blogs.txt"
news_path = "./final/en_US/en_US.news.txt"
twitter_path = "./final/en_US/en_US.twitter.txt"

## Make Samples
datalist = c(blogs_path,
              news_path,
              twitter_path)

# Used 1% for code-testing, Used 2% for fast-but-not-so-accurate version
probability = 0.0001
seed = 3606
# Used linux system command to know the line count for each file
# as reading the complete file at once just to know the line count 
# will degrade the overall application performance
blogLinesCnt = as.numeric(gsub('[^0-9]', '', system("wc -l ./final/en_US/en_US.blogs.txt", intern=TRUE)))
newsLinesCnt = as.numeric(gsub('[^0-9]', '', system("wc -l ./final/en_US/en_US.news.txt", intern=TRUE)))
twitterLinesCnt = as.numeric(gsub('[^0-9]', '', system("wc -l ./final/en_US/en_US.twitter.txt", intern=TRUE)))

## Read three corpus txt
blogSampleLinesCnt = SampleTxt(datalist[1], "blogSample.txt",
                                  seed, blogLinesCnt, probability, "r")
# must use readmode "rb" here, otherwise it breaks on a special char
newsSampleLinesCnt = SampleTxt(datalist[2], "newsSample.txt",
                                  seed, newsLinesCnt, probability, "rb")
twitterSampleLinesCnt = SampleTxt(datalist[3], "twitterSample.txt",
                                  seed, twitterLinesCnt, probability, "r")

## Get the number of lines in sample by use of system(wc -l) word counter
blogSampleLinesCnt = as.numeric(gsub('[^0-9]', '',
                                        system("wc -l blogSample.txt", intern=TRUE)))
newsSampleLinesCnt = as.numeric(gsub('[^0-9]', '',
                                        system("wc -l newsSample.txt", intern=TRUE)))
twitterSampleLinesCnt = as.numeric(gsub('[^0-9]', '',
                                        system("wc -l twitterSample.txt", intern=TRUE)))

# Read the sample data sets & combine them into one single data set
blogSample = readLines("./blogSample.txt")
newsSample = readLines("./newsSample.txt")
twitterSample = readLines("./twitterSample.txt")
combinedSample = c(blogSample, newsSample, twitterSample)
rm(blogSample, newsSample, twitterSample)
writeLines(combinedSample, "./combinedSample.txt")

## Make sure files exist
if (!file.exists("./combinedSample.txt")) {
  stop("error: please make sure dir has ./combinedSample.txt")
}

library(tm)

# functions to clean up the data set
removeURL <- function(x)
{
  gsub("http.*?( |$)", "", x)
}

convertSpecial <- function(x)
{
  # replace any <U+0092> with single straight quote, remove all other <>
  x = gsub("<U.0092>","'",x)  # actually unnecessary, but just in case
  x = gsub("'","'",x)
  gsub("<.+?>"," ",x)
}

removeNumbers <- function(x)
{
  # remove any word containing numbers
  gsub("\\S*[0-9]+\\S*", " ", x)
}

removePunct <- function(x)
{
  # function to remove most punctuation
  # replace everything that isn't alphanumeric, space, ', -, *
  gsub("[^[:alnum:][:space:]'*-]", " ", x)
}

removeDashApos <- function(x)
{
  # deal with dashes, apostrophes within words.
  # preserve intra-word apostrophes, remove all else
  x = gsub("--+", " ", x)
  x = gsub("(\\w['-]\\w)|[[:punct:]]", "\\1", x)
  gsub("-", " ", x)
}

removeSpaces <- function(x)
{
  # Trim leading and trailing whitespace
  gsub("^\\s+|\\s+$", "", x)
}

CleanCorpus <- function(x)
{
  x = tm_map(x, content_transformer(tolower))
  x = tm_map(x, content_transformer(removeURL))
  x = tm_map(x, content_transformer(convertSpecial))
  x = tm_map(x, content_transformer(removeNumbers))
  x = tm_map(x, content_transformer(removePunct))
  x = tm_map(x, content_transformer(removeDashApos))
  x = tm_map(x, content_transformer(stripWhitespace))
  x = tm_map(x, content_transformer(removeSpaces))
  return(x)
}

## Clean combined training set and save to disk
t1 = Sys.time()  
combinedSample = readLines("./combinedSample.txt")
rawSample = Corpus(VectorSource(combinedSample))
corpus.clean = CleanCorpus(rawSample)
rm(combinedSample)
rm(rawSample)
t2 = Sys.time()
t2 - t1

# tm::tm_map running extremely slow, so converting corpus to df
cleandf = data.frame(text=unlist(sapply(corpus.clean,
                                         `[`, "content")), stringsAsFactors=F)
cleanSample = cleandf$text
writeLines(cleanSample, "./cleanSample.txt")
rm(corpus.clean)
rm(cleanSample)
cat("made clean train data at ./cleanSample.txt")

rm(blogLinesCnt, blogSampleLinesCnt, datalist)
rm(probability, newsLinesCnt, newsSampleLinesCnt)
rm(twitterLinesCnt, twitterSampleLinesCnt)
cleanSample = readLines("./cleanSample.txt")

## Create unigram.csv - unigram of corpus
library(slam)
corpus.clean = Corpus(VectorSource(cleanSample))
## From clean corpus, make 1-gram TDM and then dataframe.
comb.tdm1 = TermDocumentMatrix(corpus.clean)
unigram = data.frame(row_sums(comb.tdm1))
rm(comb.tdm1)
unigram$word1 = rownames(unigram)
rownames(unigram) = NULL
colnames(unigram) = c("freq", "word1")
write.csv(unigram, "./unigram.csv", row.names=FALSE)
rm(corpus.clean)
cat("wrote unigram csv at ./unigram.csv")
## Replace all rare words in corpus with "UNK"
unigram = read.csv("./unigram.csv", stringsAsFactors=FALSE)
rare = subset(unigram, freq < 3) #consider those freq=1 or freq=2 as rare
rm(unigram)
file.remove("./unigram.csv")
rare = rare$word1  # character vector
cleanSample = readLines("./cleanSample.txt")

## Replace rare words with "UNK" for each line in cleanSample
library(parallel)
processInput <- function(x, rare)
{
  words = unlist(strsplit(x, " "))
  funk <- function(x, matches)
  {
    if (x %in% matches)
    {
      x = "UNK"
    }
    else
    {
      x
    }
  }
  rv = lapply(words, funk, matches=rare)
  paste(unlist(rv), collapse=" ")
}
t3 = Sys.time()
# time-consuming process - to replace rare words with "UNK"
numCores = detectCores()
cl = makeCluster(numCores)
results = parLapply(cl, cleanSample, processInput, rare=rare)
stopCluster(cl)
t4 = Sys.time()
t4 - t3 

results = unlist(results)
writeLines(results, "./unkSample.txt")
cat("wrote unk-ed text to disk at ./unkSample.txt")

if (!file.exists("./unkSample.txt")) {
  stop("error: please make sure ./unkSample.txt exists")
}

# convert text (character vector) to corpus
library(tm)
unkSample = readLines("./unkSample.txt")
corpus.unk = Corpus(VectorSource(unkSample))
rm(unkSample)

library(RWeka)
delim = ' \r\n\t.,;:"()?!'
library(slam)
library(stringr)

# Make bigram in csv format
cat("MAKING BIGRAMS NOW")
BigramTokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min=2, max=2, delimiters=delim))
}
BigramTDM <- function(x) {
  tdm = TermDocumentMatrix(x, control=list(tokenize=BigramTokenizer))
  return(tdm)
}
comb.tdm2 = BigramTDM(corpus.unk)
rm(BigramTokenizer); rm(BigramTDM)
bigram = data.frame(row_sums(comb.tdm2))
rm(comb.tdm2)
bigram$term = rownames(bigram)
rownames(bigram) = NULL
words = str_split_fixed(bigram$term, " ", 2)  # split col2 by space into 2 words
bigram = cbind(bigram[ ,1], words)
rm(words)
colnames(bigram) = c("freq", "word1", "word2")
write.csv(bigram, "./bigram.csv", row.names=FALSE)
rm(bigram)
cat("wrote BIGRAMS at ./bigram.csv")

# Make trigram in csv format
cat("MAKING TRIGRAMS NOW")
TrigramTokenizer <- function(x)
{
  NGramTokenizer(x, Weka_control(min=3, max=3, delimiters=delim))
}

TrigramTDM <- function(x)
{
  tdm = TermDocumentMatrix(x, control=list(tokenize=TrigramTokenizer))
  return(tdm)
}
comb.tdm3 = TrigramTDM(corpus.unk)
rm(TrigramTokenizer); rm(TrigramTDM)
trigram = data.frame(row_sums(comb.tdm3))
rm(comb.tdm3)
trigram$term = rownames(trigram)
rownames(trigram) = NULL
colnames(trigram) = c("freq","term")
trigram = subset(trigram, trigram$freq > 1)
words = str_split_fixed(trigram$term, " ", 3)  # split col2 by space into 3 words
trigram = cbind(trigram$freq, words)
rm(words)
colnames(trigram) = c("freq", "word1", "word2", "word3")
write.csv(trigram, "./trigram.csv", row.names=FALSE)
rm(trigram)
cat("wrote TRIGRAMS at ./trigram.csv")


# Make quadgram in csv format 
cat("MAKING QUADGRAMS NOW")
QuadgramTokenizer <- function(x)
{
  NGramTokenizer(x, Weka_control(min=4, max=4, delimiters=delim))
}
QuadgramTDM <- function(x)
{
  tdm = TermDocumentMatrix(x, control=list(tokenize=QuadgramTokenizer))
  return(tdm)
}
comb.tdm4 = QuadgramTDM(corpus.unk)
rm(QuadgramTokenizer); rm(QuadgramTDM)
quadgram = data.frame(row_sums(comb.tdm4))
rm(comb.tdm4)
quadgram$term = rownames(quadgram)
rownames(quadgram) = NULL
colnames(quadgram) = c("freq", "term")
quadgram = subset(quadgram, quadgram$freq > 1)  # remove singles
words = str_split_fixed(quadgram$term, " ", 4)  # split col2 by space into 4 words
quadgram = cbind(quadgram$freq, words)
rm(words)
colnames(quadgram) = c("freq", "word1", "word2", "word3", "word4")
write.csv(quadgram, "./quadgram.csv", row.names=FALSE)
rm(quadgram)
cat("wrote QUADGRAMS at ./quadgram.csv")


# Make Quintgram in csv format
cat("MAKING QUINTGRAMS NOW")
QuintgramTokenizer <- function(x)
{
  NGramTokenizer(x, Weka_control(min=5, max=5, delimiters=delim))
}
QuintgramTDM <- function(x)
{
  tdm = TermDocumentMatrix(x, control=list(tokenize=QuintgramTokenizer))
  return(tdm)
}
comb.tdm5 = QuintgramTDM(corpus.unk)
rm(QuintgramTokenizer); rm(QuintgramTDM)
quintgram = data.frame(row_sums(comb.tdm5))
rm(comb.tdm5)
quintgram$term = rownames(quintgram)
rownames(quintgram) = NULL
colnames(quintgram) = c("freq", "term")
quintgramk = subset(quintgram, quintgram$freq > 1)
words = str_split_fixed(quintgramk$term, " ", 5) # split col2 by space into 5 words
quintgramk = cbind(quintgramk$freq, words)
rm(words)
colnames(quintgramk) = c("freq", "word1", "word2", "word3", "word4", "word5")
write.csv(quintgramk, "./quintgram.csv", row.names=FALSE)
rm(quintgramk)
cat("wrote QUINTGRAMS to ./quintgram.csv")

cat("All N-Grams have been created in csv format!")