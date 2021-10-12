package myerror

import (
	"net/http"

	"github.com/phamtrung99/gopkg/apperror"
)

// ErrAuthLogin .
func ErrEmailFormat(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000010,
		HTTPCode:  http.StatusNotAcceptable,
		Info:      "email format is wrong",
		Message:   "email format is wrong.",
	}
} 

func ErrPasswordFormat(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000011,
		HTTPCode:  http.StatusNotAcceptable,
		Info:      "password format is wrong",
		Message:   "password format is wrong.",
	}
}

func ErrFullNameFormat(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000012,
		HTTPCode:  http.StatusNotAcceptable,
		Info:      "fullname format is wrong",
		Message:   "fullname format is wrong.",
	}
}

func ErrLogin(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000020,
		HTTPCode:  http.StatusInternalServerError,
		Info:      "fail to login",
		Message:   "fail to login",
	}
}

func ErrInvalid(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000030,
		HTTPCode:  http.StatusNotAcceptable,
		Info:      "invalid email or password",
		Message:   "invalid email or password",
	}
}

func ErrToken(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000030,
		HTTPCode:  http.StatusInternalServerError,
		Info:      "generate token fail",
		Message:   "generate token fail",
	}
}

// ErrAuthRegister
func ErrHashPassword(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000040,
		HTTPCode:  http.StatusInternalServerError,
		Info:      "hash password fail",
		Message:   "hash password fail",
	}
}

func ErrExistedEmail(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000050,
		HTTPCode:  http.StatusInternalServerError,
		Info:      "email is existed",
		Message:   "email is existed",
	}
}

func ErrImage(err error) apperror.AppError {
	return apperror.AppError{
		Raw:       err,
		ErrorCode: 100000060,
		HTTPCode:  http.StatusInternalServerError,
		Info:      "file is not an image",
		Message:   "file is not an image",
	}
}
