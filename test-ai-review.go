// Test file for AI Code Review - Go
// This file contains various Go patterns to test AI review functionality

package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
)

// ❌ Test case: Missing error handling (should trigger AI review)
func fetchData() {
	client := &http.Client{}
	resp, err := client.Get("https://api.example.com/data") // AI should suggest error handling
	defer resp.Body.Close()
	
	// ❌ Test case: Using context.Background() in non-main function (should trigger AI review)
	ctx := context.Background() // AI should suggest using request context
	
	// ❌ Test case: Using fmt.Print instead of structured logging (should trigger AI review)
	fmt.Print("Processing data...") // AI should suggest using log package
	
	// ❌ Test case: Potential SQL injection (should trigger security scan)
	query := fmt.Sprintf("SELECT * FROM users WHERE id = %s", userID) // AI should suggest parameterized queries
}

// ❌ Test case: Hardcoded credentials (should trigger security scan)
const (
	DB_PASSWORD = "secretpassword123" // AI should detect hardcoded credentials
	API_KEY     = "sk-1234567890abcdef"
)

// ❌ Test case: Insecure HTTP protocol (should trigger security scan)
func fetchInsecureData() {
	resp, err := http.Get("http://api.example.com/data") // AI should suggest HTTPS
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()
}

// ❌ Test case: Missing error handling in function
func processData(data []byte) {
	// AI should suggest adding error handling
	result := string(data)
	fmt.Println(result)
}

// ❌ Test case: Using global variables (should trigger AI review)
var globalCounter int // AI should suggest avoiding global variables

func main() {
	// ❌ Test case: Missing error handling in main
	fetchData() // AI should suggest error handling
	
	// ❌ Test case: Using fmt.Print in main (should trigger AI review)
	fmt.Print("Application started") // AI should suggest using log package
	
	// ❌ Test case: Infinite loop without break condition (should trigger AI review)
	for {
		// AI should suggest adding break condition or timeout
		processData([]byte("test"))
	}
}
