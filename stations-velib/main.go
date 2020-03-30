package main

import (
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"
	"time"

	_ "github.com/lib/pq"
	database "github.com/louisl98/projet-data-scripts"
)

type station struct {
	IdentifiantStation          int
	NomStation                  string
	CapaciteStation             int
	NombreBornettesLibres       int
	NombreTotalVelosDisponibles int
	VelosMecaniquesDisponibles  int
	VelosElectriquesDisponibles int
	BornePaiementDispo          string
	RetourVelibPossible         string
	DerniereActualisation       time.Time
	Coordonnees                 string
	NomCommunesEquipees         string
	CodeInseeCommunesEquipees   int
}

func main() {
	db, err := sql.Open(database.Type, database.URI)
	if err != nil {
		fmt.Println("Error connecting to database", db)
	}
	f, err := os.Open("stations_velib.csv")
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
	stations := []station{}
	for indexRecords, record := range records {
		if indexRecords > 0 {
			s := station{
				NomStation:          record[1],
				BornePaiementDispo:  record[7],
				RetourVelibPossible: record[8],
				Coordonnees:         record[10],
				NomCommunesEquipees: record[11],
			}
			for indexFields, field := range record {
				fmt.Println(indexFields, field)
				switch indexFields {
				case 0:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					s.IdentifiantStation = i
				case 2:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					s.CapaciteStation = i
				case 3:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					s.NombreBornettesLibres = i
				case 4:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					s.NombreTotalVelosDisponibles = i
				case 5:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					s.VelosMecaniquesDisponibles = i
				case 6:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					s.VelosElectriquesDisponibles = i
				case 9:
					i := field.String()
					s.DerniereActualisation = i
				case 12:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					s.CodeInseeCommunesEquipees = i
				}
				stations = append(stations, s)
				_, err := txn.Exec("INSERT INTO stations_velib (identifiant_station, nom_station, capacite_station, nb_bornettes_libres, nb_total_velos_dispo, velos_mecaniques_dispo, velos_electriques_dispo, borne_paiement_dispo, retour_velib_possible, derniere_actualisation, coordonnees, nom_communes_equipees, code_insee_communes_equipees) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);", s.IdentifiantStation, s.NomStation, s.CapaciteStation, s.NombreBornettesLibres, s.NombreTotalVelosDisponibles, s.VelosMecaniquesDisponibles, s.VelosElectriquesDisponibles, s.BornePaiementDispo, s.RetourVelibPossible, s.DerniereActualisation, s.Coordonnees, s.NomCommunesEquipees, s.CodeInseeCommunesEquipees)
				if err != nil {
					fmt.Println("Error inserting:", err)
				}
			}
		}
	}
	fmt.Println("Nombre de lignes dans le CSV : ", len(records))
	fmt.Println("Nombre de stations : ", len(stations))
	err = txn.Commit()
	if err != nil {
		fmt.Println("Error with transaction:", err)
	}
	db.Close()
}
