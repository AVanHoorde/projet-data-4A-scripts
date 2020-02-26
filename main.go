package main

import (
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"
	"time"

	_ "github.com/lib/pq"
)

// Validation is the struct for each validation record
type Validation struct {
	Jour           time.Time
	LibelleArret   string
	CategorieTitre string
	NbVald         int
	IsInt          bool
}

func main() {
	db, err := sql.Open("postgres", "postgres://student:gM4eyA2468DCsQeRBNvcHGYUt5@equipe-01.cqf0cfj75jd4.eu-west-3.rds.amazonaws.com:5432/postgres")
	if err != nil {
		fmt.Println("Error connecting to database", db)
	}
	f, err := os.Open("validations.csv")
	if err != nil {
		fmt.Println("Error opening file:", err)
		return
	}
	defer f.Close()
	// fmt.Println("File name:", f.Name())
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
	// fmt.Println("Records:", records)
	validations := []Validation{}
	for indexRecords, record := range records {
		if indexRecords > 0 {
			v := Validation{}
			for indexFields, field := range record {
				switch indexFields {
				case 0:
					t, err := time.Parse("2006-01-02", field)
					if err != nil {
						fmt.Println("Error converting time:", t)
					}
					v.Jour = t
				case 1:
					v.LibelleArret = field
				case 2:
					v.CategorieTitre = field
				case 3:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					v.NbVald = i
				case 4:
					b, err := strconv.ParseBool(field)
					if err != nil {
						fmt.Println("Error converting bool")
					}
					v.IsInt = b
				}
				validations = append(validations, v)
				// fmt.Println(v)
				_, err := txn.Exec("INSERT INTO test (jour, libelle_arret, categorie_titre, nb_vald, is_int) VALUES ($1, $2, $3, $4, $5);", v.Jour, v.LibelleArret, v.CategorieTitre, v.NbVald, v.IsInt)
				if err != nil {
					fmt.Println("Error inserting:", err)
				}
			}
		}
	}
	fmt.Println("Nombre de lignes dans le CSV: ", len(records))
	fmt.Println("Nombre de validations: ", len(validations))
	err = txn.Commit()
	if err != nil {
		fmt.Println("Error with transaction:", err)
	}
}
