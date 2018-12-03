package api

import (
	"aac/controllers"
	"github.com/gin-gonic/gin"
)

func Handlers() *gin.Engine {
	engine := gin.Default()

	v1 := engine.Group("/v1")
	{

		v1.Group("/admin")
		{

		}

		public := v1.Group("")
		{
			public.GET("", controllers.CheckRights)
			public.Group("/resources").GET(controllers.Get())
		}
	}

	return engine
}