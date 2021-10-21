package mysql

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/phamtrung99/gopkg/logger"
	"github.com/phamtrung99/gopkg/utils"
	"github.com/phamtrung99/auth-service/config"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
	"gorm.io/plugin/dbresolver"
)

var (
	db *gorm.DB
)

func Init() {
	var (
		err             error
		cfg             = config.GetConfig()
		masterDialector gorm.Dialector
	)

	if len(cfg.MySQL.Masters) == 0 {
		panic("miss db info")
	}

	masterDialectors := make([]gorm.Dialector, 0)
	slaveDialectors := make([]gorm.Dialector, 0)

	for i, master := range cfg.MySQL.Masters {
		connectionString := fmt.Sprintf("%s:%s@(%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
			cfg.MySQL.User,
			cfg.MySQL.Pass,
			master,
			cfg.MySQL.DBName)

		dialector := mysql.New(mysql.Config{DSN: connectionString})

		if i == 0 {
			masterDialector = dialector
		} else {
			masterDialectors = append(masterDialectors, dialector)
		}
	}

	for _, slave := range cfg.MySQL.Slaves {
		if slave == "" {
			continue
		}

		connectionString := fmt.Sprintf("%s:%s@(%s)/%s?charset=utf8mb4&parseTime=True&loc=Local",
			cfg.MySQL.User,
			cfg.MySQL.Pass,
			slave,
			cfg.MySQL.DBName)

		dialector := mysql.New(mysql.Config{DSN: connectionString})

		slaveDialectors = append(slaveDialectors, dialector)
	}

	gormConfig := &gorm.Config{
		SkipDefaultTransaction: true,
		Logger:                 logger.NewGorm(!cfg.Debug),
	}

	db, err = gorm.Open(masterDialector, gormConfig)
	if err != nil {
		log.Fatal("Fail to connect db", err)
	}

	err = db.Use(dbresolver.Register(dbresolver.Config{
		Sources:  masterDialectors,
		Replicas: slaveDialectors,
		Policy:   dbresolver.RandomPolicy{},
	}))
	if err != nil {
		log.Fatal("Fail to register master slave dbs", err)
	}

	db = db.Debug()

	rawDB, _ := db.DB()
	rawDB.SetMaxIdleConns(cfg.MySQL.MaxIdleConns)
	rawDB.SetMaxOpenConns(cfg.MySQL.MaxOpenConns)
	rawDB.SetConnMaxLifetime(time.Minute * 1)

	log.Println("Connected db")
}

func GetClient(ctx context.Context) *gorm.DB {
	// use transaction per request
	if utils.IsEnableTx(ctx) {
		tx := utils.GetTx(ctx)

		return tx
	}

	return db.Session(&gorm.Session{})
}
