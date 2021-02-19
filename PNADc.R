#   rm(list=ls())

options(editor = 'notepad')
library(tidyverse)
library(PNADcIBGE)
library(survey)
# _____________________________________________________


# variáveis PNADc ----

variaveis <- 
  c('Ano'      ,	#      Ano de referência
    'Capital'  ,	#      Município da Capital
    'RM_RIDE'  ,	#      Região Metropolitana e Região Administrativa Integrada de Desenvolvimento"
    'Trimestre',	#      Trimestre de referência
    'UF'       ,	#      Unidade da Federação
    'V3009'    ,	#      Qual foi o curso mais elevado que ... frequentou anteriormente?
    'V4009'    ,	#      Quantos trabalhos ... tinha na semana de ... a ... (semana de referência ?
    'V4010'    ,	#      Código da ocupação (cargo ou função)
    'V4012'    ,	#      Nesse trabalho, ... era: 
    'V4013'    ,	#      Código da principal atividade desse negócio/empresa 
    'V4033'    ,	#      Qual era o rendimento bruto mensal que ... recebia/fazia  normalmente nesse trabalho? (variável auxiliar)
    'V403312'  ,	#      Qual era o rendimento bruto/retirada mensal que ... recebia/fazia normalmente nesse trabalho ? (valor em dinheiro)
    'V40341'   ,	#      Recebeu/fez nesse trabalho rendimento/retirada em dinheiro no mês de referência
    'V403412'  ,	#      Qual foi o rendimento bruto/retirada que ... recebeu/fez nesse trabalho, no mês de referência ? (valor em dinheiro)
    'V4041'    ,	#      Código da ocupação (cargo ou função)
    'V4043'    ,	#      Nesse trabalho secundário, ... era 
    'V4044'    ,	#      Código da principal atividade desse negócio/empresa
    'V4046'    ,	#      Esse negócio/empresa era registrado no Cadastro Nacional da Pessoa Jurídica - CNPJ?
    'V4050'    ,	#      Qual era o rendimento bruto mensal que ... recebia/fazia  normalmente nesse trabalho secundário? (variável auxiliar)
    'V40501'   ,	#      Recebia/fazia normalmente nesse trabalho secundário rendimento/retirada em dinheiro
    'V405012'  ,	#      Valor em dinheiro do rendimento mensal que recebia normalmente nesse trabalho secundário
    'V4051'    ,	#      Qual foi o rendimento bruto que ... recebeu/fez  nesse trabalho secundário, no mês de referência? (variável auxiliar)
    'V40511'   ,	#      Recebeu/fez nesse trabalho secundário rendimento/retirada em dinheiro no mês de referência
    'V405112'  ,	#      Valor em dinheiro do rendimento mensal que recebeu nesse trabalho secundário no mês de referência
    'V40581'   ,	#      Recebia/fazia normalmente nesse(s) outro(s) trabalho(s)  rendimento/retirada em dinheiro
    'V405812'  ,	#      Valor em dinheiro do rendimento mensal que recebia normalmente nesse(s) outro(s) trabalho(s) 
    'V4059'    ,	#      Qual foi o rendimento bruto que ... recebeu/fez  nesse(s) outro(s) trabalho(s), no mês de referência? (variável auxiliar)
    'V40591'   ,	#      Recebeu/fez nesse(s) outro(s) trabalho(s) rendimento/retirada em dinheiro no mês de referência
    'V405912'  ,	#      Valor em dinheiro do rendimento mensal que recebeu nesse(s) outro(s) trabalho(s) no mês de referência
    'VD4007'   ,	#      Posição na ocupação no trabalho principal da semana de referência para pessoas de 14 anos ou mais de idade
    'VD4008'   ,	#      Posição na ocupação no trabalho principal da semana de referência para pessoas de 14 anos ou mais de idade (com subcategorias de empregados)
    'VD4009'   ,	#      Posição na ocupação e categoria do emprego do trabalho principal da semana de referência para pessoas de 14 anos ou mais de idade
    'VD4010'   ,	#      Grupamentos de atividade principal do empreendimento do trabalho principal da semana de referência para pessoas de 14 anos ou mais de idade
    'VD4011'   ,	#      Grupamentos ocupacionais do trabalho principal da semana de referência para pessoas de 14 anos ou mais de idade
    'VD4016'   ,	#      Rendimento mensal habitual do trabalho principal para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias no trabalho principal)
    'VD4017'   ,	#      Rendimento mensal efetivo do trabalho principal para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias no trabalho principal)
    'VD4019'   ,	#      Rendimento mensal habitual de todos os trabalhos para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias em qualquer trabalho)
    'VD4020'    	#      Rendimento mensal efetivo de todos os trabalhos para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias em qualquer trabalho)
  )

# ciclo de download ----

#for (ano in 2018:2020) {
#  for (trimestre in 1:4) {
#    
#      get_pnadc(
#      year = ano,
#      quarter = trimestre,
#      vars = variaveis,
#      savedir = "D:/Users/humberto.serna/Documents/CSV_Data/PNAD/"
#      )
#    }}


# Análise ----

arquivos <- 
  c("PNADC_012018_20190729.txt",
    "PNADC_012019_20190729.txt",
    "PNADC_012020.txt",
    "PNADC_022018_20190729.txt",
    "PNADC_022019.txt",
    "PNADC_022020.txt",
    "PNADC_032018_20190729.txt",
    "PNADC_032019.txt",
    "PNADC_042018_20190729.txt",
    "PNADC_042019.txt")

PNADC_2020_1T <-
  pnadc_design(
    pnadc_labeller(
    data_pnadc = read_pnadc(
      microdata = paste(getwd(), "/CSV_Data/PNAD/", arquivos[3], sep = ""),
      input_txt = paste(
        getwd(),
        "/CSV_Data/PNAD/",
        "input_PNADC_trimestral.txt",
        sep = ""
      ),
      vars = variaveis
    ),
    dictionary.file = paste(
      getwd(),
      "/CSV_Data/PNAD/",
      "dicionario_PNADC_microdados_trimestral.xls",
      sep = ""
    )))


  PNADC_2020_2T <-
  pnadc_design(
    pnadc_labeller(
      data_pnadc = read_pnadc(
        microdata = paste(getwd(), "/CSV_Data/PNAD/", arquivos[6], sep = ""),
        input_txt = paste(
          getwd(),
          "/CSV_Data/PNAD/",
          "input_PNADC_trimestral.txt",
          sep = ""
        ),
        vars = variaveis
      ),
      dictionary.file = paste(
        getwd(),
        "/CSV_Data/PNAD/",
        "dicionario_PNADC_microdados_trimestral.xls",
        sep = ""
      )))
  
