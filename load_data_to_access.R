install.packages("odbc")
install.packages("RODBC")
library(odbc)
library(RODBC)

all_q$start_time <- as.character(all_q$start_time)
all_q$end_time <- as.character(all_q$end_time)


access_file <- "all_q3.accdb"

conn <- odbcDriverConnect(paste0("Driver={Microsoft Access Driver (*.mdb, *.accdb)};",
                                 "DBQ=C:\\Users\\taj 1\\Documents\\R scr\\myCaseStudy\\n_q.accdb;" ))
sqlSave(conn,all_q, tablename = "all_q6", rownames = FALSE, append = FALSE)
close(conn)

conn <- dbConnect(odbc::odbc(),
               .connection_string = paste0("Driver={Microsoft Access Driver (*.mdb, *.accdb)};",
               "DBQ=C:\\Users\\taj 1\\Documents\\R scr\\myCaseStudy\\all_q.accdb;"))
dbWriteTable(conn, "all_q5", all_q, overwrite = TRUE, row.names = FALSE)
dbDisconnect(con)
print(conn)




