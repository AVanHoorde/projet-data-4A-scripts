package main

import (
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"

	_ "github.com/lib/pq"
)

type espaceVert struct {
	Identifiant                 int32
	Nom                         string
	Typologie                   string
	Categorie                   string
	AdresseNumero               int
	AdresseComplement           string
	AdresseTypeVoie             string
	AdresseLibelleVoie          string
	CodePostal                  int
	SurfaceCalculee             int
	SuperficieTotaleReelle      int
	SurfaceHorticole            int
	PresenceCloture             string
	Perimetre                   float64
	AnneeOuverture              int
	AnneeRenovation             int
	AncienNom                   string
	AnneeChangementNom          int
	NombreEntites               int
	Ouverture24                 string
	IdentifiantDivision         int
	IdentifiantAtelierHorticole int
	Ida3dEnb                    string
	SiteVilles                  string
	IdentifiantEquipement       string
	Competence                  string
	GeoShape                    string
	URLPlan                     string
	GeoPoint                    string
}

func main() {
	db, err := sql.Open("postgres", "postgres://student:gM4eyA2468DCsQeRBNvcHGYUt5@equipe-01.cqf0cfj75jd4.eu-west-3.rds.amazonaws.com:5432/postgres")
	if err != nil {
		fmt.Println("Error connecting to database", db)
	}
	f, err := os.Open("espaces_verts.csv")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer f.Close()
	r := csv.NewReader(f)
	records, err := r.ReadAll()
	if err != nil {
		fmt.Println("Error reading CSV file:", err)
		return
	}
	txn, err := db.Begin()
	if err != nil {
		fmt.Println(err)
	}
	espacesVerts := []espaceVert{}
	for indexRecords, record := range records {
		if indexRecords > 0 {
			e := espaceVert{
				Type:     record[0],
				GeoShape: record[2],
				GeoPoint: record[3],
			}
			for indexFields, field := range record {
				switch indexFields {
				case 1:
					i, err := strconv.ParseFloat(field, 64)
					if err != nil {
						fmt.Println("Error converting float64")
					}
					e.SuperficieHectares = i
				}
				espacesVerts = append(espacesVerts, e)
				// fmt.Println(v)
				_, err := txn.Exec("INSERT INTO espaces_verts (identifiant_espace_vert, nom, typologie, categorie, adresse_numero, adresse_complement, adresse_type_voie, adresse_libelle_voie, code_postal, surface_calculee, superficie_totale_reelle, surface_horticole, presence_cloture, perimetre, annee_ouverture, annee_renovation, ancien_nom, annee_changement_nom, nombre_entites, ouverture_24h_24h, id_division, id_atelier_horticole, ida3d_enb, site_villes, id_eqpt, competence, geo_shape, url_plan, geo_point) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25, $26, $27, $28, $29);", e.Identifiant, e.Nom, e.Typologie, e.Categorie, e.AdresseNumero, e.AdresseComplement, e.AdresseTypeVoie, e.AdresseLibelleVoie, e.CodePostal, e.SurfaceCalculee, e.SuperficieTotaleReelle, e.SurfaceHorticole, e.PresenceCloture, e.Perimetre, e.AnneeOuverture, e.AnneeRenovation, e.AncienNom, e.AnneeChangementNom, e.NombreEntites, e.Ouverture24, e.IdentifiantDivision, e.IdentifiantAtelierHorticole, e.Ida3dEnb, e.SiteVilles, e.IdentifiantEquipement, e.Competence, e.GeoShape, e.URLPlan, e.GeoPoint)
				if err != nil {
					fmt.Println("Error inserting:", err)
				}
			}
		}
	}
	fmt.Println("Nombre de lignes dans le CSV: ", len(records))
	fmt.Println("Nombre d'espaces vets: ", len(espacesVerts))
	err = txn.Commit()
	if err != nil {
		fmt.Println("Error with transaction:", err)
	}
	db.Close()
}
