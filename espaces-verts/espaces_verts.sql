CREATE TABLE espaces_verts (
	identifiant VARCHAR,
    nom
    typologie
    categorie
    adresse_numero
    AdresseComplement
    AdresseTypeVoie
    AdresseLibelleVoie
    CodePostal
    SurfaceCalculee
    SuperficieTotaleReelle
    SurfaceHorticole
    PresenceCloture
    Perimetre
    AnneeOuverture
    AnneeRenovation
    AncienNom
    AnneeChangementNom
    NombreEntites
    Ouverture24
    IdentifiantDivision
    IdentifiantAtelierHorticole
    Ida3dEnb
    SiteVilles
    IdentifiantEquipement
    Competence
    GeoShape
    URLPlan
    GeoPoint
);

-- Run main.go then execute the following

UPDATE espaces_verts
SET geo_shape = REPLACE(geo_shape, '"', '''')