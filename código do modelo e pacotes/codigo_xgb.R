###############################################################################
##                          Instalação de pacotes                            ##                         
###############################################################################
packages <- c("dplyr", # funções de análise 
              "PerformanceAnalytics", # funções de análise 
              "fastDummies", # One Hot Coding 
              "car", # funções de análise
              "caret" , # xgbtree
              "readr"  # leitura de arquivos .csv
)
if(sum(as.numeric(!packages %in% installed.packages())) != 0){
  installer <- packages[!packages %in% installed.packages()]
  for(i in 1:length(installer)) {
    install.packages(installer, dependencies = T)
    break()}
  sapply(packages, require, character = T) 
} else {
  sapply(packages, require, character = T) 
}

###############################################################################
##                          Pré-processamento de Dados                       ##                         
###############################################################################
# Carregando os dados
aps <- read_csv("teste_indicium_precificacao.csv")

# Removendo variáveis inúteis para o nosso objetivo
variaveis_para_remover <- c("id", "nome", "host_id", "host_name", "bairro_group", "latitude", "longitude", "numero_de_reviews", "ultima_review", "reviews_por_mes", "calculado_host_listings_count")

# Removendo as colunas do dataset
aps_final <- aps[, -which(names(aps) %in% variaveis_para_remover)]


###############################################################################
##                   Processamento de Dados Pós-Análise                      ##                          
###############################################################################
# CALCULANDO OS LIMITES PARA OUTLIERS DE "PRICE"
# Calculando o IQR de "price"
IQR <- IQR(aps_final$price)

# Calculando os limites inferior e superior para os outliers de "price"
limite_inferior_price <- quantile(aps_final$price, 0.25) - 1.5 * IQR
limite_superior_price <- quantile(aps_final$price, 0.75) + 1.5 * IQR

# CALCULANDO OS LIMITES PARA OUTLIERS DE "MINIMO_NOITES"
# Calculando o IQR de "minimo_noites"
IQR2 <- IQR(aps_final$minimo_noites)

# Calculando os limites inferior e superior para os outliers de "minimo_noites"
limite_inferior_minimo_noites <- quantile(aps_final$minimo_noites, 0.25) - 1.5 * IQR2
limite_superior_minimo_noites <- quantile(aps_final$minimo_noites, 0.75) + 1.5 * IQR2

# Removendo outliers
aps_final2 <- aps_final[aps_final$price > limite_inferior_price & aps_final$price < limite_superior_price, ]

aps_final3 <- aps_final2[aps_final2$minimo_noites > limite_inferior_minimo_noites & aps_final2$minimo_noites < limite_superior_minimo_noites, ]

# Criando um objeto com as variaveis a serem dummizadas
variaveis_qualitativas <- c("bairro", "room_type")

# Dummizando as variáveis qualitativas
aps_final_4 <- dummy_columns(.data = aps_final3,
                            select_columns = variaveis_qualitativas,
                            remove_selected_columns = TRUE,
                            remove_most_frequent_dummy = TRUE) %>%
  rename_with(.cols = contains(variaveis_qualitativas), .fn = ~ paste0("dummy_", .))

# Dividindo o dataset em "treino" e "teste"
n <- sample(1:2,                                
            size = nrow(aps_final_4),            
            replace = TRUE,                     
            prob=c(0.8, 0.2))                   
treino <- aps_final_4[n==1,]                      
teste <- aps_final_4[n==2,]                      

###############################################################################
##                           Criando o Modelo                                ##                          
###############################################################################

# ps:O modelo final foi criando após um modelo inicial ter sido criado e avaliado com os
# datasets "treino" e "teste"

# Definindo o parâmento de controle
control <- caret::trainControl(
  "cv",                              
  number = 2,                        
  summaryFunction = defaultSummary,  
  classProbs = FALSE                 
)

# Definindo o "search_grid"
search_grid <- expand.grid(
  nrounds = 1000,                      
  max_depth = 30,                    
  gamma = 0,                         
  eta = c(0.05, 0.4),               
  colsample_bytree = .7,             
  min_child_weight = 1,               
  subsample = .7                     
)

# Criando/treinando o modelo 
xgbt <- caret::train(
  price ~ .,                         
  data = aps_final_4,
  method = "xgbTree",
  trControl = control,
  tuneGrid = search_grid,
  verbosity = 0
)

###############################################################################
##                            Avaliando o Modelo                             ##                    
###############################################################################

# Criando uma função para avaliar o modelo
evaluate <- function(pred, obs) {
  mse <- mean((pred - obs)^2)
  rmse <- sqrt(mse)
  mae <- mean(abs(pred - obs))
  r_squared <- 1 - (sum((obs - pred)^2) / sum((obs - mean(obs))^2))
  
  cat("MSE:", mse, "\n")
  cat("RMSE:", rmse, "\n")
  cat("MAE:", mae, "\n")
  cat("R-squared:", r_squared, "\n")
}

# Avaliando o modelo
previsao_treino <- predict(xgbt, treino)
previsao_teste <- predict(xgbt, teste)

evaluate(previsao_treino, treino$price)
evaluate(previsao_teste, teste$price)


###############################################################################
##         Prevendo o preço do apartamento da etapa 4 do desafio             ##                    
###############################################################################

# Criando um dataframe com as variaveis do novo ap
novo_ap <- data.frame(
  id = 2595,
  nome = "Skylit Midtown Castle",
  host_id = 2845,
  host_name = "Jennifer",
  bairro_group = "Manhattan",
  bairro = "Midtown",
  latitude = 40.75362,
  longitude = -73.98377,
  room_type = "Entire home/apt",
  price = 225,
  minimo_noites = 1,
  numero_de_reviews = 45,
  ultima_review = as.Date("2019-05-21"),
  reviews_por_mes = 0.38,
  calculado_host_listings_count = 2,
  disponibilidade_365 = 355
)

# Removendo as colunas não usadas no modelo
novo_ap2 <- novo_ap[, -which(names(novo_ap) %in% variaveis_para_remover)]

# Obter os nomes das colunas do conjunto de dados original
aps_final_4_var <- names(aps_final_4)

# Adicionar colunas dummy ausentes a novo_aps
for (nome_coluna in aps_final_4_var) {
  if (!nome_coluna %in% names(novo_ap2)) {
    novo_ap2[[nome_coluna]] <- 0
  }
}

# Removendo as variáveis "bairro" e "room_type" originais
novo_ap2$bairro <- NULL
novo_ap2$room_type <- NULL

# Atribuir o valor correto à variáveis dummy para 'Midtown' e 'Entire home/apt'
novo_ap2$dummy_bairro_Midtown <- 1
novo_ap2$`dummy_room_type_Entire home/apt` <- 1

# Usando o modelo para prever o preço da etapa 4
previsao_preco <- predict(xgbt, novo_ap2)

# Imprimindo a previsão do preço
print(previsao_preco)
