// Test file for AI Code Review - Go FIXED VERSION
// This file demonstrates proper Go patterns following DanaVerse standards

package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

// ✅ Fixed: Proper error handling and context usage
func fetchData(ctx context.Context) error {
	client := &http.Client{
		Timeout: 30 * time.Second,
	}
	
	req, err := http.NewRequestWithContext(ctx, "GET", "https://api.example.com/data", nil)
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}
	
	resp, err := client.Do(req)
	if err != nil {
		return fmt.Errorf("failed to fetch data: %w", err)
	}
	defer resp.Body.Close()
	
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}
	
	// ✅ Fixed: Using structured logging
	log.Info("Successfully fetched data from API")
	return nil
}

// ✅ Fixed: Using environment variables instead of hardcoded credentials
var (
	DBPassword = os.Getenv("DB_PASSWORD")
	APIKey     = os.Getenv("API_KEY")
)

// ✅ Fixed: Using HTTPS protocol and proper error handling
func fetchSecureData(ctx context.Context) error {
	client := &http.Client{
		Timeout: 30 * time.Second,
	}
	
	req, err := http.NewRequestWithContext(ctx, "GET", "https://api.example.com/data", nil)
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}
	
	resp, err := client.Do(req)
	if err != nil {
		return fmt.Errorf("failed to fetch secure data: %w", err)
	}
	defer resp.Body.Close()
	
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}
	
	log.Info("Successfully fetched secure data")
	return nil
}

// ✅ Fixed: Proper error handling and return values
func processData(data []byte) (string, error) {
	if len(data) == 0 {
		return "", fmt.Errorf("data cannot be empty")
	}
	
	result := string(data)
	log.Info("Successfully processed data", "length", len(data))
	return result, nil
}

// ✅ Fixed: Using parameterized queries to prevent SQL injection
func getUserByID(db *sql.DB, userID string) (*sql.Row, error) {
	query := "SELECT * FROM users WHERE id = $1"
	row := db.QueryRow(query, userID)
	return row, nil
}

// ✅ Fixed: Avoiding global variables, using dependency injection
type App struct {
	counter int
	logger  *log.Logger
}

func NewApp(logger *log.Logger) *App {
	return &App{
		counter: 0,
		logger:  logger,
	}
}

func (a *App) IncrementCounter() {
	a.counter++
	a.logger.Info("Counter incremented", "value", a.counter)
}

func main() {
	// ✅ Fixed: Proper logging setup
	logger := log.New(os.Stdout, "APP: ", log.LstdFlags|log.Lshortfile)
	logger.Info("Application started")
	
	// ✅ Fixed: Using context with timeout
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()
	
	// ✅ Fixed: Proper error handling in main
	app := NewApp(logger)
	
	// ✅ Fixed: Controlled loop with timeout
	ticker := time.NewTicker(1 * time.Second)
	defer ticker.Stop()
	
	timeout := time.After(10 * time.Second)
	
	for {
		select {
		case <-ticker.C:
			app.IncrementCounter()
			
			// Process data with proper error handling
			result, err := processData([]byte("test"))
			if err != nil {
				logger.Error("Failed to process data", "error", err)
				continue
			}
			
			logger.Info("Data processed successfully", "result", result)
			
		case <-timeout:
			logger.Info("Application timeout reached, shutting down")
			return
			
		case <-ctx.Done():
			logger.Info("Context cancelled, shutting down")
			return
		}
	}
}
