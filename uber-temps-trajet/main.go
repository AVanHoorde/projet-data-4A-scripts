package main

import (
	"database/sql"
	"encoding/csv"
	"fmt"
	"os"
	"strconv"

	_ "github.com/lib/pq"
)

// TravelTime is the struct for each travel time record
type TravelTime struct {
	TimeOfDay                        string
	OriginMovementID                 int
	OriginDisplayName                string
	DestinationMovementID            int
	DestinationDisplayName           string
	DateRange                        string
	MeanTravelTimeSeconds            int
	RangeLowerBoundTravelTimeSeconds int
	RangeUpperBoundTravelTimeSeconds int
}

func main() {
	db, err := sql.Open("postgres", "postgres://student:gM4eyA2468DCsQeRBNvcHGYUt5@equipe-01.cqf0cfj75jd4.eu-west-3.rds.amazonaws.com:5432/postgres")
	if err != nil {
		fmt.Println("Error connecting to database", db)
	}
	f, err := os.Open("uber-temps-trajet.csv")
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
	traveltimes := []TravelTime{}
	for indexRecords, record := range records {
		if indexRecords > 0 {
			t := TravelTime{
				TimeOfDay:              record[0],
				OriginDisplayName:      record[2],
				DestinationDisplayName: record[4],
				DateRange:              record[5],
			}
			for indexFields, field := range record {
				switch indexFields {
				case 1:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					t.OriginMovementID = i
				case 3:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					t.DestinationMovementID = i
				case 6:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					t.MeanTravelTimeSeconds = i
				case 7:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					t.RangeLowerBoundTravelTimeSeconds = i
				case 8:
					i, err := strconv.Atoi(field)
					if err != nil {
						fmt.Println("Error converting int")
					}
					t.RangeUpperBoundTravelTimeSeconds = i
				}
				traveltimes = append(traveltimes, t)
				// fmt.Println(v)
				_, err := txn.Exec("INSERT INTO uber_temps_trajet (time_of_day, origin_movement_id, origin_display_name, destination_movement_id, destination_display_name, date_range, mean_travel_time_seconds, range_lower_bound_travel_time_seconds, range_upper_bound_travel_time_seconds) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9);", t.TimeOfDay, t.OriginMovementID, t.OriginDisplayName, t.DestinationMovementID, t.DestinationDisplayName, t.DateRange, t.MeanTravelTimeSeconds, t.RangeLowerBoundTravelTimeSeconds, t.RangeUpperBoundTravelTimeSeconds)
				if err != nil {
					fmt.Println("Error inserting:", err)
				}
			}
		}
	}
	fmt.Println("Nombre de lignes dans le CSV: ", len(records))
	fmt.Println("Nombre de trajets: ", len(traveltimes))
	err = txn.Commit()
	if err != nil {
		fmt.Println("Error with transaction:", err)
	}
	db.Close()
}
