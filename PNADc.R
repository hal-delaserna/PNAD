#   rm(list=ls())

options(editor = 'notepad')
library(tidyverse)
library(PNADcIBGE)
library(survey)
# _____________________________________________________


# vari�veis PNADc ----

## VD = vari�veis derivadas

variaveis <- 
  c('Ano'      ,	#      Ano de refer�ncia
    #'Capital'  ,	#      Munic�pio da Capital
    #'RM_RIDE'  ,	#      Regi�o Metropolitana e Regi�o Administrativa Integrada de Desenvolvimento"
    'Trimestre',	#      Trimestre de refer�ncia
    'UF'       ,	#      Unidade da Federa��o
    #'V3009'    ,	#      Qual foi o curso mais elevado que ... frequentou anteriormente?
    #'V4009'    ,	#      Quantos trabalhos ... tinha na semana de ... a ... (semana de refer�ncia ?
    'V4010'    ,	#      C�digo da ocupa��o (cargo ou fun��o)
    #'V4012'    ,	#      Nesse trabalho, ... era: 
    #'V4013'    ,	#      C�digo da principal atividade desse neg�cio/empresa 
    #'V40132A'	, #      Qual a se��o da atividade?	4� tri/2015 - atual
    #'V4033'    ,	#      Qual era o rendimento bruto mensal que ... recebia/fazia  normalmente nesse trabalho? (vari�vel auxiliar)
    #'V403312'  ,	#      Qual era o rendimento bruto/retirada mensal que ... recebia/fazia normalmente nesse trabalho ? (valor em dinheiro)
    #'V40341'   ,	#      Recebeu/fez nesse trabalho rendimento/retirada em dinheiro no m�s de refer�ncia
    #'V403412'  ,	#      Qual foi o rendimento bruto/retirada que ... recebeu/fez nesse trabalho, no m�s de refer�ncia ? (valor em dinheiro)
    'V4041'    ,	#      C�digo da ocupa��o (cargo ou fun��o)
    #'V4043'    ,	#      Nesse trabalho secund�rio, ... era 
    #'V4044'    ,	#      C�digo da principal atividade desse neg�cio/empresa
    #'V4046'    ,	#      Esse neg�cio/empresa era registrado no Cadastro Nacional da Pessoa Jur�dica - CNPJ?
    #'V4050'    ,	#      Qual era o rendimento bruto mensal que ... recebia/fazia  normalmente nesse trabalho secund�rio? (vari�vel auxiliar)
    #'V40501'   ,	#      Recebia/fazia normalmente nesse trabalho secund�rio rendimento/retirada em dinheiro
    #'V405012'  ,	#      Valor em dinheiro do rendimento mensal que recebia normalmente nesse trabalho secund�rio
    #'V4051'    ,	#      Qual foi o rendimento bruto que ... recebeu/fez  nesse trabalho secund�rio, no m�s de refer�ncia? (vari�vel auxiliar)
    #'V40511'   ,	#      Recebeu/fez nesse trabalho secund�rio rendimento/retirada em dinheiro no m�s de refer�ncia
    #'V405112'  ,	#      Valor em dinheiro do rendimento mensal que recebeu nesse trabalho secund�rio no m�s de refer�ncia
    #'V40581'   ,	#      Recebia/fazia normalmente nesse(s) outro(s) trabalho(s)  rendimento/retirada em dinheiro
    #'V405812'  ,	#      Valor em dinheiro do rendimento mensal que recebia normalmente nesse(s) outro(s) trabalho(s) 
    #'V4059'    ,	#      Qual foi o rendimento bruto que ... recebeu/fez  nesse(s) outro(s) trabalho(s), no m�s de refer�ncia? (vari�vel auxiliar)
    #'V40591'   ,	#      Recebeu/fez nesse(s) outro(s) trabalho(s) rendimento/retirada em dinheiro no m�s de refer�ncia
    #'V405912'  ,	#      Valor em dinheiro do rendimento mensal que recebeu nesse(s) outro(s) trabalho(s) no m�s de refer�ncia
    
    'VD4007'   ,	#      Posi��o na ocupa��o no trabalho principal da semana de refer�ncia para pessoas de 14 anos ou mais de idade
    'VD4008'   ,	#      Posi��o na ocupa��o no trabalho principal da semana de refer�ncia para pessoas de 14 anos ou mais de idade (com subcategorias de empregados)
    'VD4009'   ,	#      Posi��o na ocupa��o e categoria do emprego do trabalho principal da semana de refer�ncia para pessoas de 14 anos ou mais de idade
    'VD4010'   ,	#      Grupamentos de atividade principal do empreendimento do trabalho principal da semana de refer�ncia para pessoas de 14 anos ou mais de idade
    'VD4011'   ,	#      Grupamentos ocupacionais do trabalho principal da semana de refer�ncia para pessoas de 14 anos ou mais de idade
    'VD4016'   ,	#      Rendimento mensal habitual do trabalho principal para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias no trabalho principal)
    'VD4017'   ,	#      Rendimento mensal efetivo do trabalho principal para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias no trabalho principal)
    'VD4019'   ,	#      Rendimento mensal habitual de todos os trabalhos para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias em qualquer trabalho)
    'VD4020'    	#      Rendimento mensal efetivo de todos os trabalhos para pessoas de 14 anos ou mais de idade (apenas para pessoas que receberam em dinheiro, produtos ou mercadorias em qualquer trabalho)
  )




# COD - Classifica��o de Ocupa��es para Pesquisas Domiciliares

variaveis_COD <- 
  c(
    '1322'   ,  #   	Dirigentes de explora��es de minera��o
    '2114'   ,  #   	Ge�logos e geof�sicos
    '2146'   ,  #   	Engenheiros de minas, metal�rgicos e afins
    '3117'   ,  #   	T�cnicos em engenharia de minas e metalurgia
    '3121'   ,  #   	Supervisores da minera��o
    '8111'   ,  #   	Mineiros e operadores de m�quinas e de instala��es em minas e pedreiras
    '8112'   ,  #   	Operadores de instala��es de processamento de minerais e rochas
    '8114'   ,  #   	Operadores de m�quinas para fabricar cimento, pedras e outros produtos minerais
    '9311'      #   	Trabalhadores elementares de minas e pedreiras 
)





# ciclo de download ----

for (ano in 2018:2020) {
  for (trimestre in 1:4) {
    
      get_pnadc(
      year = ano,
      quarter = trimestre,
      vars = variaveis,
      savedir = "D:/Users/humberto.serna/Documents/D_Lake"
      )
    }}


# An�lise ----

arquivos <- 
  c("PNADC_012018_20190729.txt",
    "PNADC_012019_20190729.txt",
    "PNADC_012020.txt",
    "PNADC_022018_20190729.txt",
    "PNADC_022019.txt",
    "PNADC_022020.txt",
    "PNADC_032018_20190729.txt",
    "PNADC_032019.txt",
    "PNADC_032020.txt",
    "PNADC_042018_20190729.txt",
    "PNADC_042019.txt"
    )




PNADC_2020_1T <-
  pnadc_design(
    pnadc_labeller(
    data_pnadc = read_pnadc(
      microdata = paste(getwd(), "/D_Lake/PNAD/microdados/", arquivos[3], sep = ""),
      input_txt = paste(
        getwd(),
        "/D_Lake/PNAD/microdados/",
        "input_PNADC_trimestral.txt",
        sep = ""
      ),
      vars = variaveis
    ),
    dictionary.file = paste(
      getwd(),
      "/D_Lake/PNAD/microdados/",
      "dicionario_PNADC_microdados_trimestral.xls",
      sep = ""
    )))


  PNADC_2020_2T <-
  pnadc_design(
    pnadc_labeller(
      data_pnadc = read_pnadc(
        microdata = paste(getwd(), "/D_Lake/PNAD/microdados/", arquivos[6], sep = ""),
        input_txt = paste(
          getwd(),
          "/D_Lake/PNAD/microdados/",
          "input_PNADC_trimestral.txt",
          sep = ""
        ),
        vars = variaveis
      ),
      dictionary.file = paste(
        getwd(),
        "/D_Lake/PNAD/microdados/",
        "dicionario_PNADC_microdados_trimestral.xls",
        sep = ""
      )))
  
