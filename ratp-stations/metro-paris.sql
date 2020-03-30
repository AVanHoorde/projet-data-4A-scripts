ALTER TABLE "ratp_stations"
	RENAME description to address;

/* Source: https://fr.wikipedia.org/wiki/M%C3%A9tro_de_Paris#Lignes_en_service */ 

CREATE TABLE metro_paris (
	ligne VARCHAR NOT NULL,
	parcours VARCHAR NOT NULL,
	mise_en_service INT NOT NULL,
	dernier_prolongement INT NOT NULL,
	longueur_km_surface FLOAT NOT NULL,
	nombre_stations INT NOT NULL,
	materiel VARCHAR NOT NULL,
	voitures_par_rame INT NOT NULL,
	nombre_rames_pointe INT NOT NULL,
	nombre_total_rames INT NOT NULL,
	millions_voyageurs_2017 FLOAT NOT NULL
);

INSERT INTO metro_paris (ligne, parcours, mise_en_service, dernier_prolongement, longueur_km_surface, nombre_stations, materiel, voitures_par_rame, nombre_rames_pointe, nombre_total_rames, millions_voyageurs_2017) 
	VALUES
		('1', 'La Défense - Château de Vincennes', 1900, 1992, 16.6, 25, MP 05, 6, 45, 56, 181.2),
		('2', 'Porte Dauphine - Nation', 1900, 1903, 12.3, 25, MF 01,	5, 37, 46, 105.2),
		('3', 'Pont de Levallois - Gallieni', 1904, 1971,	11.7, 25, MF 67, 5, 40, 47, 101.4),
		('3bis', 'Gambetta - Porte des Lilas', 1971, 1971, 1.3, 4, 'MF 67', 3, 4, 6, 101.4),
		('4', 'Porte de Clignancourt - Mairie de Montrouge', 1908, 2013, 12.1, 27, 'MP 89 CC', 6, 40, 52, 155.9),
		('5', 'Bobigny Pablo Picasso - Place d''Italie', 1906, 1985, 14.6, 22, 'MF 01', 5, 45, 52, 110.9),
		('6', 'Charles de Gaulle Étoile - Nation', 1907, 1942, 13.7, 28, 'MP 73', 5, 37, 44, 114.3),
		('7', 'La Courneuve 8 Mai 1945 - Villejuif Louis Aragon / Mairie d''Ivry', 1910, 1987, 22.5, 38, 'MF 77', 5, 60, 71, 135.1),
		('7bis', 'Louis Blanc - Pré-Saint-Gervais', 1967, 1967, 3.1, 8, 'MF 88', 3, 6, 8, 135.1),
		('8', 'Balard - Créteil Pointe du Lac', 1913, 2011, 23.4, 38, 'MF 77', 5, 50, 59, 105.5),
		('9', 'Pont de Sèvres - Mairie de Montreuil', 1922, 1937, 19.6, 37, 'MF 01', 5, 59, 74, 137.9),
		('10', 'Boulogne Pont de Saint-Cloud - Gare d''Austerlitz', 1923, 1981, 11.7, 23, 'MF 67', 5, 22, 31, 45.3),
		('11', 'Châtelet - Mairie des Lilas', 1935, 1937, 6.3, 13, 'MP 59, MP 73', 4, 20, 26, 47.1),
		('12', 'Front Populaire - Mairie d''Issy', 1910, 2012, 15.3, 29, 'MF 67', 5, 37, 45, 84.3),
		('13', 'Asnières-Gennevilliers Les Courtilles / Saint-Denis Université - Châtillon Montrouge', 1911, 2008, 24.3, 32, 'MF 77', 5, 52, 66, 131.4),
		('14', 'Saint-Lazare - Olympiades', 1998, 2007, 9.2, 9, 'MP 89 CA, MP 05', 6, 25, 32, 83.3);