package main

import (
	"log"
	"log/syslog"
)

func main() {
	slog, err := syslog.New(
		syslog.LOG_WARNING|syslog.LOG_LOCAL7, "")
	if err != nil {
		log.Fatal(err)
	}
	log.SetOutput(slog)
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	log.Println("a nice day to write a log message..")
}

// /var/log/syslog .. Feb  6 12:04:33 tyco /us/local/bin/mysyslog[22376]: \
// 2015/02/06 12:04:33 mygosyslog.go:16: a nice day to write a log message..
