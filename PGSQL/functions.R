

read_any <- function(db, table){
  
  
  tab <- odbc::dbGetQuery(
    db, paste0("SELECT * FROM ", table,";")
  )
  
  return(tab)
}

drop_table <- function(db, table){
  odbc::dbSendQuery(db, paste("drop table", table))
}


conecta_base <- function(){
  
  senha <- read.table("senhas.txt")
  
  db <- DBI::dbConnect(odbc::odbc(),
                       Driver = "{PostgreSQL ODBC Driver(ANSI)}",
                       Database = "DATASUS_PA",
                       UserName = senha$V1[1],
                       Password = senha$V1[2],
                       Servername = "localhost",
                       Port = 5433,
                       encoding = "CP1252", 
                       # Encoding of R sessions, Windows R default is "CP1252" (Windows-1252)
                       clientcharset = "UTF-8")
  return(db)
  
}


# pegar o data frame, utilizar a coluna X vindo da tabela Y
# para fazer join, e substituir a coluna pela Z
# 
# X = "cpf"
# Z = "customer_id"
# tabY = "sales.customers"
# 
# odbc::dbListTables(con, schema_name = "sales")

trocar_id <- function(con, df, X, Z, tabY){
  
  tab <- odbc::dbGetQuery(
    con, paste0("SELECT ", X,",",Z,  " FROM ", tabY,";")
  )
  
  df_novo <- df %>% 
    left_join(tab, by = X) %>% 
    select(-paste0(X))
    
  
  return(df_novo)
}


# 
# msg <- paste("CREATE TABLE ibge_idade (
#   idmunidade SERIAL PRIMARY KEY,
#   id_mun INTEGER,",
#              paste(names(dados)[seq(2, 15)], " INTEGER", collapse = ","),
#              ");")
# 
# odbc::dbSendQuery(db, msg)
# 
# read_any(db, "ibge_idade")
# 
# odbc::dbWriteTable(
#   db, name = "ibge_idade", value = dados,
#   row.names = FALSE, append = TRUE
# )
