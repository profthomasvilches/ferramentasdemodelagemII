source("functions.R", encoding = "UTF-8")

# dbGetQuery

senha <- read.table("senhas.txt", header = FALSE)



con <- DBI::dbConnect(odbc::odbc(),
                      Driver = "{PostgreSQL ODBC Driver(ANSI)}",
                      Database = "AulaPGII",
                      UserName = senha$V1[1],
                      Password = senha$V1[2],
                      Servername = "localhost",
                      Port = 5433,
                      encoding = "CP1252", 
                      # Encoding of R sessions, Windows R default is "CP1252" (Windows-1252)
                      clientcharset = "UTF-8")


odbc::dbListTables(con, schema_name = "sales")

customers <- dbGetQuery(conn = con, statement = "SELECT * FROM sales.customers")
funnel <- dbGetQuery(conn = con, statement = "SELECT * FROM sales.funnel")
head(funnel)
head(customers)


query <- "SELECT * FROM
sales.customers RIGHT JOIN sales.funnel ON
sales.customers.customer_id = sales.funnel.customer_id
"

tab_join <- dbGetQuery(conn = con, statement = query)

View(tab_join)




customers <- read_any(con, "sales.customers")
funnel <- read_any(con, "sales.funnel")
head(funnel)
head(customers)

con <- conecta_base()

names(funnel)


df <- data.frame(cpf = c("04568656604", "26344432978"), paid_date = c("2023-01-23", "2023-02-14"))

trocar_id(con, df, "cpf", "customer_id", "sales.customers")
