package middlewares

import (
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/phamtrung99/gopkg/middleware"
	"github.com/phamtrung99/gopkg/utils"
)

func CheckAdmin(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) error {

		ctx := &utils.CustomEchoContext{Context: c}
		//Get current userId from Token.
		claim := middleware.GetClaim(ctx)
		userID := claim.UserID

		if userID == 2 { //Id =2 is admin
			return next(c)
		}

		return c.JSON(http.StatusUnauthorized, map[string]string{
			"message": "Administrator Only !!!",
		})
	}
}
