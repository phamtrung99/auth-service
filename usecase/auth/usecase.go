package auth

import (
	"github.com/phamtrung99/user-service/repository"
	"github.com/phamtrung99/user-service/repository/user"
)

type Usecase struct {
	userRepo user.Repository
}

// New .
func New(repo *repository.Repository) IUsecase {
	return &Usecase{
		userRepo: repo.User,
	}
}
