package services

import (
	"fmt"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver/errors"
	"github.com/johnnadratowski/golang-neo4j-bolt-driver/structures/graph"
)

var (
	RightsOnResourceForUser = "MATCH (art:Resource) WHERE art.uri=\"%s\" MATCH (user:User) WHERE user.sub=\"%s\" MATCH path = shortestPath((art)-[link*]-(user)) return path"
	CreateResource = "CREATE (newResource:Resource {uri:%s, uuid:%s, name:%s, type:%s}) return newResource"
	CreateUser = "CREATE (newUser:User{sub:%s}) return newUser"
)

func ConnectToDatabase() (golangNeo4jBoltDriver.Conn){
	driver := golangNeo4jBoltDriver.NewDriver()
	conn, _ := driver.OpenNeo("bolt://neo4j:admin@localhost:7687")
	defer conn.Close()
	return conn
}

func GetShortestPathGraphBetweenResourceAndUser(resourceUri string, userSubject string) (graph.Path, error){
	conn := ConnectToDatabase()
	query := fmt.Sprintf(RightsOnResourceForUser,resourceUri, userSubject)

	data,_,_,error2:=conn.QueryNeoAll(query, nil)
	if len(data) == 0 && error2 != nil{
		return graph.Path{} , error2
	} else if len(data) ==0 {
		return graph.Path{}, errors.New("An error occured")
	}
	var resultPath graph.Path
	resultPath = data[0][0].(graph.Path)
	return resultPath, nil
}

func IsPublicResource(resourceUri string) (bool, error){
	conn := ConnectToDatabase()
	query := fmt.Sprintf(RightsOnResourceForUser, resourceUri, "public")

	data,_,_,error2:=conn.QueryNeoAll(query, nil)
	if len(data) == 0 && error2 != nil{
		return false , error2
	} else if len(data) ==0 {
		return false, errors.New("An error occured")
	}

	return true, nil
}