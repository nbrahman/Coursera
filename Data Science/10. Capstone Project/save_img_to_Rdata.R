## To Generate "ngrams_and_badwords.RData" for the shinyapp
quintgram = read.csv("./quintgram.csv", stringsAsFactors=FALSE)
quadgram = read.csv("./quadgram.csv", stringsAsFactors=FALSE)
trigram = read.csv("./trigram.csv", stringsAsFactors=FALSE)
bigram = read.csv("./bigram.csv", stringsAsFactors=FALSE)
profanities = readLines("./badWords.txt", encoding="UTF-8")
save.image(file = "./ngrams_and_badwords.RData")