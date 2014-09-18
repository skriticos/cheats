package main

import (
	"text/template"
	"os"
)

var tpl string = `
	Some text outside the if block
	{{ if .HasBool }}
		This is a generic text block
	{{ end }}
`

type TplIn struct {
	HasBool bool
}

func main() {
	ti := TplIn{HasBool: true}
	tmpl, err := template.New("test").Parse(tpl)
	if err != nil {
		panic(err)
	}
	err = tmpl.Execute(os.Stdout, ti)
	if err != nil {
		panic(err)
	}
}
