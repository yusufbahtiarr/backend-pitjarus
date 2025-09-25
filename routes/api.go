package routes

import (
	"backend/internal/handlers"

	"github.com/labstack/echo/v4"
)

func SetupRoutes(e *echo.Echo, h *handlers.Handler) {
	// API v1 group
	ro := e.Group("/api")

	// Resource-based grouping
	ro.GET("/areas", h.ListAreas)
	ro.GET("/charts", h.Chart)
	ro.GET("/tables", h.Table)
}
