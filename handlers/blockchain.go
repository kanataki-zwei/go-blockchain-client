package handlers

import (
	"bytes"
	"encoding/json"
	"io/ioutil"
	"net/http"
)

const rpcURL = "https://polygon-rpc.com/"

type JSONRPCRequest struct {
	JSONRPC string        `json:"jsonrpc"`
	Method  string        `json:"method"`
	Params  []interface{} `json:"params,omitempty"`
	ID      int           `json:"id"`
}

type JSONRPCResponse struct {
	JSONRPC string          `json:"jsonrpc"`
	Result  json.RawMessage `json:"result"`
	ID      int             `json:"id"`
	Error   *RPCError       `json:"error,omitempty"`
}

type RPCError struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

// Generic function to call Polygon JSON-RPC API
func callRPC(method string, params []interface{}) ([]byte, error) {
	requestBody := JSONRPCRequest{
		JSONRPC: "2.0",
		Method:  method,
		Params:  params,
		ID:      1,
	}

	jsonData, err := json.Marshal(requestBody)
	if err != nil {
		return nil, err
	}

	resp, err := http.Post(rpcURL, "application/json", bytes.NewBuffer(jsonData))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	return body, nil
}

// Handler to get latest block number
func GetBlockNumberHandler(w http.ResponseWriter, r *http.Request) {
	body, err := callRPC("eth_blockNumber", nil)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Type", "application/json")
	w.Write(body)
}

// Handler to get block by number
func GetBlockByNumberHandler(w http.ResponseWriter, r *http.Request) {
	number := r.URL.Query().Get("number")
	if number == "" {
		http.Error(w, "Missing block number", http.StatusBadRequest)
		return
	}

	params := []interface{}{number, true}
	body, err := callRPC("eth_getBlockByNumber", params)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(body)
}
