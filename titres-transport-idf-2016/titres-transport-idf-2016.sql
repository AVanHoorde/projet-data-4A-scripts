/* Source: https://www.iledefrance-mobilites.fr/le-reseau/usages-et-usagers-des-titres-de-transport/ */ 

CREATE TABLE titres_transport_idf_2016 (
	titre_transport VARCHAR,
    nombre_circulants INTEGER,
    nombre_beneficiaires INTEGER
);

INSERT INTO titres_transport_idf_2016 (titre_transport, nombre_circulants, nombre_beneficiaires)
VALUES
    ('Navigo Solidarité', 196000, ''),
    ('Navigo Gratuité', 258000, ''),
    ('Améthyste', 267000, '');

INSERT INTO titres_transport_idf_2016 (titre_transport, nombre_circulants)
VALUES
    ('Navigo', 2629000),
    ('ImagineR', 872000),
    ('Tickets t+ et Billets Origine-Destination', 2929000);