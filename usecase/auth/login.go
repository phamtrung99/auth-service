package auth

import (
	"context"

	"github.com/phamtrung99/movie-service/config"
	"github.com/phamtrung99/user-service/model"
	"github.com/phamtrung99/auth-service/package/auth"
	checkform "github.com/phamtrung99/movie-service/package/checkForm"
	"github.com/phamtrung99/auth-service/util/myerror"
	"github.com/phamtrung99/gopkg/middleware"
)

type LoginRequest struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

func (u *Usecase) Login(ctx context.Context, req LoginRequest) (string, error) {
	//Check mail format
	isMail, email := checkform.CheckFormatValue("email", req.Email)
	if !isMail {
		return "", myerror.ErrEmailFormat(nil)
	}

	//Check password format
	isPass, password := checkform.CheckFormatValue("password", req.Password)
	if !isPass {
		return "", myerror.ErrPasswordFormat(nil)
	}

	//Check mail exists
	user, err := u.userRepo.GetByEmail(ctx, email)

	if err != nil {
		return "", myerror.ErrLogin(err)
	}

	if (&model.User{}) == user {
		return "", myerror.ErrInvalid(nil)
	}

	//Check password is true.
	isPassTrue := auth.VerifyPassword(password, user.Password)

	if !isPassTrue {
		return "", myerror.ErrInvalid(nil)
	}

	//Generate token
	tokenService := middleware.NewTokenSvc(config.GetConfig().Jwt.Key)
	expireTime := config.GetConfig().Jwt.TokenExpire
	t, err := tokenService.Encode(user.ID, user.Email, "trung", expireTime)

	if err != nil {
		return "", myerror.ErrToken(nil)
	}

	return t, nil
}
