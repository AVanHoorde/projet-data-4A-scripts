CREATE TABLE ratp_stations (
    id INT NOT NULL,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    coordinates VARCHAR NOT NULL
);

-- Run main.go

ALTER TABLE ratp_stations
    ADD train_outside BOOLEAN DEFAULT FALSE NOT NULL,
    ADD transport_type VARCHAR DEFAULT 'bus' NOT NULL,
    ADD line VARCHAR NULL;
    
-- Define records with non-UPPERCASE names as metros

UPDATE ratp_stations
    SET transport_type = 'metro'
    WHERE 'name' <> UPPER('name');

-- Define RER stations with unique names

UPDATE ratp_stations SET transport_type = 'rer' WHERE "name" IN ('Achères Grand Cormier','Achères-Ville','Aéroport Charles de Gaulle 1','Aéroport Charles de Gaulle 2 TGV','Antony','Arcueil-Cachan','Auber','Aulnay-sous-Bois','Bagneux','Boissy-Saint-Léger','Bourg-la-Reine','Bry-sur-Marne','Bures-sur-Yvette','Bussy-Saint-Georges','Cergy-Le-Haut','Cergy-Préfecture','Cergy-Saint-Christophe','Champigny','Châtelet-Les Halles','Chatou-Croissy','Cité Universitaire','Conflans-Fin d''Oise','Courcelle-sur-Yvette','Denfert-Rochereau','Drancy','Fontaine-Michalon','Fontenay-aux-Roses','Fontenay-sous-Bois','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères','Achères');

-- Define RER stations which have metro stations with the same name

-- Charles de Gaulle - Étoile
UPDATE ratp_stations SET transport_type = 'rer' WHERE 'coordinates' = '48.8739040986,2.29503190105';
-- Gare de Lyon
UPDATE ratp_stations SET transport_type = 'rer' WHERE 'coordinates' = '48.844472156,2.3739114213';
-- Gare du Nord
UPDATE ratp_stations SET transport_type = 'rer' WHERE 'coordinates' = '48.8808392058,2.35657701535';


-- Define all exterior train stations

-- Add lines for each tain station

-- Remove identical db records