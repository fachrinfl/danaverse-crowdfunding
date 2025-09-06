package main

import (
	"log"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	// Load environment variables
	if err := godotenv.Load(); err != nil {
		log.Println("No .env file found")
	}

	// Set Gin mode
	if os.Getenv("GIN_MODE") == "" {
		gin.SetMode(gin.ReleaseMode)
	}

	// Initialize router
	r := gin.Default()

	// Health check endpoint
	r.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"status": "ok",
			"service": "danaverse-api",
		})
	})

	// API routes
	api := r.Group("/api/v1")
	{
		api.GET("/projects", getProjects)
		api.POST("/projects", createProject)
		api.GET("/projects/:id", getProject)
		api.PUT("/projects/:id", updateProject)
		api.DELETE("/projects/:id", deleteProject)
	}

	// Start server
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server starting on port %s", port)
	if err := r.Run(":" + port); err != nil {
		log.Fatal("Failed to start server:", err)
	}
}

// Placeholder handlers
func getProjects(c *gin.Context) {
	c.JSON(200, gin.H{
		"projects": []interface{}{},
		"message": "Projects endpoint - coming soon",
	})
}

func createProject(c *gin.Context) {
	c.JSON(201, gin.H{
		"message": "Create project endpoint - coming soon",
	})
}

func getProject(c *gin.Context) {
	id := c.Param("id")
	c.JSON(200, gin.H{
		"id": id,
		"message": "Get project endpoint - coming soon",
	})
}

func updateProject(c *gin.Context) {
	id := c.Param("id")
	c.JSON(200, gin.H{
		"id": id,
		"message": "Update project endpoint - coming soon",
	})
}

func deleteProject(c *gin.Context) {
	id := c.Param("id")
	c.JSON(200, gin.H{
		"id": id,
		"message": "Delete project endpoint - coming soon",
	})
}
