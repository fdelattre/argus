## caractéristiques intrinsèques
# finition, génération, phase, energie, millesime, alimentation, arbre_a_came,
# boite, capac_reservoir, carrosserie, cylindre_archi, cv, dt_deb_comm, dt_fin_comm,
# suralimentation, transmission


## performances
# conso_co2, conso_mixte, conso_ece, conso_eudc
# moteu_couple, moteu_cyl_cm3, moteu_din, moteu_nb_soupapes,moteu_regime_kw,
# nb_cylindre, perfo_accel_0_100, perfo_vitesse_max,
# veh_puissance_kw, veh_puiss_fisc

## ancienneté
# km, dt_1mec, dt_carte_grise, dt_achat, dt_vente

## taille
# dimen_empattement, dimen_hauteur, dimen_largeur, dimen_longueur, 
# poids_charge_utile, poids_pds_tot_vide, poids_ptac, poids_ptra,
# veh_portes, veh_vol_coffre, veh_vol_utile

## vente
# marque_vendeur, destination, frais_remise_etat_reel, premiere_main, departement_vente, region_vente

## autres
# prix_neuf, prix_neuf_opt


# étude des corrélations
pairs(~conso_co2 + conso_mixte + conso_ece + conso_eudc, data = dat)
pairs(~perfo_accel_0_100 + perfo_vitesse_max + prix_vente, data = dat)
pairs(~veh_puissance_kw + veh_puiss_fisc, data = dat)
pairs(~dimen_empattement + dimen_hauteur+ dimen_largeur+ dimen_longueur, data = dat, col = as.factor(dat$marque))  
pairs(~dimen_empattement + dimen_longueur, data = dat) 
pairs(~dimen_empattement + dimen_largeur, data = dat) 
pairs(~prix_neuf + prix_neuf_opt, data = dat)
pairs(~days_since_1mec + km, data=dat)

keepCol <- c("conso_co2", "perfo_accel_0_100", "veh_puissance_kw", "prix_neuf")

ggplot(data = dat)+
  geom_point(aes(x = 1:nrow(dat), y = prix_vente, col = marque))

ggplot(data = dat)+
  geom_density(aes(prix_vente, colour = nb_cylindre))

