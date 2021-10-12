package auth

import (
	"errors"

	"github.com/labstack/echo/v4"
	"github.com/phamtrung99/auth-service/usecase/auth"
	"github.com/phamtrung99/gopkg/apperror"
	"github.com/phamtrung99/gopkg/utils"
)

func (r *Route) Register(c echo.Context) error {
	var (
		ctx      = &utils.CustomEchoContext{Context: c}
		appError = apperror.AppError{}
		req      = auth.RegisterRequest{}
	)

	// Bind order by
	if err := c.Bind(&req); err != nil {
		_ = errors.As(err, &appError)

		return utils.Response.Error(ctx, apperror.ErrInvalidInput(err))
	}

	res, err := r.authUseCase.Register(ctx, req)
	if err != nil {
		_ = errors.As(err, &appError)

		return utils.Response.Error(ctx, appError)
	}

	return utils.Response.Success(ctx, res)
}
