
# Lendo pacotes -----------------------------------------------------------

library(tidyverse)
library(pdftools)
library(lubridate)


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

# (?<=\\(aka )
# (?=\\))
# str_extract("Thomas", "o.a")

# CEP

z <- pdf[grepl("[Cc][Ee][pP]", pdf)]

z <- gsub(".*CEP: *", "", z)
z <- gsub("\\D", "", z)

z1 <- str_extract(z, "^\\d{5}")
z2 <- str_extract(z, "\\d{3}$")

z <- paste(z1, z2, sep = "-")


z <- pdf[grepl("[Cc][Ee][pP]", pdf)]

z <- str_extract(z, "(?<=CEP: )[\\d\\.\\-]+$")

z <- gsub("\\D", "", z)
z1 <- str_extract(z, "^\\d{5}")
z2 <- str_extract(z, "\\d{3}$")

z <- paste(z1, z2, sep = "-")

#CEP: 13000-000


# CPF: ??

cpf <- pdf[grepl("cpf:|CPF:", pdf)]

cpf <- gsub(".*[cC][pP][fF]: *", "", cpf)
cpf <- gsub("\\D", "", cpf)


# Tel: ??

tel <- pdf[grepl("Tel:?", pdf)]
tel <- gsub("\\D", "", tel)


tel1 <- str_extract(tel, "^\\d{2}")
tel2 <- str_extract(tel, "(?<=\\d{2})\\d{5}(?=\\d{4})")
tel3 <- str_extract(tel, "(?<=\\d{7})\\d{4}")

tel <- paste0("(", tel1, ") ", tel2, "-", tel3)


# Versão que o Maicon explicou
# Ótima solução

telefone <- pdf[grepl("Tel:|Telefone:",pdf)]
telefone <- gsub("Tel:|Telefone:|[-\\(\\)]","",telefone)
telefone <- gsub("\\s","",telefone)
telefone <- gsub("^(\\d{2})","(\\1)",telefone)
telefone <- gsub("^(.{9})", "\\1-", telefone)

# Data de nascimento


dt <- pdf[grepl("Da?ta? (de )?[Nn]asc",pdf)]

dt <- gsub(".*:", "", dt)

obs_dt <- str_extract(dt, "[A-Za-z]+\\.[A-Za-z]+\\.?$")

dt <-trimws(dt, "both")

dt <- str_extract(dt, "\\d+[-/]\\d+[-/]\\d+(\\.\\d+)?|\\d+[-/]\\w+[-/]\\d+")
dt <- gsub("\\.", "", dt)

dt <- gsub("([-/])(\\d{3})$", "\\10\\2",dt)
# 
# dt_teste <- c("12-12-281", "12/12/281")
# gsub("[-/](\\d{3})$", "-0\\1",dt_teste)
# 
# gsub("([-/])(\\d{3})$", "\\10\\2",dt_teste)


# tarefa - organizar o endereço
# Rua/Local
# numero
# Cidade/Planeta

v <- pdf[grep("Endereço", pdf)]
v <- gsub("CEP.*", "", v)
v <- gsub("Endereço: *", "", v)

Numeros <- str_extract(v, "\\d+")
# ifelse(is.na(Numeros), "SN", Numeros)
lista_log <- str_split(v, ",")
Logradouro <- lapply(lista_log, function(x) x[1]) %>% Reduce(c, .)

Bairro <- gsub(".*,", "", v)

Bairro <- Bairro %>% trimws("both") %>% gsub("\\.", "", .)

dt_char <- dt

dt <- dmy(dt)

dmy("01/01/0900") %>% typeof()

# Teste exemplo

y <- pdf[grepl("[nN]ome:", pdf)]
y <- str_extract(y, "\\S+(?= \\(aka)")



# data frame

df <- data.frame(Nome = x, Alias = y, CEP = z, CPF = cpf,
           telefone, "Data de nascimento" = dt, Logradouro,
           Numero = Numeros, Bairro)

openxlsx::write.xlsx(df, "resultado.xlsx")

# Titanic -----------------------------------------------------------------

# https://www.kaggle.com/code/elijahrona/analysis-with-regular-expressions-regex/input

titanic <- read.csv("titanic.csv") %>% 
  bind_rows(read.csv("titanicII.csv"))

titanic %>% 
  filter(grepl("Cumings", Name))

pronome <- str_extract(titanic$Name, "[A-Za-z]+(?=\\.)")
sum(is.na(pronome))

lastname <- str_extract(titanic$Name, "[A-Za-z]+(?=,)")
titanic$Name[992]
name <- str_extract(titanic$Name, "(?<=\\. ).*(?=\\()|(?<=\\. ).*$")
name <- trimws(name, "both")

df <- data.frame(name, lastname, pronome, original = titanic$Name)
View(df)

unique(df$pronome)

str_extract(df$original, "(?<=\\().*(?=\\))")

df %>% 
  rowwise() %>% 
  mutate(
    singlename = case_when(
      grepl("Mrs|mrs|MRS|[cC]ountess|[lL]ady|Mlle", pronome) ~ str_extract(original, "(?<=\\().*(?=\\))"),
      TRUE ~ NA_character_
    )
  ) %>% View

df %>% 
  filter(grepl("Mr(s)?", pronome)) %>% View

x <- "Banana Nanana"

str_extract_all(x, "(?<=N).*(?=a)")

glimpse(titanic)
names(titanic)

# Extrair o nome
# Extrair o sobrenome
# Extrair o nome de Solteira (quando necessário)


# DATASUS -----------------------------------------------------------------

# https://datasus.saude.gov.br/transferencia-de-arquivos/#

library(read.dbc)

dados <- read.dbc("../dados/arquivo/PASP1801a.dbc")
glimpse(dados)

unique(dados$PA_RACACOR)
