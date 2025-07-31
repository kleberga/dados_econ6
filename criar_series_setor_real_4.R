library(uuid)
library(dplyr)
library(readxl)

source("C:/Users/Kleber/AndroidStudioProjects/dados_economicos6/criar_series_setor_real_3.R", encoding = "UTF-8")

#_______________________________________________________________________________________________________________________
# tratar os dados do IPEADATA para o setor real
#_______________________________________________________________________________________________________________________

ipeadata_arq <- read_excel("C:/Users/Kleber/Documents/setor_real_ipeadata.xlsx")

lista_nova <- list()
base_df_nova <- data.frame()
# alterar o codigo das series
for(i in c(1:nrow(ipeadata_arq))){
  # Split the text at commas 
  nova_base <- ipeadata_arq[i,,drop=F]
  
  lista_nova[['numero']] <- UUIDgenerate()
  lista_nova[['nome']] <- nova_base$nome
  lista_nova[['nomeCompleto']] <- nova_base$nomeCompleto
  lista_nova[['descricao']] <- nova_base$descricao
  lista_nova[['formato']] <- nova_base$formato
  lista_nova[['fonte']] <- nova_base$fonte
  
  split_text_7 <- unlist(strsplit(split_text[[6]], ",", fixed = TRUE))
  
  lista_nova[['urlAPI']] <- nova_base$urlAPI
  lista_nova[['idAssunto']] <- nova_base$idAssunto
  lista_nova[['periodicidade']] <- nova_base$periodicidade
  lista_nova[['metrica']] <- nova_base$metrica
  lista_nova[['nivelGeografico']] <- nova_base$nivelGeografico
  lista_nova[['localidades']] <- nova_base$localidades
  lista_nova[['categoria']] <- nova_base$categoria
  
  teste <- do.call("cbind",lista_nova)
  teste2 <- as.data.frame(teste)
  base_df_nova <- bind_rows(base_df_nova, teste2)
}


#_______________________________________________________________________________________________________________________
# tratar os dados do SGS para o setor real
#_______________________________________________________________________________________________________________________

sgs_real <- read_excel("C:/Users/Kleber/Documents/setor_real.xlsx")

lista_nova <- list()
base_df_nova_2 <- data.frame()
for(i in c(1:nrow(sgs_real))){
  
  if(sgs_real[i,"per"]=="M"){
    periodicidade <- "mensal"
  } else if(sgs_real[i,"per"]=="D"){
    periodicidade <- "diária"
  } else if(sgs_real[i,"per"]=="A"){
    periodicidade <- "anual"
  } else if(sgs_real[i,"per"]=="T"){
    periodicidade <- "trimestral"
  } else {
    periodicidade <- ''
  }
  
  lista_nova[['numero']] <- UUIDgenerate()
  lista_nova[['nome']] <- as.character(sgs_real[i,"nome"])
  lista_nova[['nomeCompleto']] <- as.character(sgs_real[i,"nome_completo"])
  lista_nova[['descricao']] <- as.character(sgs_real[i,"descricao"])
  lista_nova[['formato']] <- as.character(sgs_real[i,"formato"])
  lista_nova[['fonte']] <- as.character(sgs_real[i,"fonte"])
  
  
  lista_nova[['urlAPI']] <- as.character(sgs_real[i,"urlAPI"])
  lista_nova[['idAssunto']] <- as.character(sgs_real[i,"idAssunto"])
  lista_nova[['periodicidade']] <- periodicidade
  lista_nova[['metrica']] <- as.character(sgs_real[i,"metrica"])
  lista_nova[['nivelGeografico']] <- as.character(sgs_real[i,"nivel_geog"])
  lista_nova[['localidades']] <- as.character(sgs_real[i,"localidades"])
  lista_nova[['categoria']] <- as.character(sgs_real[i,"categoria"])
  
  
  teste <- do.call("cbind",lista_nova)
  teste2 <- as.data.frame(teste)
  base_df_nova_2 <- bind_rows(base_df_nova_2, teste2)
  
}

base_df_final <- bind_rows(base_df, base_df_nova, base_df_nova_2)

# exportar como csv
write.csv(base_df_final, file="C:/Users/Kleber/Documents/setor_real_2.csv", row.names = F)
     



