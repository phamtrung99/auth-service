package auth

import (
	"context"

	"github.com/phamtrung99/auth-service/package/auth"
	"github.com/phamtrung99/auth-service/util/myerror"
	checkform "github.com/phamtrung99/movie-service/package/checkForm"
	"github.com/phamtrung99/user-service/model"
	usermyerror "github.com/phamtrung99/user-service/util/myerror"
)

type RegisterRequest struct {
	FullName string `json:"full_name"`
	Email    string `json:"email"`
	Password string `json:"password"`
	Age      int    `json:"age"`
}

func (u *Usecase) Register(ctx context.Context, req RegisterRequest) (*model.User, error) {

	//Check mail format
	isMail, email := checkform.CheckFormatValue("email", req.Email)
	if !isMail {
		return &model.User{}, myerror.ErrEmailFormat(nil)
	}

	//Check password format
	isPass, password := checkform.CheckFormatValue("password", req.Password)
	if !isPass {
		return &model.User{}, myerror.ErrPasswordFormat(nil)
	}

	//Check fullname format
	isName, fullName := checkform.CheckFormatValue("full_name", req.FullName)
	if !isName {
		return &model.User{}, myerror.ErrFullNameFormat(nil)
	}

	passwHash, err := auth.HashPassword(password)

	if err != nil {
		return &model.User{}, myerror.ErrHashPassword(nil)
	}

	var user = &model.User{
		FullName: fullName,
		Email:    email,
		Password: passwHash,
		Age:      req.Age,
		Role:     "user",
	}

	result, err := u.userRepo.Create(ctx, user)

	if err != nil {
		return &model.User{}, usermyerror.ErrUserCreate(err)
	}

	return result, nil
}
