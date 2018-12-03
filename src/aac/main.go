package main

import (
	"aac/api"
	"fmt"
	"log"
	"net/http"
)

type App struct{}

func main() {
	app := new(App)
	app.Run("localhost:9000")
}

func (app App) Run(listeningAddr string) {
	fmt.Printf("Starting AAC on address : %s\n", listeningAddr)
	err := http.ListenAndServe(listeningAddr, api.Handlers())
	if err != nil {
		log.Fatal(listeningAddr, err)
	}
}
