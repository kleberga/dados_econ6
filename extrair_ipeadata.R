library(uuid)
library(readxl)
library(dplyr)
library(jsonlite)
library(writexl)
library(stringr)
#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para o câmbio
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c("WDI_PPCTAXAC2021","BMF366_FUT1DOL366","GAC12_PPCTAXAC12","GM366_ERTUR366")

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }

  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " (", dados_df$MULNOME, ")")
  }
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- base_filt$SERCOMENTARIO
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 4
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nome_completo = nomeCompleto, formato = formato, per = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivel_geog = nivelGeografico,localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "setor_externo_ipea.xlsx")


#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para o setor externo ---
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c( "FUNCEX_XVT",
                "FUNCEX12_XVT12",
                "FUNCEX12_XPAGP2N12",
                "FUNCEX12_XPVEST2N12", 
                "FUNCEX12_XQAGP2N12",
                "FUNCEX12_XQBEB2N12",
                "FUNCEX12_XQVEST2N12", 
                "FUNCEX12_XVAGP2N12",
                "FUNCEX12_XVBEB2N12",
                "FUNCEX12_XVVEST2N12", 
                "FUNCEX_XPAGP2N",
                "FUNCEX_XPVEST2N", 
                "FUNCEX_XQAGP2N",
                "FUNCEX_XVAGP2N",
                "FUNCEX_XVBEB2N",
                "FUNCEX_XVVEST2N",
                "FUNCEX_XVBK",
                "FUNCEX12_XPBCDGCE12",
                "FUNCEX12_XQBCDGCE12",
                "FUNCEX12_XQBCNDGCE12", 
                "FUNCEX12_XQBIGCE12",
                "FUNCEX12_XQBKGCE12",
                "FUNCEX12_XVBCDGCE12", 
                "FUNCEX12_XVBCNDGCE12", 
                "FUNCEX12_XVBIGCE12",
                "FUNCEX12_XVBKGCE12",
                "FUNCEX_XPBI",
                "FUNCEX_XPBK",
                "FUNCEX_XQBCD", 
                "FUNCEX_XQBCND",
                "FUNCEX_XQBK",
                "FUNCEX_XVBCD", 
                "FUNCEX_XVBCND", 
                "FUNCEX_XVBI",
                "FUNCEX12_XPCOMBGCE12",
                "FUNCEX12_XQCOMBGCE12", 
                "FUNCEX12_XVCOMBGCE12",
                "FUNCEX_XPCOMB",
                "FUNCEX_XVCOMB",
                "FUNCEX12_XPCAL2N12",
                "FUNCEX12_XPPAP2N12",
                "FUNCEX12_XPPETCOMB2N12",
                "FUNCEX12_XQCAL2N12",
                "FUNCEX12_XQPAP2N12",
                "FUNCEX12_XQPETCOMB2N12",
                "FUNCEX12_XVCAL2N12",
                "FUNCEX12_XVPAP2N12",
                "FUNCEX12_XVPETCOMB2N12",
                "FUNCEX_XPPAP2N",
                "FUNCEX_XPPETCOMB2N",
                "FUNCEX_XVCAL2N",
                "FUNCEX_XVPAP2N",
                "FUNCEX_XVPETCOMB2N",
                "FUNCEX12_XPMAQINF2N12",
                "FUNCEX12_XQEMM2N12",
                "FUNCEX12_XQEMNM2N12", 
                "FUNCEX12_XQEPET2N12",
                "FUNCEX12_XQMAQINF2N12", 
                "FUNCEX12_XQDIV2N12",
                "FUNCEX12_XQIXQG2N12", 
                "FUNCEX12_XVEMM2N12",
                "FUNCEX12_XVEPET2N12", 
                "FUNCEX12_XVDIV2N12",
                "FUNCEX_XPEPET2N",
                "FUNCEX_XQDIV2N",
                "FUNCEX_XVEMM2N",
                "FUNCEX_XVEMNM2N", 
                "FUNCEX_XVEPET2N",
                "FUNCEX_XVMAQINF2N",
                "FUNCEX_XVDIV2N",
                "FUNCEX_XVIXVG2N",
                "FUNCEX_XVECARV2N",
                "FUNCEX12_XPMAQELET2N12",
                "FUNCEX12_XPMAQEQU2N12",
                "FUNCEX12_XPMOV2N12",
                "FUNCEX12_XPOUTTRANS2N12",
                "FUNCEX12_XQMAQELET2N12",
                "FUNCEX12_XQMAQEQU2N12",
                "FUNCEX12_XQMETBAS2N12",
                "FUNCEX12_XQMOV2N12",
                "FUNCEX12_XQOUTTRANS2N12",
                "FUNCEX12_XQPES2N12",
                "FUNCEX12_XVMAQEQU2N12",
                "FUNCEX12_XVMETBAS2N12",
                "FUNCEX12_XVMOV2N12",
                "FUNCEX12_XVPES2N12",
                "FUNCEX_XVMAQELET2N",
                "FUNCEX_XVMAQEQU2N",
                "FUNCEX_XVMETBAS2N",
                "FUNCEX_XVMOV2N",
                "FUNCEX_XVOUTTRANS2N",
                "FUNCEX_XVPES2N",
                "FUNCEX_XPT",
                "FUNCEX_XVB",
                "FUNCEX12_XPT12",
                "FUNCEX12_XQAL2N12",
                "FUNCEX12_XQPRF2N12", 
                "FUNCEX12_XVAL2N12",
                "FUNCEX12_XVPRF2N12", 
                "FUNCEX_XVAL2N",
                "FUNCEX_XPB",
                "FUNCEX_XQB",
                "FUNCEX12_XQB12",
                "FUNCEX12_XQMAD2N12",
                "FUNCEX12_XQMET2N12",
                "FUNCEX12_XQMNM2N12",
                "FUNCEX12_XQPLAS2N12", 
                "FUNCEX12_XQFUMO2N12",
                "FUNCEX12_XVMAD2N12",
                "FUNCEX12_XVPLAS2N12", 
                "FUNCEX12_XVFARM2N12",
                "FUNCEX_XVMAD2N",
                "FUNCEX_XVMET2N",
                "FUNCEX_XVMNM2N",
                "FUNCEX_XVPLAS2N", 
                "FUNCEX_XVFUMO2N",
                "FUNCEX_XVFARM2N" ,
                "FUNCEX_XPM",
                "FUNCEX_XQM",
                "FUNCEX_XQS",
                "FUNCEX_XQT",
                "FUNCEX_XVM",
                "FUNCEX_XVS",
                "FUNCEX12_XPM12",
                "FUNCEX12_XQM12",
                "FUNCEX12_XQS12",
                "FUNCEX12_XQT12",
                "FUNCEX12_XQQUIM2N12",
                "FUNCEX12_XQTEXT2N12",
                "FUNCEX12_XQFARM2N12",
                "FUNCEX_XPFARM2N", 
                "FUNCEX_XQQUIM2N",
                "FUNCEX_XQFARM2N",
                "FUNCEX_XVQUIM2N", 
                "FUNCEX_XVTEXT2N",
                "FUNCEX12_MDVBKGCE12",
                "FUNCEX_MDVBK",
                "FUNCEX_MDVT",
                "FUNCEX12_MPAGP2N12",
                "FUNCEX12_XQVEIC2N12", 
                "FUNCEX12_MQAGP2N12",
                "FUNCEX12_MQBEB2N12",
                "FUNCEX12_MQVEST2N12", 
                "FUNCEX12_MVAGP2N12",
                "FUNCEX12_MVBEB2N12",
                "FUNCEX12_MVVEST2N12", 
                "FUNCEX12_XVVEIC2N12",
                "FUNCEX_MPAGP2N",
                "FUNCEX_MPVEST2N", 
                "FUNCEX_MQAGP2N",
                "FUNCEX_MQVEST2N", 
                "FUNCEX_MVAGP2N",
                "FUNCEX_MVBEB2N",
                "FUNCEX_MVVEST2N", 
                "FUNCEX_XVVEIC2N",
                "FUNCEX12_MDPBIGCE12",
                "FUNCEX12_MDPBKGCE12",
                "FUNCEX12_MDQBCDGCE12", 
                "FUNCEX12_MDQBCNDGCE12", 
                "FUNCEX12_MDQBKGCE12",
                "FUNCEX12_MDVBCDGCE12", 
                "FUNCEX12_MDVBCNDGCE12", 
                "FUNCEX12_MDVBIGCE12",
                "FUNCEX_MDPBCD",
                "FUNCEX_MDPBCND", 
                "FUNCEX_MDPBI",
                "FUNCEX_MDPBK",
                "FUNCEX_MDQBCD", 
                "FUNCEX_MDQBCND", 
                "FUNCEX_MDQBK",
                "FUNCEX_MDVBCD", 
                "FUNCEX_MDVBCND", 
                "FUNCEX_MDVBI",
                "FUNCEX12_MDPCOMBGCE12",
                "FUNCEX12_MDQBIGCE12",
                "FUNCEX12_MDQCOMBGCE12", 
                "FUNCEX12_MDVCOMBGCE12",
                "FUNCEX_MDQBI",
                "FUNCEX_MDQCOMB", 
                "FUNCEX_MDVCOMB",
                "FUNCEX12_MPPAP2N12",
                "FUNCEX12_MPPETCOMB2N12",
                "FUNCEX12_MQCAL2N12",
                "FUNCEX12_MQPAP2N12",
                "FUNCEX12_MVPAP2N12",
                "FUNCEX12_MVPETCOMB2N12",
                "FUNCEX_MPPETCOMB2N",
                "FUNCEX_MVCAL2N",
                "FUNCEX_MVPAP2N",
                "FUNCEX_MVPETCOMB2N",
                "FUNCEX12_MDVBNCGCE12",
                "FUNCEX12_MQMAQINF2N12",
                "FUNCEX12_MQPETCOMB2N12", 
                "FUNCEX12_MVMAQINF2N12",
                "FUNCEX_MQMAQINF2N",
                "FUNCEX_MQPETCOMB2N", 
                "FUNCEX_MVEMM2N",
                "FUNCEX_MVMAQINF2N", 
                "FUNCEX_MVECARV2N",
                "FUNCEX12_MPEPET2N12",
                "FUNCEX12_MQEMM2N12",
                "FUNCEX12_MQEMNM2N12", 
                "FUNCEX12_MQEPET2N12",
                "FUNCEX12_MQDIV2N12",
                "FUNCEX12_MQIMQG2N12", 
                "FUNCEX12_MVEPET2N12",
                "FUNCEX12_MVMAQEQU2N12", 
                "FUNCEX12_MVDIV2N12",
                "FUNCEX_MPEPET2N",
                "FUNCEX_MQDIV2N",
                "FUNCEX_MVEMNM2N", 
                "FUNCEX_MVEPET2N",
                "FUNCEX_MVDIV2N",
                "FUNCEX_MVIMVG2N",
                "FUNCEX_MDPT",
                "FUNCEX12_MDPT12",
                "FUNCEX12_MQMAQELET2N12",
                "FUNCEX12_MQMAQEQU2N12",
                "FUNCEX12_MQMETBAS2N12",
                "FUNCEX12_MQMOV2N12",
                "FUNCEX12_MQOUTTRANS2N12",
                "FUNCEX12_MQPRF2N12",
                "FUNCEX12_MQPES2N12",
                "FUNCEX12_MVAL2N12",
                "FUNCEX12_MVMAQELET2N12",
                "FUNCEX_MVAL2N",
                "FUNCEX_MVMAQELET2N", 
                "FUNCEX_MVMAQEQU2N",
                "FUNCEX_MVMETBAS2N",
                "FUNCEX_MVMOV2N",
                "FUNCEX_MVOUTTRANS2N",
                "FUNCEX_MVPES2N",
                "FUNCEX12_MQAL2N12",
                "FUNCEX12_MQMAD2N12", 
                "FUNCEX12_MQMET2N12",
                "FUNCEX12_MQMNM2N12",
                "FUNCEX12_MQPLAS2N12", 
                "FUNCEX12_MQFUMO2N12",
                "FUNCEX12_MQFARM2N12",
                "FUNCEX12_MVPLAS2N12",
                "FUNCEX12_MVFARM2N12",
                "FUNCEX_MPFARM2N",
                "FUNCEX_MVMAD2N",
                "FUNCEX_MVMET2N",
                "FUNCEX_MVMNM2N",
                "FUNCEX_MVPLAS2N", 
                "FUNCEX_MVQUIM2N",
                "FUNCEX_MVFUMO2N",
                "FUNCEX_MVFARM2N" ,
                "FUNCEX_MDQT",
                "FUNCEX12_MDQT12", 
                "FUNCEX12_MQQUIM2N12", 
                "FUNCEX12_MQTEXT2N12",
                "FUNCEX12_MQVEIC2N12",
                "FUNCEX12_MVVEIC2N12",
                "FUNCEX_MQQUIM2N",
                "FUNCEX_MVTEXT2N",
                "FUNCEX_MVVEIC2N",
                "FUNCEX12_TTR12",
                "FUNCEX_TTR",
                "SECEX12_MVTOT12",
                "SECEX12_XVTOT12",
                "SECEX12_MBENCAPGCE12",
                "SECEX12_MBENCONGCE12",
                "SECEX12_XBENCAPGCE12",
                "SECEX12_XBENCONGCE12"
                
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 4
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nome_completo = nomeCompleto, formato = formato, per = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivel_geog = nivelGeografico,localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "setor_externo_ipea_2.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para o setor real
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "ABRAS12_INVNR12",
  "ANDA12_VFERTILIZ12",
  "ANDA_VFERTILIZ",
  "ANP12_CALCO12",
  "ANP12_CDEPET12",
  "ANP12_CGASOL12",
  "ANP12_COLDIE12",
  "CNI12_VENREA12",
  "CNI12_VENRED12",
  "ELETRO12_CEECO12",
  "ELETRO12_CEENE12",
  "ELETRO12_CEENO12",
  "ELETRO12_CEESE12",
  "ELETRO12_CEESU12",
  "ELETRO12_CEECOM12",
  "ELETRO12_CEEIND12",
  "ELETRO12_CEERES12",
  "ELETRO12_CEET12",
  "ELETRO12_CEETCOM12",
  "ELETRO12_CEETIND12",
  "ELETRO12_CEETRES12",
  "ELETRO12_CEETT12",
  "ELETRO12_CEEOUT12",
  "FCESP12_IICA12",
  "FENABRAVE12_VENDVETOT12",
  "FENABRAVE12_VENDAUTO12",
  "SCN10_IPBN10",
  "SCN10_CFGGN10", 
  "SCN10_FBKFN10",
  "SCN10_VESTON10", 
  "SCN10_XBSZN10",
  "SCN10_MBSZN10",
  "SCN10_CFGG10",
  "SCN10_FBKFG10", 
  "SCN10_XBSZG10",
  "SCN10_MBSZG10",
  "SCN10_VAAGRON10", 
  "SCN10_VAINDN10",
  "SCN10_VAEMN10",
  "SCN10_VAITN10",
  "SCN10_VACON10",
  "SCN10_VAAGROG10", 
  "SCN10_VAINDG10",
  "SCN10_VAEMG10",
  "SCN10_VAITG10",
  "SCN10_VACOG10",
  "SCN10_PIBN10",
  "SCN10_DIPIBG10",
  "SCN10_PIBG10",
  "SCN10_PIBPBN10",
  "SCN10_VASERVN10", 
  "SCN10_VACOMN10",
  "SCN10_VATRAN10",
  "SCN10_VAADMN10",
  "SCN10_PIBPBG10",
  "SCN10_VASERVG10",
  "GAC12_FBKFCAMI12",
  "GAC12_CABI12",
  "GAC12_CABC12",
  "GAC12_CABCD12", 
  "GAC12_CABCND12", 
  "GAC12_FBKFCAMIDESSAZ12",
  "GAC12_CABIDESSAZ12",
  "GAC12_CABCDESSAZ12",
  "GAC12_CABCDDESSAZ12", 
  "GAC12_CABCNDDESSAZ12", 
  "GAC12_CABEB12",
  "GAC12_CACOU12",
  "GAC12_CAPAPEL12", 
  "GAC12_CABEBDESSAZ12", 
  "GAC12_CACOUDESSAZ12",
  "GAC12_CAIEX12",
  "GAC12_CAIEXDESSAZ12",
  "GAC12_CAIG12",
  "GAC12_CAIT12",
  "GAC12_CAIGDESSAZ12",
  "GAC12_CAITDESSAZ12",
  "GAC12_CAVEST12",
  "GAC12_CAIMP12",
  "GAC12_CAPET12",
  "GAC12_CAINFO12", 
  "GAC12_CAELET12",
  "GAC12_CAEQUIP12", 
  "GAC12_CAVESTDESSAZ12",
  "GAC12_CAPAPELDESSAZ12", 
  "GAC12_CAIMPDESSAZ12",
  "GAC12_CAPETDESSAZ12",
  "GAC12_CAINFODESSAZ12", 
  "GAC12_CAEQUIPDESSAZ12",
  "GAC12_CAALIM12",
  "GAC12_CAFUM12",
  "GAC12_CAMAD12",
  "GAC12_CABORR12", 
  "GAC12_CAMET12",
  "GAC12_CAOUT12",
  "GAC12_CAMOV12",
  "GAC12_CAALIMDESSAZ12",
  "GAC12_CAFUMDESSAZ12",
  "GAC12_CAMADDESSAZ12",
  "GAC12_CABORRDESSAZ12", 
  "GAC12_CAMETDESSAZ12",
  "GAC12_CAELETDESSAZ12", 
  "GAC12_CAOUTDESSAZ12",
  "GAC12_CAMOVDESSAZ12",
  "GAC12_INDFBCF12",
  "GAC12_INDFBCFCC12", 
  "GAC12_INDFBCFDESSAZ12",
  "GAC12_INDFBCFCCDESSAZ12",
  "GAC12_CATEX12",
  "GAC12_CAQUI12",
  "GAC12_CAFARM12", 
  "GAC12_CAMIN12",
  "GAC12_CAMETAL12", 
  "GAC12_CAAUTO12",
  "GAC12_CATEXDESSAZ12",
  "GAC12_CAQUIDESSAZ12",
  "GAC12_CAFARMDESSAZ12", 
  "GAC12_CAMINDESSAZ12",
  "GAC12_CAMETALDESSAZ12", 
  "GAC12_CAAUTODESSAZ12",
  "ABPO12_PAPEL12",
  "ANDA12_PFERTILIZ12",
  "ANDA_PFERTILIZ",
  "CNI12_NUCAP12",
  "CNI12_NUCAPD12",
  "CNI12_INDE12",
  "CNI12_INDTE12",
  "CNI12_INDEE12",
  "CE12_CUTIND12",
  "IBSIE12_QSCFG12",
  "IBSIE12_QSCAB12",
  "IBSIE12_QSCL12",
  "ONS12_HIDR12",
  "ONS12_CONV12",
  "ANTAQ_CARGCABOT",
  "ANTAQ_CARG",
  "AETT_RODAUTOMOV",
  "AETT_RODCAMINH",
  "AETT_RODONIBUS",
  "AETT_RODVEICAUT",
  "DIMAC_CF_INVBR_TOT12",
  "DIMAC_CF_INVBR_CTR12",
  "DIMAC_CF_INVBR_MQEQ12",
  "DIMAC_CF_INVBR_OUT12",
  "DIMAC_CF_INVLQ_CTR12",
  "DIMAC_CF_INVLQ_MQEQ12",
  "DIMAC_CF_INVLQ_OUT12",
  "DIMAC_CF_INVBR_TOT",
  "DIMAC_CF_INVBR_CTR",
  "DIMAC_CF_INVBR_MQEQ",
  "DIMAC_CF_INVBR_OUT",
  "DIMAC_CF_INVLQ_OUT",
  "DIMAC_CF_INVLQ_TOT12",
  "DIMAC_CF_INVLQ_TOT",
  "DIMAC_CF_INVLQ_CTR",
  "DIMAC_CF_INVLQ_MQEQ",
  "DIMAC_CF_RCP4",
  "DIMAC_CF_RCP",
  "DIMAC_CF_ELC_CTR12",
  "DIMAC_CF_ELC_MQEQ12",
  "DIMAC_CF_ELC_OUT12",
  "DIMAC_CF_DPR_TOT12",
  "DIMAC_CF_DPR_CTR12",
  "DIMAC_CF_DPR_MQEQ12",
  "DIMAC_CF_DPR_OUT12",
  "DIMAC_CF_ELC_OUT",
  "DIMAC_CF_DPR_CTR",
  "DIMAC_CF_DPR_MQEQ",
  "DIMAC_CF_DPR_OUT",
  "DIMAC_CF_ELC_TOT12",
  "DIMAC_CF_ELC_TOT",
  "DIMAC_CF_ELC_CTR",
  "DIMAC_CF_ELC_MQEQ",
  "DIMAC_CF_DPR_TOT",
  "WDI_PIBPPCRBRA",
  "WDI_PIBPPCBRA",
  "WDI_PIBPPCCAPRBRA",
  "WDI_PIBPPCCAPBRA"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 2
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "setor_real_ipeadata_2.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para expectativas
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "CNC12_ICAEC12",
  "CNC12_IEEC12",
  "CNC12_ICEC12",
  "CNC12_ICFAB12",
  "CNC12_ICFAC12",
  "CNC12_ICF12",
  "CNC12_IIEC12"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 12
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "expectativas_ipeadata.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para crédito
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "CNC12_PEICA12",
  "CNC12_PEICSC12",
  "CNC12_PEICRC12",
  "CNC12_PEICT12"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 6
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "credito_ipeadata.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para agropecuária
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "DEPAE_SAFRAAREA",
  "DEPAE_SAFRA"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 9
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "agropecuaria_ipeadata.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para dados internacionais
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "ECONMI12_USPCG12",
  "ECONMI4_USPIBG34",
  "ECONMI4_USPIBG4",
  "GM12_DOW12",
  "GM12_NASDAQ12",
  "GM366_DOW366",
  "SGS366_NASDAQ366",
  "VALOR12_TNOTES212", 
  "VALOR12_TNOTES512",
  "VALOR12_TNOTES1012", 
  "VALOR12_TBOND3012",
  "BLS12_IPAEUA12",
  "BLS12_IPCEUA12",
  "BLS12_IPCEUAS12" 
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 13
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "internacional_ipeadata.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para preços
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "IFS12_BEEFB12",
  "IFS12_MAIZE12",
  "IFS12_PETROLEUM12",
  "IFS_PETROLEUM",
  "IFS_SOJAGP",
  "IFS12_SOJAGP12"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 1
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "precos_ipeadata.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para mercado de trabalho
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "CNI12_PEEMP12",
  "CNI12_PEEMPD12",
  "PNADC12_PI12",
  "PNADC12_FT12",
  "PNADC12_PO12",
  "PNADC12_PD12",
  "PNADC12_FFT12", 
  "PNADC12_OCUPAGR12",
  "PNADC12_OCUPCOM12",
  "PNADC12_OCUPALOJ12", 
  "PNADC12_OCUPPUB12",
  "PNADC12_NOCUP12",
  "PNADC12_NDESOC12", 
  "PNADC12_FTDES12",
  "PNADC12_ESPCC12",
  "PNADC12_ESPSC12",
  "PNADC12_ESPUB12",
  "PNADC12_EMPGDOR12", 
  "PNADC12_CP12",
  "PNADC12_OCUPIG12",
  "PNADC12_OCUPCONST12",
  "PNADC12_ESP12",
  "PNADC12_ESPC12", 
  "PNADC12_ESPUBCC12", 
  "PNADC12_ESPUBSC12",
  "PNADC12_ESPUBMIL12", 
  "PNADC12_EMPGDORCCNPJ12", 
  "PNADC12_EMPGDORSCNPJ12",
  "PNADC12_CPCCNPJ12",
  "PNADC12_CPSCNPJ12",
  "PNADC12_TRDOM12",
  "PNADC12_TFA12",
  "PNADC12_OCUPTRANS12",
  "PNADC12_OCUPINFO12",
  "PNADC12_OCUPOUT12",
  "PNADC12_OCUPDOM12",
  "PNADC12_TPART12",
  "PNADC12_TDESOC12", 
  "PNADC12_OCUPCONT12", 
  "PNADC12_TRDOMCC12",
  "PNADC12_TRDOMCS12",
  "PNADC12_TSUBOC12",
  "PNADC12_TDESSUBOC12",
  "PNADC12_FTSUBOCU12",
  "PNADC12_RTH12",
  "PNADC12_RRTH12", 
  "PNADC12_RTE12",
  "PNADC12_RRTE12", 
  "PNADC12_RRPH12",
  "PNADC12_RRPE12",
  "PNADC12_RRPHEMP12", 
  "PNADC12_RRPHIG12", 
  "PNADC12_MRTH12",
  "PNADC12_MRRTH12", 
  "PNADC12_MRTE12",
  "PNADC12_MRRTE12", 
  "PNADC12_RRPHESPCC12", 
  "PNADC12_RRPHESPSC12",
  "PNADC12_RRPHESPUB12",
  "PNADC12_RRPHAGR12",
  "PNADC12_RRPHPUB12",
  "MTE12_SALMIN12"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 3
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "merc_trabalho_ipeadata_2.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para fiscal
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "SRF12_COFINS12",
  "SRF12_CSLL12",
  "SRF12_II12",
  "SRF12_IOF12", 
  "SRF12_IPI12",
  "SRF12_IR12",
  "SRF12_IRPF12", 
  "SRF12_IRPJ12",
  "SRF12_PIS12",
  "SRF12_CIDE12", 
  "SRF12_TOTGER12",
  "MPAS12_ARRBT12",
  "MPAS12_ARRLIQ12",
  "MPAS12_BENPREV12",
  "MPAS12_RESPRGPS12"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 7
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "fiscal_ipeadata_3.xlsx")

#_______________________________________________________________________________________________________________________
# carregar os dados do IPEADATA para mercado financeiro e de capitais
#_______________________________________________________________________________________________________________________
# lista de codigos
lista_cod <- c(
  "ANBIMA12_IBVSP12",
  "ANBIMA366_TJTLN1366",
  "ANBIMA366_TJTLN3366", 
  "ANBIMA366_TJTLN6366",
  "ANBIMA366_TJTLN12366", 
  "ANBIMA12_TJTLN112",
  "ANBIMA12_TJTLN312",
  "ANBIMA12_TJTLN612",
  "ANBIMA12_TJTLN1212",
  "GM366_IBVSP366",
  "BMF366_FUT1DI1366",
  "BMF366_FUT6DI1366",
  "BMF12_SWAPDI180F12", 
  "BMF12_SWAPDI360F12",
  "BMF12_SWAPDI36012"
)

lista_ipea <- list()
base_df_ipea <- data.frame()

for(i in lista_cod){
  metadados <- fromJSON(paste0("http://www.ipeadata.gov.br/api/odata4/Metadados('",i,"')"))
  dados_df <- as.data.frame(metadados[2]$value)
  
  if(dados_df$PERNOME=="Mensal"){
    dados_df$periodicidade <- "M"
  } else if(dados_df$PERNOME=="Diária"){
    dados_df$periodicidade <- "D"
  } else if(dados_df$PERNOME=="Anual"){
    dados_df$periodicidade <- "A"
  } else if(dados_df$PERNOME=="Trimestral"){
    dados_df$periodicidade <- "T"
  } else {
    dados_df$periodicidade <- ''
  }
  
  if(is.na(dados_df$MULNOME)){
    dados_df$formato <- dados_df$UNINOME
  } else {
    dados_df$formato <- paste0(dados_df$UNINOME, " ", dados_df$MULNOME)
  }
  
  dados_df$metrica <- dados_df$SERNOME
  dados_df$categoria <- NA
  
  
  lista_ipea[[i]] <- dados_df
}
df <- do.call("rbind",lista_ipea)
df2 <- as.data.frame(df)
base_df_2 <- bind_rows(base_df_ipea, df2)


lista_ipea_2 <- list()

for(i in lista_cod){
  
  base_filt <- base_df_2[base_df_2$SERCODIGO==i,]
  
  numero <- UUIDgenerate()
  nome <- base_filt$SERNOME
  nomeCompleto <- base_filt$SERNOME
  descricao <- str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informações:")
  descricao <- ifelse(is.na(descricao[,2]), base_filt$SERCOMENTARIO, descricao[,2])
  descricao2 <-  str_match(base_filt$SERCOMENTARIO, "^(.*?) Mais informação:")
  descricao <- ifelse(is.na(descricao2[,2]), descricao, descricao2[,2])
  formato <- base_filt$formato
  fonte <- "IPEADATA"
  
  urlAPI <- paste0("http://www.ipeadata.gov.br/api/odata4/ValoresSerie(SERCODIGO='",i,"')")
  idAssunto <- 7
  periodicidade <- base_filt$periodicidade
  metrica <- base_filt$metrica
  nivelGeografico <- "Brasil"
  localidades <- "Brasil"
  categoria <- base_filt$categoria
  
  lista_ipea_2[[i]] <- data.frame(nula = NA, cod = NA, nomeCompleto = nomeCompleto, formato = formato, 
                                  periodicidade = periodicidade,
                                  inicio = NA, fim = NA, fonte_orig = NA, esp = NA, met = NA, nome = nome, 
                                  descricao = descricao, fonte = fonte, urlAPI = urlAPI, idAssunto = idAssunto, 
                                  nivelGeografico = nivelGeografico, localidades = localidades, categoria = categoria,  
                                  metrica = metrica)
}
teste <- do.call("rbind",lista_ipea_2)
teste2 <- as.data.frame(teste)

write_xlsx(teste2, "merc_financ_ipeadata.xlsx")
