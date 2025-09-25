package db

import (
	"log"

	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func OpenDB() *gorm.DB {
	dsn := "host=localhost user=postgres password=222 dbname=pitjarus port=5432 sslmode=disable"
	db, err := gorm.Open(postgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}
	log.Println("Connected to PostgreSQL successfully!")
	return db
}

func CloseDB() {
	if DB == nil {
		return
	}

	sqlDB, err := DB.DB()
	if err != nil {
		log.Println("Error getting SQL DB:", err)
		return
	}

	if err := sqlDB.Close(); err != nil {
		log.Println("Error closing database:", err)
	} else {
		log.Println("Database connection closed successfully")
	}
}
