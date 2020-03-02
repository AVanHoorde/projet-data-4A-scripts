package main

import (
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"

	_ "github.com/lib/pq"
)

// Commerce is the struct for each commerce record
type Commerce struct {
	Commerce      string
	JourFermeture string
	Adresse       string
	CodePostal    int
	Ville         string
	CoordGeo      string
}

func main() {
	db, err := sql.Open("postgres", "postgres://student:gM4eyA2468DCsQeRBNvcHGYUt5@equipe-01.cqf0cfj75jd4.eu-west-3.rds.amazonaws.com:5432/postgres")
	if err != nil {
		fmt.Println("Error connecting to database", db)
	}
	f, err := os.Open("ratp-commerces.csv")
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
	commerces := []Commerce{}
	for indexRecords, record := range records {
		if indexRecords > 0 {
			c := Commerce{
				Commerce:      record[0],
				JourFermeture: record[1],
				Adresse:       record[2],
				Ville:         record[4],
				CoordGeo:      record[5],
			}
			for indexFields, field := range record {
				switch indexFields {
				case 3:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					c.CodePostal = i
				}
				commerces = append(commerces, c)
				// fmt.Println(v)
				_, err := txn.Exec("INSERT INTO ratp_commerces (commerce, jour_de_fermeture, adresse, code_postal, ville, coord_geo) VALUES ($1, $2, $3, $4, $5, $6);", c.Commerce, c.JourFermeture, c.Adresse, c.CodePostal, c.Ville, c.CoordGeo)
				if err != nil {
					fmt.Println("Error inserting:", err)
				}
			}
		}
	}
	fmt.Println("Nombre de lignes dans le CSV: ", len(records))
	fmt.Println("Nombre de commerces: ", len(commerces))
	err = txn.Commit()
	if err != nil {
		fmt.Println("Error with transaction:", err)
	}
}
