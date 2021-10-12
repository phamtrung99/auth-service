package auth

import (
	"errors"

	"github.com/labstack/echo/v4"
	"github.com/phamtrung99/auth-service/usecase/auth"
	"github.com/phamtrung99/gopkg/apperror"
	"github.com/phamtrung99/gopkg/utils"
)

func (r *Route) Login(c echo.Context) error {
	var (
		ctx      = &utils.CustomEchoContext{Context: c}
		appError = apperror.AppError{}
		req      = auth.LoginRequest{}
	)

	// Bind order by
	if err := c.Bind(&req); err != nil {
		_ = errors.As(err, &appError)

		return utils.Response.Error(ctx, apperror.ErrInvalidInput(err))
	}

	token, err := r.authUseCase.Login(ctx, req)
	if err != nil {
		_ = errors.As(err, &appError)

		return utils.Response.Error(ctx, appError)
	}

	return utils.Response.Success(ctx, token)
}
