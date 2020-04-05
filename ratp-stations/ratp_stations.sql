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

-- Define RER stations which have metro stations with the same name by their coordinates
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

-- Define exterior train stations which have only 1 line
UPDATE ratp_stations SET train_outside = TRUE WHERE "name" IN ('Bir-Hakeim (Grenelle)','Cambronne','Châtillon Montrouge','Chevaleret','Corvisart','Dupleix','Glacière');

-- Define exterior train stations which have several lines by their coordinates
-- Bastille, Barbès-Rochechouart, Stalingrad, Jaurès, Gare d'Austerlitz, La Motte-Picquet-Grenelle
UPDATE ratp_stations SET train_outside = TRUE WHERE "coordinates" IN ('48.8533891123,2.36916460221','48.8839317699,2.3493557086','48.8841892942,2.36703044197','48.8827685467,2.36994579899','48.8437198614,2.36391621716','48.8490189283,2.29776216071');

-- Add lines for train stations which have only 1 line
UPDATE ratp_stations SET line = '1' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '2' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '3' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '3bis' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '4' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '5' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '6' WHERE "name" IN ('Bir-Hakeim (Grenelle)','Cambronne','Chevaleret','Corvisart','Dupleix','Glacière');
UPDATE ratp_stations SET line = '7' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '7bis' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '8' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '9' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '10' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '11' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '12' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = '13' WHERE "name" IN ('Châtillon Montrouge','');
UPDATE ratp_stations SET line = '14' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = 'A' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = 'B' WHERE "name" IN ('','');

-- Add lines for train stations which have several lines by their coordinates
-- Bastille, 
UPDATE ratp_stations SET line = '1' WHERE "coordinates" IN ('48.8533891123,2.36916460221','');
-- Barbès-Rochechouart, Stalingrad, Jaurès
UPDATE ratp_stations SET line = '2' WHERE "coordinates" IN ('48.8839317699,2.3493557086','48.8841892942,2.36703044197','48.8827685467,2.36994579899');
UPDATE ratp_stations SET line = '3' WHERE "coordinates" IN ('','');
UPDATE ratp_stations SET line = '3bis' WHERE "coordinates" IN ('','');
-- Barbès-Rochechouart, 
UPDATE ratp_stations SET line = '4' WHERE "coordinates" IN ('48.8836801093,2.34953280365','');
-- Bastille, Stalingrad, Jaurès, Gare d'Austerlitz
UPDATE ratp_stations SET line = '5' WHERE "coordinates" IN ('48.8529756747,2.36921882444','48.8841532631,2.36735747747','48.8823280249,2.37047696877','48.8437198614,2.36391621716');
-- La Motte-Picquet-Grenelle
UPDATE ratp_stations SET line = '6' WHERE "coordinates" IN ('48.8490189283,2.29776216071','');
-- Stalingrad
UPDATE ratp_stations SET line = '7' WHERE "coordinates" IN ('48.8840719864,2.36887006278','');
-- Jaurès
UPDATE ratp_stations SET line = '7bis' WHERE "coordinates" IN ('48.8828762162,2.37058633617','');
-- Bastille, La Motte-Picquet-Grenelle
UPDATE ratp_stations SET line = '8' WHERE "coordinates" IN ('48.853739623,2.36916481786','48.8488212667,2.29795296403');
UPDATE ratp_stations SET line = '9' WHERE "coordinates" IN ('','');
-- Gare d'Austerlitz, La Motte-Picquet-Grenelle
UPDATE ratp_stations SET line = '10' WHERE "coordinates" IN ('48.8434142241,2.36418839287','48.848803206,2.29769423466');
UPDATE ratp_stations SET line = '11' WHERE "coordinates" IN ('','');
UPDATE ratp_stations SET line = '12' WHERE "coordinates" IN ('','');
UPDATE ratp_stations SET line = '13' WHERE "coordinates" IN ('','');
UPDATE ratp_stations SET line = '14' WHERE "coordinates" IN ('','');
UPDATE ratp_stations SET line = 'A' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = 'B' WHERE "name" IN ('','');

-- Remove identical db records