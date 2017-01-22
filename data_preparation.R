library(data.table)
library(lubridate)
library(stringr)
library(ggplot2)
library(GGally)


dat <- fread("echantillon-dapprentissage.csv", 
             colClasses = c(dt_deb_comm = "character", dt_fin_comm = "character"),
             na.strings = c("NA", ".", " ", ""))

# summary(dat) # 78837 lignes
# str(dat)

dat[,id_challenge := NULL]

# lignes en doublon
dat <- dat[!duplicated(dat)]# 73565 lignes


# colonnes contenant bcp de NA
na.col.ratio <- apply(dat, 2, FUN = function(d){sum(is.na(d))}) / nrow(dat)
na.col.ratio[na.col.ratio > 0.3]
dat[, ":="(veh_vol_utile= NULL, option = NULL)]

# lignes contenant bcp de NA
na.rows.ratio <- apply(dat, 1, FUN = function(d){sum(is.na(d))}) / ncol(dat)
nrow(dat[which(na.rows.ratio > 0.3)]) # 5081 lignes avec plus de 33% de NA
dat <- dat[which(na.rows.ratio <= 0.3)]

 # décodage des dates
dat[, ":="(
  dt_1mec = parse_date_time(dt_1mec, "ymd"),
  dt_carte_grise = parse_date_time(dt_carte_grise, "ymd"),
  dt_achat = parse_date_time(dt_achat, "ymd"),
  dt_vente = parse_date_time(dt_vente, "ymd"),
  dt_deb_comm = parse_date_time(dt_deb_comm, "dmy"),
  dt_fin_comm = parse_date_time(dt_fin_comm, "dmy"))]

# calcul de durées
dat[, ":="(
  days_since_1mec = -(dt_vente %--% dt_1mec)/ddays(),
  days_since_carte_grise = -(dt_vente %--% dt_carte_grise)/ddays(),
  duree_vente = -(dt_vente %--% dt_achat)/ddays(),
  duree_comm = -(dt_fin_comm %--% dt_deb_comm)/ddays())]
 
