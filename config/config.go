package config

import (
	"fmt"
	"os"
	"strconv"
	"time"

	"github.com/joho/godotenv"
	"github.com/kelseyhightower/envconfig"
)

var config *Config

type Config struct {
	Stage       string `envconfig:"STAGE"`
	Debug       bool   `envconfig:"DEBUG"`
	AutoMigrate bool   `envconfig:"AUTO_MIGRATE"`
	Port        string `envconfig:"PORT"`
	CronJobFlag bool   `envconfig:"CRON_JOB_FLAG"`
	TimeZone    string `envconfig:"TIME_ZONE"`
	SwaggerHost string `envconfig:"SWAGGER_HOST"`

	Jwt struct {
		Key                   string `envconfig:"JWT_KEY"`
		RawTokenExpire        int    `envconfig:"JWT_TOKEN_EXPIRE"`
		RawRefreshTokenExpire int    `envconfig:"JWT_REFRESH_TOKEN_EXPIRE"`
		TokenExpire           time.Duration
		RefreshTokenExpire    time.Duration
	}

	Endpoints struct {
		DatadogAgentEndpoint string `envconfig:"DATADOG_AGENT_ENDPOINT"`
		HealthCheckEndPoint  string `envconfig:"HEALTH_CHECK_ENDPOINT"`
	}

	MySQL struct {
		Masters      []string `envconfig:"DB_MASTER_HOSTS"`
		Slaves       []string `envconfig:"DB_SLAVE_HOSTS"`
		DBName       string   `envconfig:"DB_NAME"`
		User         string   `envconfig:"DB_USER"`
		Pass         string   `envconfig:"DB_PASS"`
		MaxIdleConns int      `envconfig:"DB_MAX_IDLE_CONNECTIONS"`
		MaxOpenConns int      `envconfig:"DB_MAX_OPEN_CONNECTIONS"`
	}

	Redis struct {
		Host    string `envconfig:"REDIS_HOST"`
		Port    string `envconfig:"REDIS_PORT"`
		DB      int    `envconfig:"REDIS_DB"`
		User    string `envconfig:"REDIS_USER"`
		Pass    string `envconfig:"REDIS_PASS"`
		Timeout int    `envconfig:"REDIS_TIMEOUT"`
	}
}

//Use this init() when local env
func init() {
	config = &Config{}
	err := godotenv.Load(".env")

	if err != nil {
		config.Port = os.Getenv("PORT")

		if config.MySQL.MaxIdleConns == 0 {
			config.MySQL.MaxIdleConns = 10
		}

		if config.MySQL.MaxOpenConns == 0 {
			config.MySQL.MaxOpenConns = 10
		}

		config.MySQL.Masters = []string{os.Getenv("DB_MASTER_HOSTS")}
		config.MySQL.Slaves = []string{os.Getenv("DB_SLAVE_HOSTS")}
		config.MySQL.DBName = os.Getenv("DB_NAME")
		config.MySQL.User = os.Getenv("DB_USER")
		config.MySQL.Pass = os.Getenv("DB_PASS")
		config.MySQL.MaxIdleConns, _ = strconv.Atoi(os.Getenv("DB_MAX_IDLE_CONNECTIONS"))
		config.MySQL.MaxOpenConns, _ = strconv.Atoi(os.Getenv("DB_MAX_OPEN_CONNECTIONS"))

		config.Jwt.Key = os.Getenv("JWT_KEY")
		config.Jwt.RawTokenExpire, _ = strconv.Atoi(os.Getenv("JWT_TOKEN_EXPIRE"))

		config.Jwt.TokenExpire = time.Duration(config.Jwt.RawTokenExpire) * time.Hour

	} else {

		err = envconfig.Process("", config)

		if err != nil {
			panic(fmt.Sprintf("Failed to decode config env: %v", err))
		}

		if len(config.Port) == 0 {
			config.Port = "9000"
		}

		if config.MySQL.MaxIdleConns == 0 {
			config.MySQL.MaxIdleConns = 10
		}

		if config.MySQL.MaxOpenConns == 0 {
			config.MySQL.MaxOpenConns = 10
		}

		config.Jwt.TokenExpire = time.Duration(config.Jwt.RawTokenExpire) * time.Hour
		config.Jwt.RefreshTokenExpire = time.Duration(config.Jwt.RawRefreshTokenExpire) * time.Hour
	}
}

// GetConfig .
func GetConfig() *Config {
	return config
}
