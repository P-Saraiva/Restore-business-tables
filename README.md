# Restore Business Table

This application is designed to automate the creation and population of MySQL database tables based on SQL templates and data files. It scans a directory for table definitions and data files, creates the corresponding tables in the database, and populates them with data.

## Features

- Automatically detects SQL templates in the `templates` directory.
- Reads table names and metadata from file names.
- Creates tables in a MySQL database using the templates.
- Populates the created tables with data from SQL files.
- Validates database connection and configuration before execution.

## Prerequisites

- Go 1.23 or higher.
- MySQL server installed and running.
- PowerShell (required for certain directory operations on Windows).
- SQL templates and data files organized in the expected directory structure.

## Directory Structure
The application expects the following directory structure:

```
restore-business-table/
├── main.go 
├── go.mod 
├── templates/ 
│   ├── table1.sql 
│   ├── table2.sql 
│   └── ... 
│
Defense dir/
├── bak/ 
│   └── business_table/ 
│       └── oseadb/ 
│           ├── table1_YYYYMMDD/ 
│           │   └── table1.sql 
│           ├── table2_YYYYMMDD/ 
│           │   └── table2.sql 
│           └── ...
```

- `templates/`: Contains SQL templates for table creation.
- `bak/business_table/oseadb/`: Contains subdirectories for each table, named with a timestamp, containing SQL files for populating the tables.

## Configuration

The database configuration is defined in the `DBConfig` struct in `main.go`:

```go
var DBConfig = struct {
    Host     string
    User     string
    Password string
    Database string
    Port     string
}{
    Host:     "localhost",
    User:     "",
    Password: "DmRVBOUNHCZuTJG3",
    Database: "",
    Port:     "",
}
```

The application reads the MySQL port from the my.ini configuration file located in the MySQL installation directory.

Usage
Clone the repository and navigate to the project directory.

Ensure the templates directory contains the SQL templates for table creation.

Place the data files in the bak/business_table/oseadb/ directory, organized by table name and timestamp.

## Build and run the application:
```cmd
go run main.go <password>
```
Or you can build an .exe file:
```cmd
go build -o restore.exe .
```
To run it:
```cmd
restore.exe <password>
```

Replace `<password>` with the 16-character alphanumeric password for the MySQL database.

You can replace `restore`  with a name of choice.

## The application will:

Detect the parent directory of the MySQL installation.
Load SQL templates from the templates directory.
Scan the bak/business_table/oseadb/ directory for table data files.
Create tables in the MySQL database.
Populate the tables with data.

## Error Handling

If a table already exists, the application will skip its creation and log a message.
If a table fails to populate, the error will be logged, and the application will continue with the next table.

## Environment Variables

MYSQL_BIN: The path to the MySQL binary directory is set dynamically by the application.

## Dependencies

The application uses the following Go modules:

github.com/go-sql-driver/mysql: MySQL driver for Go.
filippo.io/edwards25519: Indirect dependency.