# Backend Dashboard App

Backend service for the **Dashboard Brand × Area** application.  
Built using **Golang (Echo)** with **PostgreSQL** as the primary database.

## 📂 Struktur Project

```
backend/
│── internal/
│   ├── db/
│   │   └── db.go             # Initialize PostgreSQL database connection
│   ├── handlers/
│   │   └── handler.go        # API endpoint logic handlers
│   ├── models/
│   │   └── models.go         # Struct definitions & table mappings
│   ├── middleware/
│   │   └── middleware.go     # Middleware (e.g., CORS, logging)
│   └── routes/
│       └── api.go            # API routing, register handlers to Echo
│
│── main.go                   # Application entry point
│── postgresql.sql            # Database schema & seed data
│── test.http                 # API testing file (VSCode REST Client)
```

## 🗄️ Setup Database (PostgreSQL)

Import the schema and seed data from the provided SQL file (`schema_postgres.sql`).

```bash
psql -U postgres -d database_name -f schema_postgres.sql
```

## 🚀 How To Run

### 1. Clone the repository:

```bash
git clone https://github.com/yusufbahtiarr/backend-pitjaru.git
```

### 2. Enter the project directory

```
cd backend-pitjaru
```

### 3. Install dependency

```bash
go mod tidy
```

### 2. Run the server

```bash
go run main.go
```

The server will run at:

```
http://127.0.0.1:8080
```

## 🔌 Endpoint AP

### Area

- `GET /api/areas`  
  Retrieves the list of areas from the `store_area` table..

### Chart

- `GET /api/chart?area_id={id}&from={date}&to={date}`  
  Retrieves compliance percentages per area based on the selected area and date range.
  - **Value Calculation** = `(SUM(compliance) / total_row) * 100`

### Tabel

- `GET /api/table?area_id={id}from={date}&to={date}`  
  Retrieves a summary of compliance percentages per brand × area.

## 🛠️ Tech Stack

- **Go** (Echo framework)
- **PostgreSQL**
- **Middleware**: CORS, Logging
- **Testing**: REST Client (`test.http`) / curl

## License

This project is licensed under the MIT License. See the LICENSE file for details.
