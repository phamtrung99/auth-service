package auth

import (
	"github.com/labstack/echo/v4"
	"github.com/phamtrung99/auth-service/usecase"
	"github.com/phamtrung99/auth-service/usecase/auth"
)

type Route struct {
	authUseCase auth.IUsecase
}

func Init(group *echo.Group, useCase *usecase.UseCase) {
	r := &Route{
		authUseCase: useCase.Auth,
	}

	group.POST("/login", r.Login)
	group.POST("/register", r.Register)
}
