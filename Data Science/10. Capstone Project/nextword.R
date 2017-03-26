## Predict next word based on previously computed ngram csvs

## ----------
# This script assumes that I have CSV files containing n-grams for n=2:5.
# The structure of the resulting dataframe should be:
# <freq> <word1> <word2> <word3> for the 3-gram, and so on.

# The script takes a sentence, match the last 5/4/3/2 words of the
# sentence to the appropriate ngrams, and predicts the most likely
# next word based on a score derived from word frequencies.
## ----------

## Load in ngrams
if (!exists("quintgram"))
{
  quintgram = read.csv("quintgram.csv", stringsAsFactors=FALSE)
}

if (!exists("quadgram"))
{
  quadgram = read.csv("quadgram.csv", stringsAsFactors=FALSE)
}

if (!exists("trigram"))
{
  trigram = read.csv("trigram.csv", stringsAsFactors=FALSE)
}

if (!exists("bigram"))
{
  bigram = read.csv("bigram.csv", stringsAsFactors=FALSE)
}

if (!exists("profanities"))
{
  profanities = readLines("badWords.txt", encoding="UTF-8")
}

# Function to clean a phrase and remove bracketed parts
CleanPhrase <- function(x)
{
  # convert to lowercase
  x = tolower(x)
  
  # remove numbers
  x = gsub("\\S*[0-9]+\\S*", " ", x)
  
  # change common hyphenated words to non
  x = gsub("e-mail","email", x)
  
  # remove any brackets at the ends
  x = gsub("^[(]|[)]$", " ", x)
  
  # remove any bracketed parts in the middle
  x = gsub("[(].*?[)]", " ", x)
  
  # remove punctuation, except intra-word apostrophe and dash
  x = gsub("[^[:alnum:][:space:]'-]", " ", x)
  x = gsub("(\\w['-]\\w)|[[:punct:]]", "\\1", x)
  
  # compress and trim whitespace
  x = gsub("\\s+"," ",x)
  x = gsub("^\\s+|\\s+$", "", x)
  
  return(x)
}

# Function to return the last N words of cleaned phrase, in a char vec
GetLastWords <- function(x, n)
{
  x = CleanPhrase(x)
  words = unlist(strsplit(x, " "))
  len = length(words)
  if (n < 1)
  {
    stop("GetLastWords() error: number of words  < 0")
  }
  
  if (n > len)
  {
    n = len
  }
  
  if (n==1)
  {
    return(words[len])
  }
  else
  {
    rv = words[len]
    for (i in 1:(n-1))
    {
      rv = c(words[len-i], rv)
    }
    rv
  }
}

# Functions to check n-gram for x. Returns df with cols: [nextword] [MLE]
Check5Gram <- function(x, quintgram, getNrows)
{
  words = GetLastWords(x, 4)
  match = subset(quintgram, word1 == words[1] & word2 == words[2]
                  & word3 == words[3] & word4 == words[4])
  match = subset(match, select=c(word5, freq))
  match = match[order(-match$freq), ]
  sumfreq = sum(match$freq)
  match$freq = round(match$freq / sumfreq * 100)
  colnames(match) = c("nextword","quintgram.MLE")
  if (nrow(match) < getNrows)
  {
    getNrows = nrow(match)
  }
  match[1:getNrows, ]
}

Check4Gram <- function(x, quadgram, getNrows)
{
  words = GetLastWords(x, 3)
  match = subset(quadgram, word1 == words[1] & word2 == words[2]
                  & word3 == words[3])
  match = subset(match, select=c(word4, freq))
  match = match[order(-match$freq), ]
  sumfreq = sum(match$freq)
  match$freq = round(match$freq / sumfreq * 100)
  colnames(match) = c("nextword","quadgram.MLE")
  if (nrow(match) < getNrows)
  {
    getNrows = nrow(match)
  }
  match[1:getNrows, ]
}

Check3Gram <- function(x, trigram, getNrows)
{
  words = GetLastWords(x, 2)
  match = subset(trigram, word1 == words[1] & word2 == words[2])
  match = subset(match, select=c(word3, freq))
  match = match[order(-match$freq), ]
  sumfreq = sum(match$freq)
  match$freq = round(match$freq / sumfreq * 100)
  colnames(match) = c("nextword","trigram.MLE")
  if (nrow(match) < getNrows)
  {
    getNrows = nrow(match)
  }
  match[1:getNrows, ]
}

Check2Gram <- function(x, bigram, getNrows)
{
  words = GetLastWords(x, 1)
  match = subset(bigram, word1 == words[1])
  match = subset(match, select=c(word2, freq))
  match = match[order(-match$freq), ]
  sumfreq = sum(match$freq)
  match$freq = round(match$freq / sumfreq * 100)
  colnames(match) = c("nextword","bigram.MLE")
  if (nrow(match) < getNrows)
  {
    getNrows = nrow(match)
  }
  match[1:getNrows, ]
}

# Function to computes stupid backoff score
SBScore <- function(alpha=0.4, x5, x4, x3, x2)
{
  score = 0
  if (x5 > 0)
  {
    score = x5
  }
  else if (x4 >= 1)
  {
    score = x4 * alpha
  }
  else if (x3 > 0)
  {
    score = x3 * alpha * alpha
  }
  else if (x2 > 0)
  {
    score = x2 * alpha * alpha * alpha
  }
  
  return(round(score,1))
}

# Function to combine the nextword matches into one dataframe
ScoreNgrams <- function(x, nrows=20)
{
  # get dfs from parent env
  quintgram.match = Check5Gram(x, quintgram, nrows)
  quadgram.match = Check4Gram(x, quadgram, nrows)
  trigram.match = Check3Gram(x, trigram, nrows)
  bigram.match = Check2Gram(x, bigram, nrows)
  # merge dfs, by outer join (fills zeroes with NAs)
  merge5quadgram = merge(quintgram.match, quadgram.match, by="nextword", all=TRUE)
  merge4trigram = merge(merge5quadgram, trigram.match, by="nextword", all=TRUE)
  merge3bigram = merge(merge4trigram, bigram.match, by="nextword", all=TRUE)
  df = subset(merge3bigram, !is.na(nextword))  # remove any zero-match results
  if (nrow(df) > 0)
  {
    df = df[order(-df$quintgram.MLE, -df$quadgram.MLE, -df$trigram.MLE, -df$bigram.MLE), ]
    df[is.na(df)] = 0  # replace all NAs with 0
    # add in scores
    df$score = mapply(SBScore, alpha=0.4, df$quintgram.MLE, df$quadgram.MLE,
                       df$trigram.MLE, df$bigram.MLE)
    df = df[order(-df$score), ]
  }
  return(df)  # dataframe
}

# Implement stupid backoff algorithm
StupidBackoff <- function(x, alpha=0.4, getNrows=20, showNresults=1,
                          removeProfanity=TRUE)
{
  nextword = ""
  if (x == "")
  {
    return("the")
  }
  
  df = ScoreNgrams(x, getNrows)
  if (nrow(df) == 0)
  {
    return("and")
  }
  
  df = df[df$nextword != "UNK", ]  # remove UNK
  if (showNresults > nrow(df))
  {
    showNresults = nrow(df)
  }
  
  if (showNresults == 1)
  {
    # check if top overall score is shared by multiple candidates
    topwords = df[df$score == max(df$score), ]$nextword
    
    # if multiple candidates, randomly select one
    nextword = sample(topwords, 1)
  }
  else
  {
    nextword = df$nextword[1:showNresults]
  }
  
  if (removeProfanity)
  {
    if (nextword %in% profanities)
    {
      nextword = "#@?!"
    }
  }
  return(nextword)
}