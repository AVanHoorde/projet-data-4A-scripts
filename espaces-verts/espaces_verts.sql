CREATE TABLE espaces_verts (
	identifiant INT,
    nom VARCHAR,
    typologie VARCHAR,
    categorie VARCHAR,
    adresse_numero INT,
    AdresseComplement VARCHAR,
    AdresseTypeVoie VARCHAR,
    AdresseLibelleVoie VARCHAR,
    CodePostal INT,
    SurfaceCalculee INT,
    SuperficieTotaleReelle INT,
    SurfaceHorticole INT,
    PresenceCloture VARCHAR,
    Perimetre FLOAT,
    AnneeOuverture INT,
    AnneeRenovation INT,
    AncienNom VARCHAR,
    AnneeChangementNom INT,
    NombreEntites INT,
    Ouverture24 VARCHAR,
    IdentifiantDivision INT,
    IdentifiantAtelierHorticole INT,
    Ida3dEnb VARCHAR,
    SiteVilles VARCHAR,
    IdentifiantEquipement VARCHAR,
    Competence VARCHAR,
    GeoShape VARCHAR,
    URLPlan VARCHAR,
    GeoPoint VARCHAR
);

-- Run main.go then execute the following

UPDATE espaces_verts
SET geo_shape = REPLACE(geo_shape, '"', '''')