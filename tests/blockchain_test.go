package tests

import (
	"net/http"
	"net/http/httptest"
	"testing"

	"github.com/kanataki-zwei/go-blockchain-client/handlers"
)

// Test for fetching latest block number
func TestGetBlockNumberHandler(t *testing.T) {
	req, err := http.NewRequest("GET", "/block/number", nil)
	if err != nil {
		t.Fatal(err)
	}

	recorder := httptest.NewRecorder()
	handler := http.HandlerFunc(handlers.GetBlockNumberHandler)
	handler.ServeHTTP(recorder, req)

	if recorder.Code != http.StatusOK {
		t.Errorf("Expected status OK, got %v", recorder.Code)
	}
}

// Test for fetching block by number
func TestGetBlockByNumberHandler(t *testing.T) {
	req, err := http.NewRequest("GET", "/block?number=0x134e82a", nil)
	if err != nil {
		t.Fatal(err)
	}

	recorder := httptest.NewRecorder()
	handler := http.HandlerFunc(handlers.GetBlockByNumberHandler)
	handler.ServeHTTP(recorder, req)

	if recorder.Code != http.StatusOK {
		t.Errorf("Expected status OK, got %v", recorder.Code)
	}
}
