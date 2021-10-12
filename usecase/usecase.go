package usecase

import (
	"github.com/phamtrung99/user-service/repository"
	"github.com/phamtrung99/auth-service/usecase/auth"
)

type UseCase struct {
	Auth auth.IUsecase
}

func New(repo *repository.Repository) *UseCase {
	return &UseCase{
		Auth: auth.New(repo),
	}
}
