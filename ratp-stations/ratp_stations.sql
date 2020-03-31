CREATE TABLE ratp_stations (
    id INT NOT NULL,
    name VARCHAR NOT NULL,
    address VARCHAR NOT NULL,
    coordinates VARCHAR NOT NULL
);

-- Run main.go

ALTER TABLE ratp_stations
    ADD train_outside BOOLEAN DEFAULT FALSE NOT NULL,
    ADD transport_type VARCHAR DEFAULT 'bus' NOT NULL;
    

UPDATE ratp_stations SET train_outside = TRUE WHERE name = 'Bastille';
UPDATE ratp_stations SET train_outside = TRUE WHERE name = 'Esplanade de la Défense';
-- ajouter reste