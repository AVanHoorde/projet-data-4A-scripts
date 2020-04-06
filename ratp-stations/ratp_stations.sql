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
UPDATE ratp_stations SET transport_type = 'RER' WHERE "name" IN ('Achères Grand Cormier','Achères-Ville','Aéroport Charles de Gaulle 1','Aéroport Charles de Gaulle 2 TGV','Antony','Arcueil-Cachan','Auber','Aulnay-sous-Bois','Bagneux','Boissy-Saint-Léger','Bourg-la-Reine','Bry-sur-Marne','Bures-sur-Yvette','Bussy-Saint-Georges','Cergy-Le-Haut','Cergy-Préfecture','Cergy-Saint-Christophe','Champigny','Châtelet-Les Halles','Chatou-Croissy','Cité Universitaire','Conflans-Fin d''Oise','Courcelle-sur-Yvette','Drancy','Fontaine-Michalon','Fontenay-aux-Roses','Fontenay-sous-Bois','Gentilly','Gif-sur-Yvette','Houilles Carrières-sur-Seine','Joinville-le-Pont','La Courneuve-Aubervilliers','La Croix-de-Berny','La Hacquinière','La Plaine-Stade de France','La Varenne-Chennevières','Laplace','Le Blanc-Mesnil','Le Bourget','Le Guichet','Le Parc de Saint-Maur','Le Vésinet-Centre','Le Vésinet-Le Pecq','Les Baconnets','Lognes','Lozère','Luxembourg','Maisons-Laffitte','Marne-la-Vallée Chessy','Massy-Palaiseau','Massy-Verrières','Mitry-Claye','Nanterre-Préfecture','Nanterre-Université','Nanterre-Ville','Neuilly-Plaisance','Neuville-Université','Nogent-sur-Marne','Noisiel','Noisy-Champs','Noisy-le-Grand (Mont d''Est)','Orsay-Ville','Palaiseau','Palaiseau Villebon','Parc de Sceaux','Parc des Expositions','Poissy','Port-Royal','Robinson','Rueil-Malmaison','Saint-Germain-en-Laye','Saint-Maur Créteil','Saint-Michel Notre-Dame','Saint-Rémy-lès-Chevreuse','Sartrouville','Sceaux','Sevran-Beaudottes','Sevran Livry','Sucy Bonneuil','Torcy','Val d''Europe','Val de Fontenay','Vert-Galant','Villeparisis','Villepinte','Vincennes');

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
-- Denfert-Rochereau
UPDATE ratp_stations SET transport_type = 'RER' WHERE 'coordinates' = '48.8484448201,2.39590723714';

-- Define exterior train stations which have only 1 line
UPDATE ratp_stations SET train_outside = TRUE WHERE "name" IN ('Bir-Hakeim (Grenelle)','Cambronne','Châtillon Montrouge','Chevaleret','Corvisart','Dupleix','Glacière','La Chapelle','Malakoff-Rue Etienne Dolet','Nationale','Quai de la Gare','Sèvres-Lecourbe','Bel-Air','Créteil-L''Echat (Hôpital Henri Mondor)','Créteil-Préfecture (Hôtel de Ville)','Créteil-Université','Passy','Pointe du Lac','Quai de la Rapée','Saint-Jacques');

-- Define exterior train stations which have several lines by their coordinates
-- Bastille, Barbès-Rochechouart, Stalingrad, Jaurès, Gare d'Austerlitz, La Motte-Picquet-Grenelle
UPDATE ratp_stations SET train_outside = TRUE WHERE "coordinates" IN ('48.8533891123,2.36916460221','48.8839317699,2.3493557086','48.8841892942,2.36703044197','48.8827685467,2.36994579899','48.8437198614,2.36391621716','48.8490189283,2.29776216071');

-- Add lines for train stations which have only 1 line
UPDATE ratp_stations SET line = '1' WHERE "name" IN ('Argentine','Bérault','Château de Vincennes','Esplanade de la Défense','George V','','','','');
UPDATE ratp_stations SET line = '2' WHERE "name" IN ('La Chapelle','Alexandre-Dumas','Anvers','Avron','Blanche','Colonel Fabien','Courcelles','Couronnes','','','','','');
UPDATE ratp_stations SET line = '3' WHERE "name" IN ('Anatole-France','Bourse','Europe','Gallieni (Parc de Bagnolet)','','','','','','','','');
UPDATE ratp_stations SET line = '3bis' WHERE "name" IN ('','','','','','','','','','','');
UPDATE ratp_stations SET line = '4' WHERE "name" IN ('Alésia','Château d''Eau','Château Rouge','Cité','Etienne Marcel','','','','');
UPDATE ratp_stations SET line = '5' WHERE "name" IN ('Quai de la Rapée','Bobigny-Pablo-Picasso','Bobigny-Pantin (Raymond Queneau)','Bréguet-Sabin','Campo-Formio','Eglise de Pantin','Hoche','','','');
UPDATE ratp_stations SET line = '6' WHERE "name" IN ('Bir-Hakeim (Grenelle)','Cambronne','Chevaleret','Corvisart','Dupleix','Glacière','Quai de la Gare','Sèvres-Lecourbe','Bel-Air','Passy','Saint-Jacques','Boissière','Dugommier','Edgar-Quinet','','','','','','','','','','');
UPDATE ratp_stations SET line = '7' WHERE "name" IN ('Aubervilliers Pantin (4 Chemins)','Cadet','Censier-Daubenton','Château Landon','Corentin-Cariou','Crimée','Fort d''Aubervilliers','','','','');
UPDATE ratp_stations SET line = '7bis' WHERE "name" IN ('Bolivar','Botzaris','Buttes-Chaumont','Danube','','','','');
UPDATE ratp_stations SET line = '8' WHERE "name" IN ('Créteil-L''Echat (Hôpital Henri Mondor)','Créteil-Préfecture (Hôtel de Ville)','Créteil-Université','Pointe du Lac','Balard','Boucicaut','Charenton-Ecoles','Chemin Vert','Commerce','Ecole Militaire','Ecole Vétérinaire de Maisons-Alfort','Faidherbe-Chaligny','Félix Faure','Filles du Calvaire');
UPDATE ratp_stations SET line = '9' WHERE "name" IN ('Alma-Marceau','Billancourt','Buzenval','Charonne','Croix-de-Chavaux (Jacques Duclos)','Exelmans','Iéna','');
UPDATE ratp_stations SET line = '10' WHERE "name" IN ('Avenue Emile-Zola','Boulogne-Jean-Jaurès','Boulogne Pont de Saint-Cloud','Cardinal-Lemoine','Chardon-Lagache','Charles Michels','Cluny-La Sorbonne','Eglise d''Auteuil','');
UPDATE ratp_stations SET line = '11' WHERE "name" IN ('Goncourt (Hôpital Saint-Louis)','','','','','','','','');
UPDATE ratp_stations SET line = '12' WHERE "name" IN ('Abbesses','Assemblée Nationale','Convention','Corentin-Celton','Falguière','Front Populaire','','','','','','','','','','','','','');
UPDATE ratp_stations SET line = '13' WHERE "name" IN ('Châtillon Montrouge','Malakoff-Rue Etienne Dolet','Basilique de Saint-Denis','Brochant','Carrefour-Pleyel','Gabriel-Péri','Gaîté','Garibaldi','Guy-Môquet','','','');
UPDATE ratp_stations SET line = '14' WHERE "name" IN ('Bibliothèque-François Mitterrand','Cour Saint-Emilion','','','','','','');
UPDATE ratp_stations SET line = 'A' WHERE "name" IN ('','','','','','','','');
UPDATE ratp_stations SET line = 'B' WHERE "name" IN ('','','','','','','','');

-- Add lines for train stations which have several lines by their coordinates
-- Bastille, Champs-Élysées Clémenceau, Charles de Gaulle - Étoile, Châtelet, Concorde, Franklin D. Roosevelt, Gare de Lyon, Hôtel de Ville, 
UPDATE ratp_stations SET line = '1' WHERE "coordinates" IN ('48.8533891123,2.36916460221','48.8673665705,2.31419106339','48.8739310943,2.29512725165','48.8589561813,2.34736125521','48.8656780964,2.3211937718','48.8690104279,2.3102531809','48.8455597871,2.37344920496','48.8578053731,2.35146077651');
-- Barbès-Rochechouart, Stalingrad, Jaurès, Belleville, Charles de Gaulle - Étoile, 
UPDATE ratp_stations SET line = '2' WHERE "coordinates" IN ('48.8839317699,2.3493557086','48.8841892942,2.36703044197','48.8827685467,2.36994579899','48.8722873206,2.37673767732','48.8737152683,2.29475956285');
-- Arts et Métiers, Gambetta, Havre - Caumartin, 
UPDATE ratp_stations SET line = '3' WHERE "coordinates" IN ('48.8655518636,2.35610815512','48.8647827007,2.39844583377','48.8734618907,2.32848048447');
-- Gambetta, 
UPDATE ratp_stations SET line = '3bis' WHERE "coordinates" IN ('48.865034298,2.39854148691','');
-- Barbès-Rochechouart, Châtelet, Gare de l'Est, Gare du Nord
UPDATE ratp_stations SET line = '4' WHERE "coordinates" IN ('48.8836801093,2.34953280365','48.858300056,2.34786508758','48.8764170529,2.35898704646','48.8793833026,2.35637208136');
-- Bastille, Stalingrad, Jaurès, Gare d'Austerlitz, Gare de l'Est, Gare du Nord
UPDATE ratp_stations SET line = '5' WHERE "coordinates" IN ('48.8529756747,2.36921882444','48.8841532631,2.36735747747','48.8823280249,2.37047696877','48.8437198614,2.36391621716','48.8768126254,2.35825144008','48.8797430642,2.35460081047');
-- La Motte-Picquet-Grenelle, Bercy, Charles de Gaulle - Étoile, Daumesnil, Denfert-Rochereau
UPDATE ratp_stations SET line = '6' WHERE "coordinates" IN ('48.8490189283,2.29776216071','48.840542783,2.37940946312','48.8739938407,2.29466396183','48.8396821402,2.39558417035','48.8339982367,2.33323850116');
-- Stalingrad, Châtelet, Chaussée d'Antin - La Fayette, Gare de l'Est,
UPDATE ratp_stations SET line = '7' WHERE "coordinates" IN ('48.8840719864,2.36887006278','48.8572036455,2.34722471106','48.8728599894,2.33304475093', '48.876695836,2.35799251055');
-- Jaurès, 
UPDATE ratp_stations SET line = '7bis' WHERE "coordinates" IN ('48.8828762162,2.37058633617','');
-- Bastille, La Motte-Picquet-Grenelle, Bonne-Nouvelle, Concorde, Daumesnil, Denfert-Rochereau, Grands Boulevards, 
UPDATE ratp_stations SET line = '8' WHERE "coordinates" IN ('48.853739623,2.36916481786','48.8488212667,2.29795296403','48.8705767536,2.34849429371','48.8655072215,2.32036285586','48.8393764631,2.39578806042','48.8333151859,2.33344276383','48.8715118171,2.34320837754');
-- Bonne-Nouvelle, Chaussée d'Antin - La Fayette, Franklin D. Roosevelt, Grands Boulevards, Havre - Caumartin
UPDATE ratp_stations SET line = '9' WHERE "coordinates" IN ('48.8704958323,2.34886211744','48.8729858247,2.33342622405','48.8688126319,2.30992632447','48.8715747436,2.34289503198','48.8734259765,2.3289709733');
-- Gare d'Austerlitz, La Motte-Picquet-Grenelle, Duroc, 
UPDATE ratp_stations SET line = '10' WHERE "coordinates" IN ('48.8434142241,2.36418839287','48.848803206,2.29769423466','48.8468487689,2.31693731083');
-- Arts et métiers, Belleville, Châtelet, Hôtel de Ville, 
UPDATE ratp_stations SET line = '11' WHERE "coordinates" IN ('48.865381176,2.35564493121','48.871945798,2.37675104137','48.8588572844,2.34776985674','48.8578053731,2.35146077651');
-- Concorde, 
UPDATE ratp_stations SET line = '12' WHERE "coordinates" IN ('48.8654893909,2.32141178921','');
-- Champs-Élysées Clémenceau, Duroc, 
UPDATE ratp_stations SET line = '13' WHERE "coordinates" IN ('48.8677440261,2.31412278037','48.8469925009,2.31654234477');
-- Bercy, Châtelet, Gare de Lyon
UPDATE ratp_stations SET line = '14' WHERE "coordinates" IN ('48.8401922444,2.37947725727','48.8585696725,2.34793324584','48.844652151,2.37310814755');
UPDATE ratp_stations SET line = 'A' WHERE "name" IN ('','');
UPDATE ratp_stations SET line = 'B' WHERE "name" IN ('','');

-- Remove identical db records