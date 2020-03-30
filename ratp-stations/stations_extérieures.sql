CREATE TABLE ratp_stations (
    id INT NOT NULL,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    coordinates VARCHAR NOT NULL
);

ALTER TABLE ratp_stations
    ADD Outside BOOLEAN
    DEFAULT FALSE NOT NULL;

UPDATE ratp_stations SET outside = TRUE WHERE name = 'Bastille';
UPDATE ratp_stations SET outside = TRUE WHERE name = 'Esplanade de la Défense';
-- ajouter reste