package main

import (
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"

	_ "github.com/lib/pq"
)

// Zonage is the struct for each zonage record
type Zonage struct {
	Type               string
	SuperficieHectares float64
	GeoShape           string
	GeoPoint           string
}

func main() {
	db, err := sql.Open("postgres", "postgres://student:gM4eyA2468DCsQeRBNvcHGYUt5@equipe-01.cqf0cfj75jd4.eu-west-3.rds.amazonaws.com:5432/postgres")
	if err != nil {
		fmt.Println("Error connecting to database", db)
	}
	f, err := os.Open("zonage-pluvial.csv")
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
	zonages := []Zonage{}
	for indexRecords, record := range records {
		if indexRecords > 0 {
			z := Zonage{
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
					z.SuperficieHectares = i
				}
				zonages = append(zonages, z)
				// fmt.Println(v)
				_, err := txn.Exec("INSERT INTO zonage_pluvial (type, superficie_hectares, geo_shape, geo_point_2d) VALUES ($1, $2, $3, $4);", z.Type, z.SuperficieHectares, z.GeoShape, z.GeoPoint)
				if err != nil {
					fmt.Println("Error inserting:", err)
				}
			}
		}
	}
	fmt.Println("Nombre de lignes dans le CSV: ", len(records))
	fmt.Println("Nombre de zonages: ", len(zonages))
	err = txn.Commit()
	if err != nil {
		fmt.Println("Error with transaction:", err)
	}
}
