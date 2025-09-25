package main

import (
	"log"

	"backend/internal/db"
	"backend/internal/handlers"
	"backend/middleware"
	"backend/routes"

	"github.com/labstack/echo/v4"
)

func main() {
	db.DB = db.OpenDB()
	defer db.CloseDB()

	h := &handlers.Handler{DB: db.DB}

	e := echo.New()

	middleware.SetupGlobalMiddleware(e)

	routes.SetupRoutes(e, h)

	log.Println("Server running at :8080")
	log.Fatal(e.Start(":8080"))
}
