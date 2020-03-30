CREATE TABLE hubs_nuisance_visuelle (
	identifiant INT NOT NULL,
    nom VARCHAR NOT NULL,
    coords VARCHAR NOT NULL,
    source VARCHAR NOT NULL,
    decibels INT NOT NULL
);

-- Run main.go