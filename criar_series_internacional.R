library(uuid)
library(dplyr)
library(readxl)


sgs_real <- read_excel("C:/Users/Kleber/Documents/internacional_ipeadata.xlsx")

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



# exportar como csv
write.csv(base_df_nova_2, file="C:/Users/Kleber/Documents/internacional.csv", row.names = F)


