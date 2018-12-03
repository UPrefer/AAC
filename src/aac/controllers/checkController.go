package controllers

import (
	"aac/services"
	"github.com/gin-gonic/gin"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver/structures/graph"
)

type CheckController struct {
}

func NewCheckController() *CheckController{
	return &CheckController{}
}

func (CheckController) CheckRights(context *gin.Context) {
	uri := context.Query("uri")
	userId := context.Query("userId")
	httpMethod := context.Query("Method")

	println(uri)
	println(userId)

	var response bool
	shortestPath, err := services.GetShortestPathGraphBetweenResourceAndUser(uri, userId)
	if err == nil {
		response = CanExecute(httpMethod, shortestPath.Relationships[len(shortestPath.Relationships)-1])
	} else {
		response, _ = services.IsPublicResource(uri)
	}
	context.JSON(200, response)
	return
}

func CanExecute(method string, rights graph.UnboundRelationship) (bool){
	if rights.Properties[method] == true {
		return true
	}
	return false
}