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
    SET transport_type = 'métro'
    WHERE 'name' <> UPPER('name');

-- Define RER stations with unique names

UPDATE ratp_stations SET transport_type = 'RER' WHERE "name" IN ('Achères Grand Cormier','Achères-Ville','Aéroport Charles de Gaulle 1','Aéroport Charles de Gaulle 2 TGV','Antony','Arcueil-Cachan','Auber','Aulnay-sous-Bois','Bagneux','Boissy-Saint-Léger','Bourg-la-Reine','Bry-sur-Marne','Bures-sur-Yvette','Bussy-Saint-Georges','Cergy-Le-Haut','Cergy-Préfecture','Cergy-Saint-Christophe','Champigny','Châtelet-Les Halles','Chatou-Croissy','Cité Universitaire','Conflans-Fin d''Oise','Courcelle-sur-Yvette','Denfert-Rochereau','Drancy','Fontaine-Michalon','Fontenay-aux-Roses','Fontenay-sous-Bois','Gentilly','Gif-sur-Yvette','Houilles Carrières-sur-Seine','Joinville-le-Pont','La Courneuve-Aubervilliers','La Croix-de-Berny','La Hacquinière','La Plaine-Stade de France','La Varenne-Chennevières','Laplace','Le Blanc-Mesnil','Le Bourget','Le Guichet','Le Parc de Saint-Maur','Le Vésinet-Centre','Le Vésinet-Le Pecq','Les Baconnets','Lognes','Lozère','Luxembourg','Maisons-Laffitte','Marne-la-Vallée Chessy','Massy-Palaiseau','Massy-Verrières','Mitry-Claye','Nanterre-Préfecture','Nanterre-Université','Nanterre-Ville','Neuilly-Plaisance','Neuville-Université','Nogent-sur-Marne','Noisiel','Noisy-Champs','Noisy-le-Grand (Mont d''Est)','Orsay-Ville','Palaiseau','Palaiseau Villebon','Parc de Sceaux','Parc des Expositions','Poissy','Port-Royal','Robinson','Rueil-Malmaison','Saint-Germain-en-Laye','Saint-Maur Créteil','Saint-Michel Notre-Dame','Saint-Rémy-lès-Chevreuse','Sartrouville','Sceaux','Sevran-Beaudottes','Sevran Livry','Sucy Bonneuil','Torcy','Val d''Europe','Val de Fontenay','Vert-Galant','Villeparisis','Villepinte','Vincennes');

-- Define RER stations which have metro stations with the same name

-- Charles de Gaulle - Étoile
UPDATE ratp_stations SET transport_type = 'RER' WHERE 'coordinates' = '48.8739040986,2.29503190105';
-- Gare de Lyon
UPDATE ratp_stations SET transport_type = 'RER' WHERE 'coordinates' = '48.844472156,2.3739114213';
-- Gare du Nord
UPDATE ratp_stations SET transport_type = 'RER' WHERE 'coordinates' = '48.8808392058,2.35657701535';
-- La Défense - Grande Arche
UPDATE ratp_stations SET transport_type = 'RER' WHERE 'coordinates' = '48.8918267548,2.23799204322';
-- Nation
UPDATE ratp_stations SET transport_type = 'RER' WHERE 'coordinates' = '48.8484448201,2.39590723714';


-- Define all exterior train stations

-- Add lines for each tain station

-- Remove identical db records