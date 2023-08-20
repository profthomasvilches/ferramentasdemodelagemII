
# Lendo pacotes -----------------------------------------------------------

library(tidyverse)
library(pdftools)



# Para checar -------------------------------------------------------------

# Mr. Thomas Nogueira Vilches
# Thomas Nogueira Vilches   

# Thomas Vilches
# Thomas Nogueira

# THOMAS NOGUEIRA VILCHES
# thomas.vilches@unesp.br
# thomas1991

# 12313245603
# 12313245603


# Algumas regras ----------------------------------------------------------


#.
# \.
# \s x \S
# {} repetiçao

# .[]-{}^$*+?()|

#. -> qualquer caracter
#[] -> qualquer caracter aqui dentro
# - -> intervalo (dentro do [])
#{} -> repetição

#^ -> início da linha
#$ -> final da linha

#* -> zero ou mais
#+ -> um ou mais

# ? --> pode haver

#() -> grupo
#| -> ou

# https://regexr.com/

# Lendo PDF ---------------------------------------------------------------


pdf <- pdf_text("cadastro.pdf")
pdf <- str_split_1(pdf, "\\n")
pdf

# Vamos achar as diferentes tabelas

# começo
inicios <- grep("[nN]ome", pdf)
finais <- grep("(cpf|CPF)", pdf)

# Vamos criar uma tabela estruturada com as infos

# Name, Alias, Date of Birth, Address, Number, City/Kingdom, ZIP code,
# Phone Area, Phone Number, ID number


# extraindo o nome!

x <- pdf[grepl("[nN]ome:", pdf)]
#gsub(padrao, padrao substituir, variavel)

x <- gsub("[nN]ome:", "", x)
x <- gsub("\\(.*\\)", "", x) # deletar parenteses com zero ou mais caracteres no meio

x <- trimws(x, "both") # recorta espaços sobrando

# extraindo o alias

y <- pdf[grepl("[nN]ome:", pdf)]

y <- str_extract(y, "\\(.*\\)")

y <- gsub("\\(\\w+ |\\)", "", y)


# Outra forma de extrair o ALIAS

y <- pdf[grepl("[nN]ome:", pdf)]
y <- str_extract(y, "(?<=\\(aka ).*(?=\\))")

# Teste exemplo

y <- pdf[grepl("[nN]ome:", pdf)]
y <- str_extract(y, "\\S+(?= \\(aka)")



# Titanic -----------------------------------------------------------------

# https://www.kaggle.com/code/elijahrona/analysis-with-regular-expressions-regex/input

titanic <- read.csv("titanic.csv") %>% 
  bind_rows(read.csv("titanicII.csv"))

titanic %>% 
  filter(grepl("Cumings", Name))

names(titanic)

# Extrair o nome
# Extrair o sobrenome
# Extrair o nome de Solteira (quando necessário)


