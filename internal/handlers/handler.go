package handlers

import (
	"backend/internal/models"
	"net/http"
	"time"

	"github.com/labstack/echo/v4"
	"gorm.io/gorm"
)

type Handler struct{ DB *gorm.DB }

func (h *Handler) ListAreas(c echo.Context) error {
	var areas []models.StoreArea
	if err := h.DB.Table("store_area").Order("area_name").Find(&areas).Error; err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}
	resp := append([]models.StoreArea{{AreaID: 0, AreaName: "All Areas"}}, areas...)
	return c.JSON(http.StatusOK, resp)
}

func (h *Handler) Chart(c echo.Context) error {
	areaID := c.QueryParam("area_id")
	fromStr := c.QueryParam("from")
	toStr := c.QueryParam("to")

	if fromStr == "" || toStr == "" {
		fromStr = "2021-01-01"
		toStr = time.Now().Format("2006-01-02")
	}

	var chart []models.ChartPoint
	err := h.DB.Raw(`
SELECT sa.area_id, sa.area_name,
       ROUND((SUM(rp.compliance)::numeric / NULLIF(COUNT(*),0)) * 100, 1) AS pct
FROM report_product rp
JOIN store s      ON s.store_id  = rp.store_id
JOIN store_area sa ON sa.area_id = s.area_id
WHERE rp.tanggal BETWEEN ? AND ?
  AND (sa.area_id = COALESCE(NULLIF(?, '0')::int, sa.area_id))
GROUP BY sa.area_id, sa.area_name
ORDER BY sa.area_name;`,
		fromStr, toStr, areaID).Scan(&chart).Error
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}

	return c.JSON(http.StatusOK, chart)
}

func (h *Handler) Table(c echo.Context) error {
	areaID := c.QueryParam("area_id")
	fromStr := c.QueryParam("from")
	toStr := c.QueryParam("to")

	if fromStr == "" || toStr == "" {
		to := time.Now().Format("2006-01-02")
		from := time.Now().AddDate(0, 0, -30).Format("2006-01-02")
		fromStr, toStr = from, to
	}

	var areas []models.StoreArea
	if areaID != "0" && areaID != "" {
		if err := h.DB.Table("store_area").Where("area_id = ?", areaID).Find(&areas).Error; err != nil {
			return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
		}
	} else {
		if err := h.DB.Table("store_area").Order("area_name").Find(&areas).Error; err != nil {
			return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
		}
	}

	var cells []models.TableCell
	err := h.DB.Raw(`
        SELECT b.brand_id, b.brand_name,
               sa.area_id, sa.area_name,
               ROUND((SUM(rp.compliance)::numeric / NULLIF(COUNT(*),0)) * 100, 1) AS pct
        FROM report_product rp
        JOIN product p ON p.product_id = rp.product_id
        JOIN product_brand b ON b.brand_id = p.brand_id
        JOIN store s ON s.store_id = rp.store_id
        JOIN store_area sa ON sa.area_id = s.area_id
        WHERE rp.tanggal BETWEEN ? AND ?
        AND (? = 0 OR sa.area_id = ?)
        GROUP BY b.brand_id, b.brand_name, sa.area_id, sa.area_name
        ORDER BY b.brand_name, sa.area_name;`,
		fromStr, toStr, areaID, areaID).Scan(&cells).Error
	if err != nil {
		return c.JSON(http.StatusInternalServerError, echo.Map{"error": err.Error()})
	}

	rowsMap := map[int]map[string]any{}
	for _, cell := range cells {
		row, ok := rowsMap[cell.BrandID]
		if !ok {
			row = map[string]any{"brand_id": cell.BrandID, "Brand": cell.BrandName}
			rowsMap[cell.BrandID] = row
		}
		row[cell.AreaName] = cell.Pct
	}

	rows := make([]map[string]any, 0, len(rowsMap))
	for _, r := range rowsMap {
		for _, a := range areas {
			if _, ok := r[a.AreaName]; !ok {
				r[a.AreaName] = nil
			}
		}
		rows = append(rows, r)
	}

	return c.JSON(http.StatusOK, models.TableResponse{Areas: areas, Rows: rows})
}
