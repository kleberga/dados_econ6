#_______________________________________________________________________________________________________________________
#
# Script para gerar as series a serem mostradas no app
#
#_______________________________________________________________________________________________________________________
#
#_______________________________________________________________________________________________________________________
# inicializacao ----
#_______________________________________________________________________________________________________________________
# options(repos = "https://repo.bcnet.bcb.gov.br/artifactory/cran")
# install.packages("uuid")

library(jsonlite)
library(curl)
library(dplyr)
library(tidyverse)
library(uuid)
#_______________________________________________________________________________________________________________________
# carregar os dados Resultado Fiscal do TN ----
#_______________________________________________________________________________________________________________________
# limpar a area de trabalho
rm(list=ls())
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
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Valores reais")
    } else {
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Valores correntes")
    }
    if(w == "true"){
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "valores reais")
    } else {
      lista_dados[['nomeCompleto']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "valores correntes")
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
    lista_dados[['idAssunto']] <- 1
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
      lista_dados[['nome']] <- paste0(gsub(" - Valores Mensais","",base_rtn_df_1[i,"nomeTema"]), " - ", "Valores reais")
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
    lista_dados[['idAssunto']] <- 1
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
    lista_dados[['idAssunto']] <- 1
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
base_dados_final <- bind_rows(base_dados_1, base_dados_2, base_dados_3)


# exportar como csv
write.csv(base_dados_final, "C:/Users/depec.kleber/OneDrive - BCB Azure/Documentos/base_dados_final.csv",row.names = F, fileEncoding = "latin1")
