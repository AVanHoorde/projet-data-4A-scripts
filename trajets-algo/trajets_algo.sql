CREATE TABLE trajets_algo (
    id INT,
    coords_point_depart VARCHAR NOT NULL,
    coords_point_arrivee VARCHAR NOT NULL,
    date_heure_depart TIMESTAMP NOT NULL,
    date_heure_arrive TIMESTAMP NOT NULL,
    id_client_maratp INT NOT NULL
);