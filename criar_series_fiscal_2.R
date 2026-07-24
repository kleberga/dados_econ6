library(uuid)
library(readxl)
library(jsonlite)
library(curl)
library(tidyverse)
library(rstudioapi)
# limpar a area de trabalho
rm(list=ls())

setwd(dirname(getSourceEditorContext()$path))

dados_monetarios <- read_excel("fiscal_3.xlsx")

lista_nova <- list()
base_df <- data.frame()
for(i in c(1:nrow(dados_monetarios))){
  
  if(dados_monetarios[i,"per"]=="M"){
    periodicidade <- "mensal"
  } else if(dados_monetarios[i,"per"]=="D"){
    periodicidade <- "diária"
  } else if(dados_monetarios[i,"per"]=="A"){
    periodicidade <- "anual"
  } else if(dados_monetarios[i,"per"]=="T"){
    periodicidade <- "trimestral"
  } else {
    periodicidade <- ''
  }
  
  lista_nova[['numero']] <- UUIDgenerate()
  lista_nova[['nome']] <- as.character(dados_monetarios[i,"nome"])
  lista_nova[['nomeCompleto']] <- as.character(dados_monetarios[i,"nome_completo"])
  lista_nova[['descricao']] <- as.character(dados_monetarios[i,"descricao"])
  lista_nova[['formato']] <- as.character(dados_monetarios[i,"formato"])
  lista_nova[['fonte']] <- as.character(dados_monetarios[i,"fonte"])
  
  
  lista_nova[['urlAPI']] <- as.character(dados_monetarios[i,"urlAPI"])
  lista_nova[['idAssunto']] <- as.character(dados_monetarios[i,"idAssunto"])
  lista_nova[['periodicidade']] <- periodicidade
  lista_nova[['metrica']] <- as.character(dados_monetarios[i,"metrica"])
  lista_nova[['nivelGeografico']] <- as.character(dados_monetarios[i,"nivel_geog"])
  lista_nova[['localidades']] <- as.character(dados_monetarios[i,"localidades"])
  lista_nova[['categoria']] <- as.character(dados_monetarios[i,"categoria"])
  
  
  teste <- do.call("cbind",lista_nova)
  teste2 <- as.data.frame(teste)
  base_df <- bind_rows(base_df, teste2)
  
}
# apagar o numero das linhas
row.names(base_df) <- NULL
#_______________________________________________________________________________________________________________________
# carregar os dados Resultado Fiscal do TN ----
#_______________________________________________________________________________________________________________________
# metadados do INPC
url <- "https://apiapex.tesouro.gov.br/aria/v1/series-temporais/custom/series"
# carregar todos os metadados
base_rtn <- fromJSON(url)
# criar tabela com as séries
base_rtn_df <- base_rtn$registros %>% bind_rows()
#_______________________________________________________________________________________________________________________
# carregar os dados do Resultado Fiscal do TN ----
#_______________________________________________________________________________________________________________________
# filtrar apenas as series de Resultado Fiscal do TN
base_rtn_df_1 <- base_rtn_df %>% filter(codigoTema == 10)
# criar lista vazia para armazenar as series
lista_dados <- list()
# data frame vazio para se preenchido
base_dados_1 <- data.frame()
# preencher a lista com as series
for(i in 1:nrow(base_rtn_df_1)){
  for(w in c("true","false")){
    id_serie <- UUIDgenerate()
    lista_dados[['numero']] <- id_serie
    if(w == "true"){
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Acima da linha", " - ", "Valores reais")
    } else {
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Acima da linha", " - ", "Valores correntes")
    }
    if(w == "true"){
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Acima da linha", " - ", "valores reais")
    } else {
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Acima da linha", " - ", "valores correntes")
    }
    lista_dados[['descricao']] <- "A Secretaria do Tesouro Nacional (STN) publica mensalmente o Resultado do Tesouro Nacional, no qual apresenta o resultado primário do Governo Central, composto pelo Tesouro Nacional, Previdência Social e Banco Central, além de uma descrição de receitas e despesas primárias. A STN apura o resultado a partir da mensuração dos fluxos de ingressos (receitas) e saídas (despesas), conforme metodologia conhecida como 'Acima da Linha'."
    if(w == "true"){
      lista_dados[['formato']] <- "R$ milhões - Valores reais do mês mais recente da série"
    } else {
      lista_dados[['formato']] <- "R$ milhões - Valores correntes"
    }
    lista_dados[['fonte']] <- "Secretaria do Tesouro Nacional (STN)"
    if(w == "true"){
      lista_dados[['urlAPI']] <- paste0("https://apiapex.tesouro.gov.br/aria/v1/series-temporais/custom/resultado-fiscal?tema=",base_rtn_df_1[i,"codigoTema"],"&codigo_da_serie=",base_rtn_df_1[i,"codigoSerie"],"&correcao_ipca=true")
    } else {
      lista_dados[['urlAPI']] <- paste0("https://apiapex.tesouro.gov.br/aria/v1/series-temporais/custom/resultado-fiscal?tema=",base_rtn_df_1[i,"codigoTema"],"&codigo_da_serie=",base_rtn_df_1[i,"codigoSerie"])
    }
    lista_dados[['idAssunto']] <- 7
    lista_dados[['periodicidade']] <- "mensal"
    lista_dados[['metrica']] <- base_rtn_df_1[i,"nomeSubtema"]
    lista_dados[['nivelGeografico']] <- "Brasil"
    lista_dados[['localidades']] <- "Brasil"
    lista_dados[['categoria']] <- base_rtn_df_1[i,"nomeSerie"]
    teste <- do.call("cbind",lista_dados)
    teste2 <- as.data.frame(teste)
    base_dados_1 <- bind_rows(base_dados_1, teste2)
  }
}
# apagar o numero das linhas
row.names(base_dados_1) <- NULL
#_______________________________________________________________________________________________________________________
# carregar os dados de Investimento do Governo Federal ----
#_______________________________________________________________________________________________________________________
# filtrar apenas as series de Resultado Fiscal do TN
base_rtn_df_1 <- base_rtn_df %>% filter(codigoTema == 13)
# criar lista vazia para armazenar as series
lista_dados <- list()
# data frame vazio para se preenchido
base_dados_2 <- data.frame()
# preencher a lista com as series
for(i in 1:nrow(base_rtn_df_1)){
  for(w in c("true","false")){
    id_serie <- UUIDgenerate()
    lista_dados[['numero']] <- id_serie
    if(w == "true"){
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ","Valores reais")
    } else {
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Valores correntes")
    }
    if(w == "true"){
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "valores reais")
    } else {
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "valores correntes")
    }
    lista_dados[['descricao']] <- "Para fins de abrangência dessa estatística, são considerados investimentos as despesas primárias pagas por todos os poderes do Governo Central, contemplando os grupos de despesa 'Investimento' e 'Inversões Financeiras', acrescido do ajuste de ordens bancárias de último dia. A desagregação dos investimentos é feita por grupos de natureza de despesas (GND 4 – Investimentos ou GND 5 – Inversões Financeiras) e funções de governo. Adicionalmente, é publicado um memorando em que os investimentos do GND 4 são classificados por modalidades de aplicação e os do GND 5 por ações mais relevantes."
    if(w == "true"){
      lista_dados[['formato']] <- "R$ milhões - Valores reais do mês mais recente da série"
    } else {
      lista_dados[['formato']] <- "R$ milhões - Valores correntes"
    }
    lista_dados[['fonte']] <- "Secretaria do Tesouro Nacional (STN)"
    if(w == "true"){
      lista_dados[['urlAPI']] <- paste0("https://apiapex.tesouro.gov.br/aria/v1/series-temporais/custom/resultado-fiscal?tema=",base_rtn_df_1[i,"codigoTema"],"&codigo_da_serie=",base_rtn_df_1[i,"codigoSerie"],"&correcao_ipca=true")
    } else {
      lista_dados[['urlAPI']] <- paste0("https://apiapex.tesouro.gov.br/aria/v1/series-temporais/custom/resultado-fiscal?tema=",base_rtn_df_1[i,"codigoTema"],"&codigo_da_serie=",base_rtn_df_1[i,"codigoSerie"])
    }
    lista_dados[['idAssunto']] <- 7
    lista_dados[['periodicidade']] <- "mensal"
    lista_dados[['metrica']] <- base_rtn_df_1[i,"nomeSubtema"]
    lista_dados[['nivelGeografico']] <- "Brasil"
    lista_dados[['localidades']] <- "Brasil"
    lista_dados[['categoria']] <- base_rtn_df_1[i,"nomeSerie"]
    teste <- do.call("cbind",lista_dados)
    teste2 <- as.data.frame(teste)
    base_dados_2 <- bind_rows(base_dados_2, teste2)
  }
}
# apagar o numero das linhas
row.names(base_dados_2) <- NULL
#_______________________________________________________________________________________________________________________
# carregar os dados de Custeio Administrativo do Governo Central ----
#_______________________________________________________________________________________________________________________
# filtrar apenas as series de Resultado Fiscal do TN
base_rtn_df_1 <- base_rtn_df %>% filter(codigoTema == 20)
# criar lista vazia para armazenar as series
lista_dados <- list()
# data frame vazio para se preenchido
base_dados_3 <- data.frame()
# preencher a lista com as series
for(i in 1:nrow(base_rtn_df_1)){
  for(w in c("true","false")){
    id_serie <- UUIDgenerate()
    lista_dados[['numero']] <- id_serie
    if(w == "true"){
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Valores reais")
    } else {
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Valores correntes")
    }
    if(w == "true"){
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "valores reais")
    } else {
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "valores correntes")
    }
    lista_dados[['descricao']] <- "A série de custeio do Resultado do Tesouro Nacional (RTN) é desagregada em diferentes grupos e itens de despesas que representam os principais subelementos de despesas do Governo Central. O formato de apresentação está harmonizado com o Boletim de Custeio Administrativo da Secretaria de Orçamento Federal (SOF). A apuração do custeio é realizada pelo conceito de pagamentos totais (despesas pagas acrescidas dos restos a pagar pagos) e abrange todos os Poderes do Governo Central. Além da divisão do custeio administrativo por 'tipo de custeio', a série histórica do RTN também contém a divisão desse conjunto de despesas por função orçamentária."
    if(w == "true"){
      lista_dados[['formato']] <- "R$ milhões - Valores reais do mês mais recente da série"
    } else {
      lista_dados[['formato']] <- "R$ milhões - Valores correntes"
    }
    lista_dados[['fonte']] <- "Secretaria do Tesouro Nacional (STN)"
    if(w == "true"){
      lista_dados[['urlAPI']] <- paste0("https://apiapex.tesouro.gov.br/aria/v1/series-temporais/custom/resultado-fiscal?tema=",base_rtn_df_1[i,"codigoTema"],"&codigo_da_serie=",base_rtn_df_1[i,"codigoSerie"],"&correcao_ipca=true")
    } else {
      lista_dados[['urlAPI']] <- paste0("https://apiapex.tesouro.gov.br/aria/v1/series-temporais/custom/resultado-fiscal?tema=",base_rtn_df_1[i,"codigoTema"],"&codigo_da_serie=",base_rtn_df_1[i,"codigoSerie"])
    }
    lista_dados[['idAssunto']] <- 7
    lista_dados[['periodicidade']] <- "mensal"
    lista_dados[['metrica']] <- base_rtn_df_1[i,"nomeSubtema"]
    lista_dados[['nivelGeografico']] <- "Brasil"
    lista_dados[['localidades']] <- "Brasil"
    lista_dados[['categoria']] <- base_rtn_df_1[i,"nomeSerie"]
    teste <- do.call("cbind",lista_dados)
    teste2 <- as.data.frame(teste)
    base_dados_3 <- bind_rows(base_dados_3, teste2)
  }
}
# apagar o numero das linhas
row.names(base_dados_3) <- NULL
# unir as bases
base_dados_final <- bind_rows(base_df, base_dados_1, base_dados_2, base_dados_3)


# exportar como csv
write.csv(base_dados_final, file="fiscal_2.csv", row.names = F, fileEncoding = "latin1")
  

