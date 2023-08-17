
# Lendo pacotes -----------------------------------------------------------

library(tidyverse)
library(pdftools)



# Para checar -------------------------------------------------------------

# Thomas Nogueira Vilches
# THOMAS NOGUEIRA VILCHES
# thomas.vilches@unesp.br
# thomas1991


# Algumas regras ----------------------------------------------------------


#.
# \.
# \s x \S
# {} repetiçao

# .[]-{}^$*+?()|

#. -> qualquer caracter
#[] -> qualquer caracter aqui dentro
#- -> intervalo (dentro do [])
#{} -> repetição
#^ -> início da linha
#$ -> final da linha
#* -> zero ou mais
#+ -> um ou mais
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
