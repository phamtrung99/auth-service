package auth

import (
	"net/mail"

	"golang.org/x/crypto/bcrypt"
)

func HashPassword(password string) (string, error) {
	hashBytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)

	return string(hashBytes), err
}

func VerifyPassword(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))

	return err == nil
}

func ValidEmail(email string) bool {
	_, err := mail.ParseAddress(email)
	return err == nil
}