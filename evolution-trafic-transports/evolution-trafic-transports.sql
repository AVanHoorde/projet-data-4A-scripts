/* Source: https://www.statistiques.developpement-durable.gouv.fr/sites/default/files/2019-04/datalab-52-chiffres-cles-du-transport-avril2019.pdf */ 

CREATE TABLE evolution_trafic_transports (
	annee INTEGER,
    mode_transport VARCHAR,
    millions_voyageurs_parkm INTEGER
);

INSERT INTO evolution_trafic_transports (annee, mode_transport, millions_voyageurs_parkm)
VALUES
    (2002, 'Modes ferrés', 21082),
    (2002, 'Trains et RER', 14897),
    (2002, 'Métros', 6186),
    (2002, 'Tramways', 141),
    (2002, 'Bus', 3915),
    (2002, 'Métros hors IDF', 1437),
    (2002, 'Tramways et bus hors IDF', 5349),
    (2007, 'Modes ferrés', 23423),
    (2007, 'Trains et RER', 16537),
    (2007, 'Métros', 6886),
    (2007, 'Tramways', 257),
    (2007, 'Bus', 4078),
    (2007, 'Métros hors IDF', 1973),
    (2007, 'Tramways et bus hors IDF', 6245),
    (2012, 'Modes ferrés', 25643),
    (2012, 'Trains et RER', 17968),
    (2012, 'Métros', 7675),
    (2012, 'Tramways', 355),
    (2012, 'Bus', 4619),
    (2012, 'Métros hors IDF', 2435),
    (2012, 'Tramways et bus hors IDF', 7224),
    (2017, 'Modes ferrés', 27362),
    (2017, 'Trains et RER', 19545),
    (2017, 'Métros', 7817),
    (2017, 'Tramways', 939),
    (2017, 'Bus', 5225),
    (2017, 'Métros hors IDF', 2557),
    (2017, 'Tramways et bus hors IDF', 8103);