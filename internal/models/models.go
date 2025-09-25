package models

type StoreArea struct {
	AreaID   int    `json:"area_id" gorm:"column:area_id;primaryKey"`
	AreaName string `json:"area_name" gorm:"column:area_name"`
}

type ChartPoint struct {
	AreaID   int     `json:"area_id"`
	AreaName string  `json:"area_name"`
	Pct      float64 `json:"pct"`
}

type TableCell struct {
	BrandID   int     `json:"brand_id"`
	BrandName string  `json:"brand_name"`
	AreaID    int     `json:"area_id"`
	AreaName  string  `json:"area_name"`
	Pct       float64 `json:"pct"`
}

type TableResponse struct {
	Areas []StoreArea      `json:"areas"`
	Rows  []map[string]any `json:"rows"`
}
