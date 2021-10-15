package grpc

import (
	"context"

	"github.com/phamtrung99/auth-service/proto"
	"github.com/phamtrung99/auth-service/usecase/auth"
)

// AuthService .
type AuthService struct {
	proto.UnimplementedAuthServiceServer

	AuthUsecase auth.IUsecase
}

func (auth *AuthService) Login(ctx context.Context, req *proto.LoginRequest) (*proto.LoginResponse, error) {
	return &proto.LoginResponse{
		Token: "oke token",
	}, nil
}
