package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/kanataki-zwei/go-blockchain-client/handlers"
)

func main() {
	// Define HTTP routes
	http.HandleFunc("/block/number", handlers.GetBlockNumberHandler)
	http.HandleFunc("/block", handlers.GetBlockByNumberHandler)

	// Start the server
	port := 9090
	fmt.Printf("Server running on port %d...\n", port)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%d", port), nil))
}
