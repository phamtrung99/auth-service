package migration

import (
	"context"
	"log"

	"github.com/pressly/goose"

	"github.com/phamtrung99/auth-service/client/mysql"
	"github.com/phamtrung99/auth-service/config"
)

func Up() {
	cfg := config.GetConfig()

	db := mysql.GetClient(context.Background())
	sqlDB, err := db.DB()

	if err != nil {
		log.Fatal("Fail to connect db", err)
	}

	if cfg.AutoMigrate {
		err := goose.SetDialect("mysql")
		if err != nil {
			panic(err)
		}

		err = goose.Run("up", sqlDB, "./migration")
		if err != nil {
			panic(err)
		}
	}
}
