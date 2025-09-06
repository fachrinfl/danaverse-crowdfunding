// Test file for API Go
package main

import (
	"fmt"
	"net/http"
	"time"
)

// User represents a user in the system
type User struct {
	ID        int       `json:"id"`
	Name      string    `json:"name"`
	Email     string    `json:"email"`
	CreatedAt time.Time `json:"created_at"`
}

// Bad formatting
type APIResponse struct {
	Success bool        `json:"success"`
	Data    interface{} `json:"data"`
	Message string      `json:"message"`
}

// TestHandler handles test requests
func TestHandler(w http.ResponseWriter, r *http.Request) {
	// Bad formatting
	response := APIResponse{
		Success: true,
		Data:    User{ID: 1, Name: "Test User", Email: "test@example.com", CreatedAt: time.Now()},
		Message: "Test successful",
	}

	fmt.Fprintf(w, "Response: %+v", response)
}

// Unused function
func unusedFunction() {
	fmt.Println("This function is not used")
}

func main() {
	http.HandleFunc("/test", TestHandler)
	fmt.Println("Server starting on :8080")
	http.ListenAndServe(":8080", nil)
}
