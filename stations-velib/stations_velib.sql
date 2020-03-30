CREATE TABLE stations_velib (
	identifiant_station INT NOT NULL,
    nom_station VARCHAR NOT NULL,
    capacite_station INT NOT NULL,
    nb_bornettes_libres INT NOT NULL,
    nb_total_velos_dispo INT NOT NULL,
    velos_mecaniques_dispo INT NOT NULL,
    velos_electriques_dispo INT NOT NULL,
    borne_paiement_dispo VARCHAR NOT NULL,
    retour_velib_possible VARCHAR NOT NULL,
    derniere_actualisation TIMESTAMP NOT NULL,
    coordonnees VARCHAR NOT NULL,
    nom_communes_equipees VARCHAR NOT NULL,
    code_insee_communes_equipees VARCHAR
);

-- Run main.go