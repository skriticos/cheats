package main

import (
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
)

/*
  - connect to database
  - drop a table if exists, then create it
  - insert two records
  - fetch all records
*/

var intro string = `
	PostgreSQL test application.

	Note: this application works with the assumption that the user has access to
	a database called "testdb".

	Please set up the database if not done so with the following commands:

	CREATE DATABASE testdb;
	CREATE USER user_name WITH PASSWORD 'myPassword';
	ALTER DATABASE dbname OWNER TO new_owner;
`

// create a connection to the postgres database and verify it's working
func connect(dbname string) *sql.DB {

	fmt.Printf("connecting to database..\n")
	conninfo := fmt.Sprintf("host=/var/run/postgresql dbname=%s sslmode=disable", dbname)
	conn, _ := sql.Open("postgres", conninfo)

	// sql.Open will happily tell you that the connection is fine while it's not.
	// Pinging the database will open a real connection and shows errors.
	err := conn.Ping()
	if err != nil {
		fmt.Printf("connection failed :(\n")
	} else {
		fmt.Printf("connection verified :)\n")
	}
	return conn
}

// wrapper for queries, prints detailed complaint if query fails
func runQuery(db *sql.DB, queryStr string, args ...interface{}) *sql.Rows {

	var rows *sql.Rows
	var err error

	rows, err = db.Query(queryStr, args...)

	if err != nil {
		fmt.Printf("query failed :(\n")
		fmt.Printf("querystring: %s\n", queryStr)
		fmt.Printf("args: \n", args...)
		fmt.Printf("issue: %s\n", err.Error())
	}
	return rows
}

func main() {
	fmt.Printf(intro)

	db := connect("testdb")
	defer db.Close()

	runQuery(db, "DROP TABLE IF EXISTS tblTest")
	runQuery(db, "CREATE TABLE tblTest (col1 TEXT, col2 TEXT)")
	runQuery(db, "INSERT INTO tblTest (col1, col2) VALUES ($1, $2)", "foo", "bar")
	runQuery(db, "INSERT INTO tblTest (col1, col2) VALUES ($1, $2)", "foo2", "bar2")

	rows := runQuery(db, "SELECT * FROM tblTest")
	for rows.Next() {
		var col1, col2 string
		rows.Scan(&col1, &col2)
		fmt.Printf("col1: %s, col2: %s\n", col1, col2)
	}
}
