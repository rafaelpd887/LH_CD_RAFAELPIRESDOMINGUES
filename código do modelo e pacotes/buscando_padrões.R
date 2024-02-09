# Instalando e carregando o pacote "tm"
install.packages("tm")
library(tm)

# Criando um objeto que contém todos os nomes referentes as observações do percentil 99 da variável "price" (alto valor)
nomes <- Corpus(VectorSource(outliers$nome))

# "Limpando" os nomes
nomes <- tm_map(nomes, content_transformer(tolower)) # converte todas as letras para minúsculo
nomes <- tm_map(nomes, removePunctuation)            # remove toda a pontuação
nomes <- tm_map(nomes, removeNumbers)                # remove todos os números
nomes <- tm_map(nomes, removeWords, stopwords("portuguese")) # remove todas as palavras que "pouco" contribuem para o significado do texto 

# Criando uma matriz com os nomes
matriz_nomes <- DocumentTermMatrix(corpus)

# Analisando quais palavras aparecem ao menos 35 vezes nos nomes da matriz
findFreqTerms(matriz_nomes, lowfreq = 35)