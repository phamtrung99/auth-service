package http

import (
	"strings"

	"github.com/labstack/echo/v4"
	"github.com/phamtrung99/movie-service/config"
	"github.com/phamtrung99/auth-service/delivery/http/v1/auth"
	"github.com/phamtrung99/user-service/repository"
	"github.com/phamtrung99/auth-service/usecase"
	"github.com/phamtrung99/gopkg/middleware"
)

// NewHTTPHandler .
func NewHTTPHandler(repo *repository.Repository, ucase *usecase.UseCase) *echo.Echo {
	e := echo.New()
	cfg := config.GetConfig()

	skipper := func(c echo.Context) bool {
		p := c.Request().URL.Path

		return strings.Contains(p, "/login") ||
			strings.Contains(p, "/register")
	}
	e.Use(middleware.Auth(cfg.Jwt.Key, skipper, false))

	apiV1 := e.Group("/v1")

	auth.Init(apiV1.Group("/auth"), ucase)

	return e
}
