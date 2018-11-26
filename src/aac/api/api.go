package api

import (
	"github.com/gin-gonic/gin"
)

func Handlers() *gin.Engine {
	engine := gin.Default()

	v1 := engine.Group("/v1")
	{

		_ := v1.Group("/admin")
		{

		}
	}

	return engine
}